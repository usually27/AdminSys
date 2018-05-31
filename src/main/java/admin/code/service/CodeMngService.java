package admin.code.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 시스템관리 > 코드관리를 처리하는 Service 인터페이스
 *
 * @author 공간정보기술(주)
 * @since 2017.10.04
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *      수정일                   수정자                   수정내용
 *  ------------       ----------------    ---------------------------
 *   2017.10.04     공간정보기술(주)            최초 생성
 *
 *      </pre>
 */
public interface CodeMngService {

	/**
	 * 시스템관리 > 코드관리 리스트
	 *
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception;

	/**
	 * 시스템관리 > 코드관리 > 상세 조회
	 *
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public EgovMap selectInfo(HashMap<String, Object> params) throws Exception;

	/**
	 * 시스템관리 > 코드관리 > 등록
	 *
	 * @param params
	 * @throws Exception
	 */
	public void insertInfo(HashMap<String, Object> params) throws Exception;

	/**
	 * 시스템관리 > 코드관리 > 수정
	 *
	 * @param params
	 * @throws Exception
	 */
	public void updateInfo(HashMap<String, Object> params) throws Exception;

	/**
	 * 시스템관리 > 코드관리 > 삭제
	 *
	 * @param params
	 * @throws Exception
	 */
	public void deleteInfo(HashMap<String, Object> params) throws Exception;
}
