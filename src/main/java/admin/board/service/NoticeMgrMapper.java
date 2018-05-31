package admin.board.service;
import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 공지사항(관리자용,일반사용자용)
 * 
 * @author  krc
 * @since 2016.03.07
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2016.03.07        			phk          	최초 생성
 * 
 */
@Mapper("noticeMgrMapper")
public interface NoticeMgrMapper {
	
	//공지사항 목록
	public List<?> noticeList(HashMap<String, Object> params) throws Exception;
	
	//총 갯수
	public int noticeListTotCnt(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//공지사항 등록
	public int noticeMgrInsert(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//공지사항 상세조회
	public List<?> noticeDetail(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//조회수 수정
	public int noticeUpdateReadNum(String noticeNum) throws Exception;
	
	//공지사항 업데이트
	public int noticeMgrUpdate(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//공지사항 등록
	public int noticeMgrDelete(String noticeNum) throws Exception;
	
}
