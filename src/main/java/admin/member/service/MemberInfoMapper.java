package admin.member.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("memberInfoMapper")
public interface MemberInfoMapper {

	public List<?> memberInfoList(HashMap<String, Object> params) throws Exception;

	public int memberCnt(HashMap<String, Object> params) throws Exception;

	public void memberBlock(@Param("userId") String userId, @Param("flag")String flag) throws Exception;

	public int memberInfoRegIdchk(HashMap<String, Object> params) throws Exception;

	public void memberInfoInsert(HashMap<String, Object> params) throws Exception;

	public EgovMap getMemberDetail(String userId) throws Exception;

	public void memberInfoPwdInit(HashMap<String, Object> params) throws Exception;

	public void memberInfoBlock(HashMap<String, Object> params) throws Exception;

	public void memberInfoDelete(HashMap<String, Object> params) throws Exception;

	public int memberInfoApproval(HashMap<String, Object> params) throws Exception;

	public int memberInfoDefer(HashMap<String, Object> params) throws Exception;

	public void memberInfoModifyMgr(HashMap<String, Object> params) throws Exception;

	//메뉴 권한 리스트
	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception;

	//메뉴 권한 수정
	public void memberAuthSaveDel(String userId) throws Exception;

	public List<?> menuMappingList(@Param("roleId") String roleId) throws Exception;

	public void memberAuthSaveIst(@Param("userId") String userId, @Param("mappingIdVal") String mappingIdVal, @Param("useYn") String useYn) throws Exception;

	//레이어 권한 리스트
	public List<?> layerMemAuthList(HashMap<String, Object> params) throws Exception;

	//레이어 권한 수정
	public void layerMemAuthSaveDel(String userId) throws Exception;

	public List<?> layerMappingList(@Param("authVal") String authVal) throws Exception;

	public void layerMemAuthSave(@Param("userId") String userId, @Param("layerId") String layerId, @Param("readYn") String readYn, @Param("writeYn") String writeYn) throws Exception;

	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception;
	
	public List<?> logStatsList(HashMap<String, Object> params) throws Exception;
	
}
