package admin.board.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.board.service.NoticeMgrMapper;
import admin.board.service.NoticeMgrService;
import admin.board.service.NoticeMgrVO;

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
@Service("noticeMgrService")
public class NoticeMgrServiceImpl implements NoticeMgrService {
	
	@Resource(name = "noticeMgrMapper")
	private NoticeMgrMapper noticeMgrMapper;

	//회원목록
		@Override
		public List<?> noticeList(HashMap<String, Object> params) throws Exception {
			return noticeMgrMapper.noticeList(params);
		}

		//총갯수
		@Override
		public int noticeListTotCnt(NoticeMgrVO noticeMgrVO) throws Exception {
			return noticeMgrMapper.noticeListTotCnt(noticeMgrVO);
		}
		
		//공지사항 등록
		@Override
		public void noticeMgrInsert(NoticeMgrVO noticeMgrVO) throws Exception {
			noticeMgrMapper.noticeMgrInsert(noticeMgrVO);
		}
		
		//공제사항 상세조회
		@Override
		public List<?> noticeDetail(NoticeMgrVO noticeMgrVO) throws Exception {
			return noticeMgrMapper.noticeDetail(noticeMgrVO);
		}
		
		//조회수 업데이트
		@Override
		public void noticeUpdateReadNum(String noticeNum) throws Exception {
			noticeMgrMapper.noticeUpdateReadNum(noticeNum);
		}
		
		//공지사항 업데이트
		@Override
		public void noticeMgrUpdate(NoticeMgrVO noticeMgrVO) throws Exception {
			noticeMgrMapper.noticeMgrUpdate(noticeMgrVO);
		}
		
		//공지사항 삭제
		@Override
		public void noticeMgrDelete(String noticeNum) throws Exception {
			noticeMgrMapper.noticeMgrDelete(noticeNum);
		}

}
