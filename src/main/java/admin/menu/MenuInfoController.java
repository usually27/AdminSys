/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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

import admin.common.annotation.AuthHandler;
import admin.menu.service.MenuInfoComboVO;
import admin.menu.service.MenuInfoService;
import admin.menu.service.MenuInfoVO;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 메뉴관리
 *
 * @author  phk
 * @since 2015.11.25
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2015.11.25        			phk          	최초 생성
 *
 * </pre>
 */
@Controller
public class MenuInfoController {

	@Resource(name = "menuInfoService")
	private MenuInfoService menuInfoService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthInfoController.class);

	//메뉴리스트 초기화면호출
	@RequestMapping(value = "/menu/menuInfo.do")
	public String baseMenuList() throws Exception {

		return "menu/menuList";
	}

	//메뉴추가팝업
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value = "/menu/menuInfoRegPopup.do")
	public String menuRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);

		return "menu/menuInfoRegPop";
	}


	//메뉴 목록
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/menuInfoList", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap menuInfoList(MenuInfoVO menuInfoVO, ModelMap model) throws Exception {
		//메뉴목록조회
		List<?> resultMenuList = menuInfoService.menuInfoList(menuInfoVO);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultMenuList);
		System.out.println(resultMenuList);
		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	//대메뉴콤보
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/menuInfoParseCombo", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap menuInfoParseLvlCombo( ModelMap model) throws Exception {
		//메뉴리스트조회
		List<MenuInfoComboVO> resultMenuCombo = menuInfoService.menuInfoParseLvlCombo();

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);
		jsonMap.put("result_list", resultMenuCombo);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	//중메뉴콤보
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/menuInfoLevel2Combo", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap menuInfoLevel2Combo(MenuInfoComboVO menuInfoComboVO, ModelMap model) throws Exception {
		//메뉴리스트조회
		List<MenuInfoComboVO> resultMenuL2Combo = menuInfoService.menuInfoLevel2Combo(menuInfoComboVO);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);
		jsonMap.put("result_list", resultMenuL2Combo);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}


	//메뉴 등록/수정 , 주의: depth 5단계까지만 구성함
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/menuInfoRegPopup", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap menuInfoUpdate(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		menuInfoService.updateMenu(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		model.addAttribute("jsonView", jsonMap);

		return model;
	}

	//메뉴삭제
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/menuInfoDelete", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String deleteMenu(MenuInfoVO menuInfoVO, ModelMap model) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try{
			menuInfoService.deleteMenu(menuInfoVO);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			LOGGER.debug("error....................{}",e);
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap);

		return "menu/menuInfo";
	}


	//메뉴이동
	@AuthHandler(handler="baseMenuList")
	@RequestMapping(value="/menu/moveMenuInfo", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap moveMenu(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		int rtnValue = 0;
		rtnValue = menuInfoService.menuMoveUdt(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		jsonMap.put("move_result",  rtnValue);
		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}
}
