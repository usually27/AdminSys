/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package admin.menu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;


/**
 * 메뉴관리
 *
 * @author  phk
 * @since 2015.11.25
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2015.11.25        			phk          	최초 생성
 *
 * </pre>
 */
public interface MenuInfoService {

	//목록조회
	public List<?> menuInfoList(MenuInfoVO menuInfoVO) throws Exception;

	//데이터 총 카운트
	public int menuInfoListTotCnt(MenuInfoVO menuInfoListVO) throws Exception;

	//대메뉴콤보
	public List<MenuInfoComboVO> menuInfoParseLvlCombo() throws Exception;

	//중메뉴콤보
	public List<MenuInfoComboVO> menuInfoLevel2Combo(MenuInfoComboVO menuInfoComboVO) throws Exception;

	//메뉴 수정
	@Transactional
	public void updateMenu(HashMap<String, Object> params) throws Exception;

	//메뉴 삭제
	@Transactional
	public void deleteMenu(MenuInfoVO menuInfoVO) throws Exception;

	//메뉴 이동
	@Transactional
	public int menuMoveUdt(HashMap<String, Object> params) throws Exception;
}
