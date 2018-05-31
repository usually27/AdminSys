package admin.dev.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.dev.service.SampleMapper;
import admin.dev.service.SampleService;

@Service("sampleService")
public class SampleServiceImpl implements SampleService {

	@Resource(name = "sampleMapper")
	private SampleMapper masterMapper;

	@Override
	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception {
		return masterMapper.selectInfoList(params);
	}

}
