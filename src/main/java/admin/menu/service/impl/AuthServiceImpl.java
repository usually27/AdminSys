package admin.menu.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.menu.service.AuthInfoMapper;
import admin.menu.service.AuthInfoService;

@Service("authInfoService")
public class AuthServiceImpl implements AuthInfoService {

	@Resource(name = "authInfoMapper")
	private AuthInfoMapper authInfoMapper;

	@Override
	public List<?> authInfoList(HashMap<String, Object> params) throws Exception {
		return authInfoMapper.authInfoList(params);
	}

	@Override
	public void authInfoInsert(HashMap<String, Object> params) throws Exception {
		authInfoMapper.authInfoInsert(params);
	}

	@Override
	public void authInfoUpdate(HashMap<String, Object> params) throws Exception {
		authInfoMapper.authInfoUpdate(params);
	}

	@Override
	public void authDelete(HashMap<String, Object> params) throws Exception {
		authInfoMapper.authDelete(params);
	}

}
