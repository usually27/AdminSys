package admin.dev.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface SampleService {

	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception;
}
