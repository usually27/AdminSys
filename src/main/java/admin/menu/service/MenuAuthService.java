package admin.menu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface MenuAuthService {

	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception;

	@Transactional
	public void menuAuthEditInsert(String menuNmChk, String authVal) throws Exception;

}
