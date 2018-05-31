package admin.member.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Transactional
public interface MemberInfoService {

	public List<?> memberInfoList(HashMap<String, Object> params) throws Exception;

	public int memberCnt(HashMap<String, Object> params) throws Exception;

	public void memberBlock(HashMap<String, Object> params) throws Exception;

	public int memberInfoRegIdchk(HashMap<String, Object> params) throws Exception;

	public void memberInfoInsert(HashMap<String, Object> params) throws Exception;

	public String generatePasswd() throws Exception;

	public EgovMap getMemberDetail(String userId) throws Exception;

	public void memberInfoPwdInit(HashMap<String, Object> params) throws Exception;

	public void memberInfoBlock(HashMap<String, Object> params) throws Exception;

	public void memberInfoDelete(HashMap<String, Object> params) throws Exception;

	public int memberInfoApproval(HashMap<String, Object> params) throws Exception;

	public int memberInfoDefer(HashMap<String, Object> params) throws Exception;

	public void memberInfoModifyMgr(HashMap<String, Object> params) throws Exception;

	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception;

	public void menuAuthEditInsert(String userId, String mappingIdVal, String roleId) throws Exception;

	public void memberAuthInit(String userId) throws Exception;

	public List<?> layerMemAuthList(HashMap<String, Object> params) throws Exception;

	public void layerMemAuthEditInsert(String userId, String mappingIdVal, String authVal, String chkIdxVal) throws Exception;

	public void layerMemAuthInit(String userId) throws Exception;

	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception;
	
	public List<?> logStatsList(HashMap<String, Object> params) throws Exception;
}
