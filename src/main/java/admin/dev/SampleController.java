package admin.dev;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.dev.service.SampleService;

@Controller
public class SampleController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);

	@Resource(name = "sampleService")
	private SampleService masterService;

	/**
	 * 샘플 페이지
	 * @param params
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dev/sample.do")
	public String indexPage(@RequestParam HashMap<String, Object> params, ModelMap model) throws Exception{

		List<?> resultList = masterService.selectInfoList(params);

		model.addAttribute("resultList", resultList);

		return "dev/sample";
	}




}