package admin.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;


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
public interface NoticeMgrService {
	//목록조회
	public List<?> noticeList(HashMap<String, Object> params) throws Exception;
	public int noticeListTotCnt(NoticeMgrVO noticeMgrVO) throws Exception;

	//공지사항관리 등록
	@Transactional
	public void noticeMgrInsert(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//공지사항 상세조회
	public List<?> noticeDetail(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//조회수 업데이트
	@Transactional
	public void noticeUpdateReadNum(String noticeNum) throws Exception;
	
	//공지사항 관리 업데이트
	@Transactional
	public void noticeMgrUpdate(NoticeMgrVO noticeMgrVO) throws Exception;
	
	//공지사항 삭제
	@Transactional
	public void noticeMgrDelete(String noticeNum) throws Exception;

}
