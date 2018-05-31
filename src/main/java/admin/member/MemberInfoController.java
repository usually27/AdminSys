package admin.member;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.common.encrypt.PasswordEncrypt;
import admin.member.service.MemberInfoService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
public class MemberInfoController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberInfoController.class);

	@Resource(name = "memberInfoService")
	private MemberInfoService memberInfoService;

//	@AuthExclude
	@RequestMapping(value = "/member/memberInfo.do")
	public String baseMemberInfo() throws Exception{

		return "member/memberInfo";
	}

	// 사용자 리스트 조회
	@RequestMapping(value = "/member/memberInfoList", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap memberInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rows = Integer.parseInt(params.get("rows").toString());
		int page = Integer.parseInt(params.get("page").toString());

		int limit = rows * page - rows;
		params.put("rows", rows);
		params.put("limit", limit);

		// 리스트조회
		List<?> resultList = memberInfoService.memberInfoList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		jsonMap.put("success", true);
		jsonMap.put("root", resultList);

		// 리스트 개수
		int count = memberInfoService.memberCnt(params);
		double total = 0;

		if(count > 0) {
			total = Math.ceil(count/rows) + 1;
		}

		jsonMap.put("page", page);
		jsonMap.put("records", count);
		jsonMap.put("total", total);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	// 사용자 접속 차단/해제
	@RequestMapping(value = "/member/memberBlock", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberBlock(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);

		try {
			memberInfoService.memberBlock(params);
			jsonMap.put("respFlag", "Y");
		} catch(Exception e) {
			LOGGER.debug("########## 작업 실패!!! ##########{}", e.toString());
			jsonMap.put("respFlag", "N");
		}

		model.addAttribute("jsonView", jsonMap);
		return model;
	}

	// 사용자 정보 등록
	@RequestMapping(value = "/member/memberInfoRegPopup.do")
	public String memberInfoRegPopup(HttpServletRequest request) throws Exception{
		request.setAttribute("flag", "insert");

		return "member/memberInfoRegPop";
	}

	// 사용자 ID 중복 체크
	@RequestMapping(value = "/member/memberInfoRegIdchk", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoRegIdchk(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int idCount = memberInfoService.memberInfoRegIdchk(params);
		String idCheck = "Y";

		if(idCount>0){
			idCheck = "N";
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		jsonMap.put("success",  true);
		jsonMap.put("result_string", idCheck);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 정보 등록
	@RequestMapping(value = "/member/memberInfoReg", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoInst2(@RequestParam HashMap<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {

		String userIp = request.getHeader("X-FORWORDED-FOR");

		if(userIp == null || userIp.length() == 0) {
			userIp = request.getRemoteAddr();
		}

		params.put("userIp", userIp);

		String resultMsg = "사용자 등록에 실패하였습니다.";
		String instFlag = "N";

		params.put("insertCase", "Y");	//관리자 등록일 경우 Y, 회원가입일 경우 N

		String telephone = params.get("telephone1").toString() + "-" + params.get("telephone2").toString();
		params.put("userTel", telephone);

		String flag = params.get("flag").toString();

		String pwd = "";

		if("insert".equals(flag)) {
			pwd = PasswordEncrypt.cryptPassword((String)params.get("user_pwd1"));
		} else {
			pwd = PasswordEncrypt.cryptPassword((String)params.get("userPwd"));
		}

		params.put("userPwd", pwd);

		try {
			memberInfoService.memberInfoInsert(params);
			resultMsg = "사용자 등록에 성공하였습니다.";
			instFlag = "Y";
		} catch(Exception e) {
			LOGGER.debug("사용자 등록에 실패하였습니다::::"+e.toString());
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);
		jsonMap.put("resultMsg", resultMsg);
		jsonMap.put("instFlag", instFlag);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 정보 수정
	@RequestMapping(value = "/member/memberInfoModPopup.do")
	public String memberInfoModPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String userId = params.get("userId").toString();
		String gubunflag = params.get("gubunflag").toString();

		if("modifyMgr".equals(gubunflag)) {
			model.addAttribute("initPass", memberInfoService.generatePasswd());
		}

		EgovMap memberDetail = memberInfoService.getMemberDetail(userId);

		model.addAttribute("flag", gubunflag);
		model.addAttribute("memberDetailData", memberDetail);

		return "member/memberInfoModPop";
	}

	// 사용자 비밀번호 초기화
	@RequestMapping(value = "/member/memberInfoPwdInit", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoPwdInit(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String rstFlag = "N";
		String rstMsg = "비밀번호 초기화에 실패하였습니다.";

		String userPwd = PasswordEncrypt.cryptPassword((String)params.get("userPwd"));
		params.put("userPwd", userPwd);

		try {
			memberInfoService.memberInfoPwdInit(params);
			rstFlag = "Y";
			rstMsg = "비밀번호를 성공적으로 초기화 하였습니다.";
		} catch(Exception e) {
			LOGGER.debug("########## 비밀번호 초기화에 실패하였습니다. ##########{}", e.toString());
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);
		jsonMap.put("rstFlag", rstFlag);
		jsonMap.put("result_string", rstMsg);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 접속 차단
	@RequestMapping(value = "/member/memberInfoBlock", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoBlock(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		memberInfoService.memberInfoBlock(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 정보 삭제
	@RequestMapping(value = "/member/memberInfoDelete", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoDelete(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		try {
			memberInfoService.memberInfoDelete(params);
		} catch(Exception e) {
			LOGGER.debug("########## 사용자 삭제 실패!!! ##########{}", e.toString());
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 등록 승인
	@RequestMapping(value = "/member/memberInfoApproval", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoApproval(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rstCnt = 0;
		rstCnt = memberInfoService.memberInfoApproval(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);
		jsonMap.put("rstCnt", rstCnt);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 등록 승인 보류
	@RequestMapping(value = "/member/memberInfoDefer", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoDefer(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rstCnt = 0;
		rstCnt = memberInfoService.memberInfoDefer(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);
		jsonMap.put("rstCnt", rstCnt);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 정보 수정
	@RequestMapping(value = "/member/memberInfoMod", method=RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_VALUE})
	public ModelMap memberInfoRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String resultMsg = "사용자 정보 수정에 실패하였습니다.";
		String instFlag = "N";

		params.put("insertCase", "Y");

		String telephone = params.get("telephone1").toString() + "-" + params.get("telephone2").toString();
		params.put("userTel", telephone);

		String userPwd = params.get("pwd").toString();
		if(!"".equals(userPwd)) {
			userPwd = PasswordEncrypt.cryptPassword(userPwd);
		}
		params.put("userPwd", userPwd);

		try {
			memberInfoService.memberInfoModifyMgr(params);
			resultMsg = "사용자 정보가 성공적으로 수정되었습니다.";
			instFlag = "M";
		} catch(Exception e) {
			LOGGER.debug("########## 사용자 정보 수정에 실패하였습니다 ##########{}", e.toString());
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success", true);
		jsonMap.put("resultMsg", resultMsg);
		jsonMap.put("instFlag", instFlag);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	// 사용자 메뉴 권한 수정
	@RequestMapping(value = "/member/memberAuthModPopup.do")
	public String memberAuthModPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);
		return "member/memberMenuAuthPop";
	}

	// 사용자 메뉴 권한 리스트 조회
	@RequestMapping(value = "/member/menuAuthList", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap menuAuthList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		//리스트조회
		List<?> resultList = memberInfoService.menuAuthList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	// 사용자 메뉴 권한 수정
	@RequestMapping(value="/member/menuAuthEdit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String menuAuthEdit(ModelMap model, String userId, String mappingIdVal, String roleId, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		String respFlag = "N";

		try{
			memberInfoService.menuAuthEditInsert(userId, mappingIdVal, roleId);
			respFlag = "Y";
		}catch(Exception e){
			LOGGER.debug("######### 사용자 권한 정보 수정에 실패하였습니다 ##########{}", e.toString());
		}
		jsonMap.put("respFlag", respFlag);

		model.addAttribute("jsonView", jsonMap);
		return "admin/member/memberMenuAuthPop";
	}

	// 사용자 메뉴 권한 초기화
	@RequestMapping(value="/member/memberAuthInit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String memberAuthInit(ModelMap model, String userId, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		String respFlag = "N";

		try{
			memberInfoService.memberAuthInit(userId);
			respFlag = "Y";
		}catch(Exception e){
			LOGGER.debug("######### 사용자 권한 정보 초기화에 실패하였습니다 ##########{}", e.toString());
		}
		jsonMap.put("respFlag", respFlag);

		model.addAttribute("jsonView", jsonMap);
		return "admin/member/memberMenuAuthPop";
	}

	// 사용자 레이어 권한 수정
	@RequestMapping(value = "/member/layerAuthModPopup.do")
	public String layerAuthModPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);
		return "member/memberLayerAuthPop";
	}

	// 사용자 레이어 권한 리스트 조회
	@RequestMapping(value = "/member/layerMemAuthList", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap layerMemAuthList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		//리스트조회
		List<?> resultList = memberInfoService.layerMemAuthList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	// 사용자 레이어 권한 수정
	@RequestMapping(value="/member/layerMemAuthEdit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String layerMemAuthEdit(ModelMap model, String userId, String mappingIdVal, String chkIdxVal, String authVal, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		String respFlag = "N";

		try{
			memberInfoService.layerMemAuthEditInsert(userId, mappingIdVal, authVal, chkIdxVal);
			respFlag = "Y";
		}catch(Exception e){
			LOGGER.debug("######### 사용자 레이어 권한 정보 수정에 실패하였습니다 ##########{}", e.toString());
		}
		jsonMap.put("respFlag", respFlag);

		model.addAttribute("jsonView", jsonMap);
		return "admin/layer/memberLayerAuthPop";
	}

	// 사용자 레이어 권한 초기화
	@RequestMapping(value="/member/layerMemAuthInit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String layerMemAuthInit(ModelMap model, String userId, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		String respFlag = "N";

		try{
			memberInfoService.layerMemAuthInit(userId);
			respFlag = "Y";
		}catch(Exception e){
			LOGGER.debug("######### 사용자 레이어 권한 정보 초기화에 실패하였습니다 ##########{}", e.toString());
		}
		jsonMap.put("respFlag", respFlag);

		model.addAttribute("jsonView", jsonMap);
		return "admin/menu/memberLayerAuthPop";
	}
	

//	@AuthExclude
	@RequestMapping(value = "/log/userLog.do")
	public String baseLogInfo() throws Exception{

		return "log/selectInfoList";
	}
	
	@RequestMapping(value="/log/selectInfoList", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap selectInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		int rows = Integer.parseInt(params.get("rows").toString());
		int page = Integer.parseInt(params.get("page").toString());

		int limit = rows * page - rows;
		params.put("rows", rows);
		params.put("limit", limit);
		//리스트조회
		List<?> resultList = memberInfoService.selectInfoList(params);
		//데이터 총 개수
		double totalPage = 0.0;
		Long totalRows = Long.valueOf(((EgovMap) resultList.get(0)).get("totalrows").toString());

		if (totalRows > 0) {
			totalPage = Math.ceil(totalRows / rows) + 1;
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("records", totalRows);
		jsonMap.put("total", totalPage);
		jsonMap.put("page", page);
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}
	
//	@AuthExclude
	@RequestMapping(value = "/log/logStats.do")
	public String baseStatsInfo() throws Exception{
		return "log/logStatsList";
	}
	
	@RequestMapping(value="/log/logStatsList", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap logStatsList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		//리스트조회
		List<?> resultList = memberInfoService.logStatsList(params);
		//데이터 총 개수
		
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);
		
		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

}