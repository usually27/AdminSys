package admin.code.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.code.service.CodeMngMapper;
import admin.code.service.CodeMngService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 시스템관리 > 코드관리 요청을 처리하는 비즈니스(ServiceImpl) 클래스
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
@Service("codeMngService")
public class CodeMngServiceImpl implements CodeMngService {

	@Resource(name = "codeMngMapper")
	private CodeMngMapper masterMapper;

	@Override
	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception {
		return masterMapper.selectInfoList(params);
	}

	@Override
	public EgovMap selectInfo(HashMap<String, Object> params) throws Exception {
		return masterMapper.selectInfo(params);
	}

	@Override
	public void insertInfo(HashMap<String, Object> params) throws Exception {
		masterMapper.insertInfo(params);
	}

	@Override
	public void updateInfo(HashMap<String, Object> params) throws Exception {
		masterMapper.updateInfo(params);
	}

	@Override
	public void deleteInfo(HashMap<String, Object> params) throws Exception {
		masterMapper.deleteInfo(params);
	}

}
