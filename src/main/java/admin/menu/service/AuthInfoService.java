package admin.menu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface AuthInfoService {

	public List<?> authInfoList(HashMap<String, Object> params) throws Exception;

	public void authInfoInsert(HashMap<String, Object> params) throws Exception;

	public void authInfoUpdate(HashMap<String, Object> params) throws Exception;

	public void authDelete(HashMap<String, Object> params) throws Exception;

}
