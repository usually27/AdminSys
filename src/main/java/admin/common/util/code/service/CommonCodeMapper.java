package admin.common.util.code.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commonCodeMapper")
public interface CommonCodeMapper {

	public List<HashMap<String, String>> getCommonCode(Map<String, Object> param) throws Exception;
	public List<HashMap<String, String>> getCommonCode2(Map<String, Object> param) throws Exception;

//	public List<HashMap<String, String>> getSidoH(Map<String, Object> param) throws Exception;
//
//	public List<HashMap<String, String>> getGugunH(Map<String, Object> param) throws Exception;
//
//	public List<HashMap<String, String>> getUmdH(Map<String, Object> param) throws Exception;
//
	public List<HashMap<String, String>> getSidoB(Map<String, Object> param) throws Exception;

	public List<HashMap<String, String>> getGugunB(Map<String, Object> param) throws Exception;

	public List<HashMap<String, String>> getUmdB(Map<String, Object> param) throws Exception;

	public List<HashMap<String, String>> getRiB(Map<String, Object> param) throws Exception;

	public List<HashMap<String, String>> getAuthCode(Map<String, Object> param) throws Exception;

}
