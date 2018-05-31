package admin.code;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.code.service.CodeMngService;
import admin.common.annotation.AuthHandler;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 시스템관리 > 코드관리를 처리하는 Controller 클래스
 *
 * @author 공간정보기술(주)
 * @since 2017.10.04
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *      수정일                   수정자                   수정내용
 *  ------------       ----------------    ---------------------------
 *   2017.10.04     공간정보기술(주)            최초 생성
 *
 *      </pre>
 */
@Controller
public class CodeMngController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CodeMngController.class);

	@Resource(name = "codeMngService")
	private CodeMngService masterService;

	/**
	 * 시스템관리 > 코드관리 초기 페이지
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/code/selectInfoList.do")
	public String initListPage() throws Exception {
		return "code/selectInfoList";
	}

	/**
	 * 시스템관리 > 코드관리 리스트 조회
	 *
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 
	@RequestMapping(value = "/code/selectInfoList.json", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap selectInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rows = Integer.parseInt(params.get("rows").toString());
		int page = Integer.parseInt(params.get("page").toString());

		params.put("rows", rows);
		params.put("page", page);

		// 리스트조회
		List<?> resultList = masterService.selectInfoList(params);

		double totalPage = 0.0;
		Long totalRows = 0L;

		if (resultList.size() > 0) {
			totalRows = Long.valueOf(((EgovMap) resultList.get(0)).get("totalrows").toString());
			totalPage = Math.ceil(totalRows / rows) + 1;
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("records", totalRows); // 총 개수
		jsonMap.put("total", totalPage); // 총 페이지 수
		jsonMap.put("page", page); // 현재 페이지
		jsonMap.put("root", resultList); // 리스트

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	/**
	 * 시스템관리 > 코드관리 >  등록 수정, 상세조회 창
	 *
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 
	@RequestMapping(value = "/code/selectCUInfoPop.do")
	public String initModalPage(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		String method = (String) params.get("method");

		if ("update".equals(method)) {
			EgovMap result = masterService.selectInfo(params);
			model.addAttribute("result", result);

			model.addAttribute("params", params);

			return "code/selectCUInfoPop";

		}else{
			model.addAttribute("params", params);

			return "code/insertInfoPop";
		}


	}



	
	@RequestMapping(value="/code/SearchPop.do")
	public String SearchPop(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);
		return "code/findInfoPop";
		}
	/**
	 * 시스템관리 > 코드관리 > 등록, 수정, 삭제
	 *
	 * @param method
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 
	@RequestMapping(value = "/code/{method}Info", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap cudInfo(@PathVariable String method, @RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try {
			if ("insert".equals(method)) {
				masterService.insertInfo(params);
			} else if ("update".equals(method)) {
				masterService.updateInfo(params);
			} else {
				masterService.deleteInfo(params);
			}

			jsonMap.put("respFlag", "Y");

		} catch (Exception ex) {
			LOGGER.debug(ex.toString());
			jsonMap.put("respFlag", "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}
}