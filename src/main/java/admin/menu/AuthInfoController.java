package admin.menu;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.menu.service.AuthInfoService;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.08.31  JJY            최초 생성
 *
 * </pre>
 */
@Controller
public class AuthInfoController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthInfoController.class);

	@Resource(name = "authInfoService")
	private AuthInfoService authInfoService;

//	@AuthExclude
	@RequestMapping(value = "/menu/authInfo.do")
	public String baseAuthInfo() throws Exception{
		return "menu/authInfo";
	}

	@RequestMapping(value = "/menu/authInfoList", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap authInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		List<?> resultList = authInfoService.authInfoList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/menu/authRegPopup.do")
	public String authPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "menu/authRegPop";
	}

	@RequestMapping(value="/menu/authRegPopup", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap authRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String workGuBun = (String)params.get("workGubun");

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try{
			if("insert".equals(workGuBun)){
				authInfoService.authInfoInsert(params);
				LOGGER.debug("등록 프로세스 시작..........");
			}else{
				authInfoService.authInfoUpdate(params);
				LOGGER.debug("수정 프로세스 시작..........");
			}
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/menu/authDelete", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap authDelete(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try {
			authInfoService.authDelete(params);
			jsonMap.put("respFlag", "Y");
		} catch(Exception e) {
			LOGGER.debug("error.............................{}", e.toString());
			jsonMap.put("respFlag", "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

}