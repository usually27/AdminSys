package admin.menu.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("menuAuthMapper")
public interface MenuAuthMapper {

	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception;

	//메뉴권한 수정
	public void menuAuthEditDelete(String authVal) throws Exception;

	public void menuAuthEditInsert(@Param("menuNmChk") String menuNmChk, @Param("authVal")String authVal) throws Exception;

}
