package admin.common.util.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.common.annotation.AuthExclude;
import admin.common.util.code.service.CommonCodeService;

@Controller
public class CommonCodeController {

	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;

	@AuthExclude
	@RequestMapping(value="/common/util/code/combobox.json", method=RequestMethod.GET, produces={MediaType.APPLICATION_JSON_VALUE})
	public ModelMap comboboxJson(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {

		ArrayList<String[]> rslt = new ArrayList<String[]>(); // JSON 리턴값

		List<HashMap<String, String>> codeList = commonCodeService.getCodeList(params);

		for (int i = 0; i < codeList.size(); i++) {
			HashMap<String, String> map = codeList.get(i);
			rslt.add(new String[]{map.get("VALUE"), map.get("NAME")});
		}

		model.addAttribute("jsonView", rslt);
		return model;
	}

}
