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

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
@Mapper("menuInfoMapper")
public interface MenuInfoMapper {

	//메뉴목록
	public List<?> menuInfoList(MenuInfoVO menuInfoVO) throws Exception;

	//총 갯수
	public int menuInfoListTotCnt(MenuInfoVO menuInfoVO) throws Exception;

	//대메뉴콤보
	public List<MenuInfoComboVO> menuInfoParseLvlCombo() throws Exception;

	//중메뉴콤보
	public List<MenuInfoComboVO> menuInfoLevel2Combo(MenuInfoComboVO menuInfoComboVO) throws Exception;

	//대메뉴등록
	public void instMenu_1(HashMap<String, Object> params) throws Exception;

	//중메뉴등록
	public int instGetMaxOrd_2(HashMap<String, Object> params) throws Exception;
	public void instUdtOrd_2(@Param("maxMenuOrderNo") int maxMenuOrderNo) throws Exception;
	public void instMenu_2(HashMap<String, Object> params) throws Exception;

	//소메뉴등록
	public int instGetMaxOrd_3(HashMap<String, Object> params) throws Exception;
	public int instGetMaxOrd2_4(HashMap<String, Object> params) throws Exception;
	public void instMenu_3(HashMap<String, Object> params) throws Exception;
	public void instMenu_2_3(HashMap<String, Object> params) throws Exception;
	public void instMenu_2_4(HashMap<String, Object> params) throws Exception;

	//메뉴수정
	public void updateMenu(HashMap<String, Object> params) throws Exception;

	//메뉴삭제
	public void deleteUdtMenu(MenuInfoVO menuInfoVO) throws Exception;
	public void deleteUdtMenuOrder(MenuInfoVO menuInfoVO) throws Exception;
	public void deleteMenu(MenuInfoVO menuInfoVO) throws Exception;

	//메뉴이동
	public EgovMap moveMenuGetParMenuId(HashMap<String, Object> params) throws Exception;
	public List<String> updateMenuIdList(String comMenuId) throws Exception;
	public void menuMoveOrderUdt(@Param("orderNo") String orderNo,@Param("menuId") String menuId) throws Exception;
	public void menuMoveMenuOrderUdt(@Param("orderNo") int orderNo,@Param("menuId") String menuId) throws Exception;
}
