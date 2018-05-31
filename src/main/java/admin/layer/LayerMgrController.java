/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http:/www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package admin.layer;

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

import admin.layer.service.LayerMgrService;
import admin.menu.MenuAuthController;


/**
 * 레이어 관리 요청을 처리하는 Controller 클래스
 *
 * @author phk
 * @since 2015.11.03
 * @version 1.0
 * @see
 * <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2015.11.03        phk          최초 생성
 *
 * </pre>
 */
@Controller
public class LayerMgrController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MenuAuthController.class);

	@Resource(name = "layerMgrService")
	private LayerMgrService layerMgrService;

	/**
	 * 리스트 초기화면.
	 * @return "/layer/layerInfo"
	 * @throws Exception
	 */
	@RequestMapping(value = "/layer/layerInfo.do")
	public String baseLayerList() throws Exception {

		return "/layer/layerInfo";
	}

	@RequestMapping(value="/layer/layerList.json", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap layerList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		//레이어 리스트 조회
		List<?> resultLayerList = layerMgrService.layerList(params);

		int listSize = 0;
		if(resultLayerList !=null){
			listSize = resultLayerList.size();
		}

		System.out.println("---------listSize---------::"+Integer.toString(listSize));

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);
		jsonMap.put("total_count", listSize);
		jsonMap.put("root", resultLayerList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/layer/layerRegPopup.do")
	public String layerRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "layer/layerRegPop";
	}

	@RequestMapping(value="/layer/layerInfoSave", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap layerInfoSave(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String workGuBun = (String)params.get("workGubun");

		if("insert".equals(workGuBun)){
			layerMgrService.insertLayer(params);
		}else{
			layerMgrService.updateLayer(params);
			layerMgrService.updateLayerMenu(params);
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/layer/layerInfoDelete",method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap layerInfoDelete(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try{
			layerMgrService.deleteLayer(params);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/layer/layerMenu.do")
	public String layerMenu(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "layer/layerMenuList";
	}

	@RequestMapping(value="/layer/layerInfoList", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap layerMenuInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		//메뉴목록조회
		List<?> resultMenuList = layerMgrService.menuInfoList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultMenuList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/layer/layerMenuRegPopup.do")
	public String layerMenuRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "layer/layerMenuRegPop";
	}

	@RequestMapping(value="/layer/updateLayerMenu", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap updateLayerMenu(@RequestParam HashMap<String, Object> params,  ModelMap model) throws Exception {

		layerMgrService.updateMenu(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	@RequestMapping(value="/layer/deleteLayerMenu", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap deleteMenuInfo(@RequestParam HashMap<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try{
			layerMgrService.deleteLayerMenu(params);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	@RequestMapping(value = "/layer/layerSearchPopup.do")
	public String layerSearchPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "layer/layerSearchPop";
	}

	@RequestMapping(value = "/layer/layerSearchList", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap layerInfoList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		List<?> resultList = layerMgrService.layerSearchList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	@RequestMapping(value="/layer/moveMenuInfo", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap moveMenu(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rtnValue = 0;
		rtnValue = layerMgrService.menuMoveUdt(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		jsonMap.put("move_result",  rtnValue);
		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	@RequestMapping(value="/layer/layerAuth.do")
	public String layerAuthInfo(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);

		return "layer/layerAuthList";
	}

	@RequestMapping(value="/layer/layerAuthList", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap layerAuthList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		List<?> resultList = layerMgrService.layerAuthList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	@RequestMapping(value="/layer/layerAuthEdit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String layerAuthEdit(ModelMap model, String mappingIdVal, String authVal, String chkIdxVal, HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		LOGGER.debug("mappingIdVal : " +mappingIdVal);
		LOGGER.debug("chkIdxVal : " +chkIdxVal);
		LOGGER.debug("authVal : " +authVal);

		try{
			layerMgrService.layerAuthEditInsert(mappingIdVal, authVal, chkIdxVal);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap);

		return "layer/layerAuthList";
	}

}
