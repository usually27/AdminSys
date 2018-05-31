package admin.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.menu.service.MenuAuthMapper;
import admin.menu.service.MenuAuthService;

@Service("menuAuthService")
public class MenuAuthServiceImpl implements MenuAuthService {

	@Resource(name = "menuAuthMapper")
	private MenuAuthMapper masterMapper;

	@Override
	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception {
		return masterMapper.menuAuthList(params);
	}

	@Override
	public void menuAuthEditInsert(String menuNmChk, String authVal) throws Exception {
		//삭제후 저장
		masterMapper.menuAuthEditDelete(authVal);

		if(!"".equals(menuNmChk) &&  menuNmChk != null){
			StringTokenizer st = new StringTokenizer(menuNmChk, ",");
			while (st.hasMoreTokens()) {
				masterMapper.menuAuthEditInsert(st.nextToken(),authVal);
			}
		}
	}

}
