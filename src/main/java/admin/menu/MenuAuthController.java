package admin.menu;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.common.annotation.AuthHandler;
import admin.menu.service.MenuAuthService;

@Controller
public class MenuAuthController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MenuAuthController.class);

	@Resource(name = "menuAuthService")
	private MenuAuthService masterService;

	@RequestMapping(value = "/menu/menuAuth.do")
	public String indexPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		return "/menu/menuAuthList";
	}

	@AuthHandler(handler="indexPage")
	@RequestMapping(value = "/menu/menuAuthList", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelMap menuAuthList(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception {

		//리스트조회
		List<?> resultList = masterService.menuAuthList(params);

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("root", resultList);
//
		model.addAttribute("jsonView", jsonMap); // JSON으로 리턴하기 위해서는 모델키를 'jsonView'로 지정해야함
		return model;
	}

	@AuthHandler(handler="indexPage")
	@RequestMapping(value="/menu/menuAuthEdit", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
	public String menuAuthEdit(ModelMap model, String mappingIdVal, String authVal,HttpServletRequest request) throws Exception {

		HashMap<String, Object> jsonMap = new HashMap<String, Object>();

		LOGGER.debug("mappingIdVal : " +mappingIdVal);
		LOGGER.debug("authVal : " +authVal);

		try{
			masterService.menuAuthEditInsert(mappingIdVal,authVal);
			jsonMap.put("respFlag",  "Y");
		}catch(Exception e){
			jsonMap.put("respFlag",  "N");
		}

		model.addAttribute("jsonView", jsonMap);

		return "admin/menu/menuAuth";
	}
}