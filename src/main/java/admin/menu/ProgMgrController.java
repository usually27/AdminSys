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
package admin.menu;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.common.annotation.AuthHandler;
import admin.menu.service.ProgMgrService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 프로그램 관리 요청을 처리하는 Controller 클래스
 *
 */
@Controller
public class ProgMgrController {

	@Resource(name = "progMgrService")
	private ProgMgrService progMgrService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	//프로그램리스트 초기화면
	@RequestMapping(value = "/menu/programList.do")
	public String baseProgList() throws Exception {
		return "/menu/programList";
	}

	//프로그램 등록/수정 팝업
	@AuthHandler(handler="baseProgList")
	@RequestMapping(value = "/menu/progRegPopup.do")
	public String progRegPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		model.addAttribute("params", params);
		return "/menu/progRegPop";
	}

	//프로그램 등록/수정
	@RequestMapping(value="/menu/progInfoSave", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap progInfoSave(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		String workGuBun = (String)params.get("workGubun");

		if("insert".equals(workGuBun)){
			progMgrService.insertProg(params);
		}else{
			progMgrService.updateProg(params);
			progMgrService.updateProgMenu(params);
		}

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	//프로그램 리스트 조회
	@AuthHandler(handler="baseProgList")
	@RequestMapping(value="/menu/progList.json", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap menuList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		//메뉴리스트조회
		List<?> resultProgList = progMgrService.progList(params);

		int listSize = 0;
		if(resultProgList !=null){
			listSize = resultProgList.size();
		}

		System.out.println("---------listSize---------::"+Integer.toString(listSize));

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);
		jsonMap.put("total_count", listSize);
		jsonMap.put("root", resultProgList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	// 프로그램 삭제
	@AuthHandler(handler="baseProgList")
	@RequestMapping(value="/menu/progDelete",method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap deleteProg(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		try{
			progMgrService.deleteProg(params);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

	// 프로그램목록 조회팝업
	@AuthHandler(handler="baseProgList")
	@RequestMapping(value = "/menu/progSearchPopup.do")
	public String progSearchPopup(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		model.addAttribute("params", params);

		return "/menu/progSearchPop";
	}

	// 프로그램조회팝업 리스트
	@AuthHandler(handler="baseProgList")
	@RequestMapping(value="/menu/progSearchPopup", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap progSearchList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {
		//메뉴리스트조회
		List<?> resultProgList = progMgrService.progSearchList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultProgList);

		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함

		return model;
	}

}
