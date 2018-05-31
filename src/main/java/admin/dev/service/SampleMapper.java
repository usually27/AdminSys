package admin.dev.service;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("sampleMapper")
public interface SampleMapper {

	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception;
}
