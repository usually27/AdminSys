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
package admin.layer.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Vector;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import admin.layer.service.LayerMgrMapper;
import admin.layer.service.LayerMgrService;
import admin.menu.AuthInfoController;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * CRUD 요청을 처리하는 비즈니스 클래스
 *
 * @author  표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 *
 * </pre>
 */
@Service("layerMgrService")
public class LayerMgrServiceImpl implements LayerMgrService {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthInfoController.class);

	@Resource(name = "layerMgrMapper")
	private LayerMgrMapper layerMgrMapper;

	@Override
	public List<?> layerList(HashMap<String, Object> params ) throws Exception {
		return layerMgrMapper.layerList(params);
	}

	@Override
	public void insertLayer(HashMap<String, Object> params) throws Exception {
		layerMgrMapper.insertLayer(params);
	}

	@Override
	public void updateLayer(HashMap<String, Object> params) throws Exception {
		layerMgrMapper.updateLayer(params);
	}

	@Override
	public void updateLayerMenu(HashMap<String, Object> params) throws Exception {
		layerMgrMapper.updateLayerMenu(params);
	}

	@Override
	public void deleteLayer(HashMap<String, Object> params) throws Exception {
		layerMgrMapper.deleteLayer(params);
	}

	@Override
	public List<?> menuInfoList(HashMap<String, Object> params) throws Exception {
		return layerMgrMapper.menuInfoList(params);
	}

	@Override
	public void updateMenu(HashMap<String, Object> params) throws Exception {
		String updateGb = (String)params.get("updateGb");
		String menuLevel = (String)params.get("menuLevel");
		String midLeafFlag = (String)params.get("midLeafFlag");
		String parmenuLevel = (String)params.get("parmenuLevel");

		/*등록*/
		if("insert".equals(updateGb)){
			if("0".equals(menuLevel)){																	//대메뉴 등록
				layerMgrMapper.instMenu_1(params);
			}
			else if("1".equals(menuLevel)){														//중메뉴 등록
				int maxMenuOrderNo = layerMgrMapper.instGetMaxOrd_2(params);	//max 메뉴순서 get
				layerMgrMapper.instUdtOrd_2(maxMenuOrderNo-1);							//메뉴 순서 변경
				params.put("maxMenuOrderNo", maxMenuOrderNo);
				layerMgrMapper.instMenu_2(params);													//메뉴등록
			}
			else if("2".equals(menuLevel)){															//depth4중메뉴 및 소메뉴
				if("M".equals(midLeafFlag)){																//중메뉴에서 중메뉴 등록할때
					int maxMenuOrderNo = layerMgrMapper.instGetMaxOrd_3(params);
					layerMgrMapper.instUdtOrd_2(maxMenuOrderNo-1);						//메뉴 순서 변경
					params.put("maxMenuOrderNo", maxMenuOrderNo);
					layerMgrMapper.instMenu_2_3(params);											//메뉴등록
				}
				else if("2".equals(parmenuLevel)){													//중메뉴안에 중메뉴에서 소메뉴 등록할때
					int maxMenuOrderNo = layerMgrMapper.instGetMaxOrd2_4(params);
					layerMgrMapper.instUdtOrd_2(maxMenuOrderNo-1);
					params.put("maxMenuOrderNo", maxMenuOrderNo);
					layerMgrMapper.instMenu_2_4(params);
				}else{
					int maxMenuOrderNo = layerMgrMapper.instGetMaxOrd_3(params);
					layerMgrMapper.instUdtOrd_2(maxMenuOrderNo-1);
					params.put("maxMenuOrderNo", maxMenuOrderNo);
					layerMgrMapper.instMenu_3(params);
				}
			}
		}else{	/*수정*/
			layerMgrMapper.updateMenu(params);
		}
	}

	@Override
	public void deleteLayerMenu(HashMap<String, Object> params) throws Exception {
		layerMgrMapper.deleteUdtMenu(params);
		layerMgrMapper.deleteUdtMenuOrder(params);
		layerMgrMapper.deleteMenu(params);
		layerMgrMapper.deleteMenuRole(params);
	}

	@Override
	public List<?> layerSearchList(HashMap<String, Object> params) throws Exception {
		return layerMgrMapper.layerSearchList(params);
	}

	@Override
	public int menuMoveUdt(HashMap<String, Object> params) throws Exception {
		Vector<String> vctUpdateMenuId 	= new Vector<String>();		//피 이동 메뉴id 그룹 담을 변수
		Vector<String> vctCurrentMenuId = new Vector<String>();		//메뉴이동으로 선택된 id 그룹을 담을 변수

		int rtnValue = 0;		//return값 초기화
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("success",  true);

		String upDownGb = (String)params.get("upDownGb");			//메뉴이동 (위,아래)
		String parMenuId = (String)params.get("parMenuId");			//선택된 메뉴의 부모아이디
		String menuLevel = (String)params.get("menuLevel");			//메뉴레벨:대[1],중[2],소[3]
		String menuId = (String)params.get("menuId");						//선택된 메뉴아이디
		String orderNo = (String)params.get("orderNo");					//선택된 메뉴 순서
		String parMenuLevel = (String)params.get("parMenuLevel");	//선택된 메뉴 부모 레벨

		LOGGER.debug("upDownGb....................{}",upDownGb);
		LOGGER.debug("parMenuId....................{}",parMenuId);
		LOGGER.debug("menuLevel....................{}",menuLevel);
		LOGGER.debug("menuId....................{}",menuId);
		LOGGER.debug("orderNo....................{}",orderNo);
		LOGGER.debug("parMenuLevel....................{}",parMenuLevel);

		/*수정데이터 기준값 조회*/
		int up_order_no 		= 0;
		String update_order_no 	= "";
		String update_menu_id 	= "";
		String update_menu_lvl 		= "";
		String update_par_menu_lvl 	= "";

		EgovMap getBaseVo = layerMgrMapper.moveMenuGetParMenuId(params);

		LOGGER.debug("getBaseVo....................{}",getBaseVo);

		/*결과값 setting*/
		if(getBaseVo == null){
			LOGGER.debug("getBaseVo....................nullllllllll");
			rtnValue = 99;			//메뉴이동 불가
			return rtnValue;		//프로세스 종료
		}else{
			if(!"".equals(String.valueOf(getBaseVo.get("menuOrderNo"))) || String.valueOf(getBaseVo.get("menuOrderNo")) !=null){
				up_order_no = Integer.parseInt(String.valueOf(getBaseVo.get("menuOrderNo")));
			}
			update_order_no 	= String.valueOf(getBaseVo.get("orderNo"));
			update_menu_id 		= (String)getBaseVo.get("menuId");
			update_menu_lvl		= (String)getBaseVo.get("menuLevel");
			update_par_menu_lvl	= (String)getBaseVo.get("parMenuLevel");
		}

		LOGGER.debug("up_order_no....................{}",up_order_no);
		LOGGER.debug("update_order_no....................{}",update_order_no);
		LOGGER.debug("update_menu_id....................{}",update_menu_id);
		LOGGER.debug("update_menu_lvl....................{}",update_menu_lvl);
		LOGGER.debug("update_par_menu_lvl....................{}",update_par_menu_lvl);

		//업데이트 시킬 데이터 조회
		List<String> udtMenuIdList = null;
		List<String> curMenuIdList = null;
		if("1".equals(menuLevel)){
			udtMenuIdList = layerMgrMapper.updateMenuIdList(update_menu_id);
			curMenuIdList = layerMgrMapper.updateMenuIdList(menuId);
		}else if("2".equals(menuLevel) && "1".equals(parMenuLevel)){
			udtMenuIdList = layerMgrMapper.updateMenuIdList(update_menu_id);
			curMenuIdList = layerMgrMapper.updateMenuIdList(menuId);
		}
		else if("2".equals(menuLevel) && "2".equals(parMenuLevel)){
			if("2".equals(update_menu_lvl) && "2".equals(update_par_menu_lvl)){
				udtMenuIdList = layerMgrMapper.updateMenuIdList(update_menu_id);
				curMenuIdList = layerMgrMapper.updateMenuIdList(menuId);
			}else{
				curMenuIdList = layerMgrMapper.updateMenuIdList(menuId);
			}
		}else{
			if("2".equals(update_menu_lvl) && "2".equals(update_par_menu_lvl)){
				udtMenuIdList = layerMgrMapper.updateMenuIdList(update_menu_id);
			}
		}

		//조회된 데이터 vector에 추가
		vctUpdateMenuId.add(update_menu_id);
		vctCurrentMenuId.add(menuId);
		if("1".equals(menuLevel)){
			for(int ix = 0; ix < udtMenuIdList.size(); ix++ ){
				vctUpdateMenuId.add(udtMenuIdList.get(ix));
			}
			for(int ix = 0; ix < curMenuIdList.size(); ix++ ){
				vctCurrentMenuId.add(curMenuIdList.get(ix));
			}
		}else if("2".equals(menuLevel) && "1".equals(parMenuLevel)){
			for(int ix = 0; ix < udtMenuIdList.size(); ix++ ){
				vctUpdateMenuId.add(udtMenuIdList.get(ix));
			}
			for(int ix = 0; ix < curMenuIdList.size(); ix++ ){
				vctCurrentMenuId.add(curMenuIdList.get(ix));
			}
		}
		else if("2".equals(menuLevel) && "2".equals(parMenuLevel)){
			if("2".equals(update_menu_lvl) && "2".equals(update_par_menu_lvl)){
				for(int ix = 0; ix < udtMenuIdList.size(); ix++ ){
					vctUpdateMenuId.add(udtMenuIdList.get(ix));
				}
				for(int ix = 0; ix < curMenuIdList.size(); ix++ ){
					vctCurrentMenuId.add(curMenuIdList.get(ix));
				}
			}else{
				for(int ix = 0; ix < curMenuIdList.size(); ix++ ){
					vctCurrentMenuId.add(curMenuIdList.get(ix));
				}
			}
		}else{
			if("2".equals(update_menu_lvl) && "2".equals(update_par_menu_lvl)){
				for(int ix = 0; ix < udtMenuIdList.size(); ix++ ){
					vctUpdateMenuId.add(udtMenuIdList.get(ix));
				}
			}
		}

		//ORDER_NO 변경 [같은 레벨의 순서를 변경]
		layerMgrMapper.menuMoveOrderUdt(update_order_no,menuId);
		layerMgrMapper.menuMoveOrderUdt(orderNo,update_menu_id);

		//MENU_ORDER_NO 변경 [전체 순서 변경]
		if("up".equals(upDownGb)){
			for(int i =0; i < vctCurrentMenuId.size(); i++){
				String curMenuId = vctCurrentMenuId.get(i).toString();
				layerMgrMapper.menuMoveMenuOrderUdt(up_order_no,curMenuId);
				up_order_no++;
				rtnValue++;
			}

			for(int i =0; i < vctUpdateMenuId.size(); i++){
				String udtMenuId = vctUpdateMenuId.get(i).toString();
				layerMgrMapper.menuMoveMenuOrderUdt(up_order_no,udtMenuId);
				up_order_no++;
				rtnValue++;
			}
		}else if("down".equals(upDownGb)){
			up_order_no -= vctCurrentMenuId.size();	//변경이 이루어지는 피선택자,변경선택한 데이터 순서로 치환해줘야 하기때문
			for(int i =0; i < vctUpdateMenuId.size(); i++){
				String udtMenuId = vctUpdateMenuId.get(i).toString();
				layerMgrMapper.menuMoveMenuOrderUdt(up_order_no,udtMenuId);
				up_order_no++;
				rtnValue++;
			}

			for(int i =0; i < vctCurrentMenuId.size(); i++){
				String curMenuId = vctCurrentMenuId.get(i).toString();
				layerMgrMapper.menuMoveMenuOrderUdt(up_order_no,curMenuId);
				up_order_no++;
				rtnValue++;
			}
		}
		return rtnValue;
	}

	@Override
	public List<?> layerAuthList(HashMap<String, Object> params) throws Exception {
		return layerMgrMapper.layerAuthList(params);
	}

	@Override
	public void layerAuthEditInsert(String menuNmChk, String authVal, String chkIdxVal) throws Exception {
		//삭제후 저장
		layerMgrMapper.layerAuthEditDelete(authVal);

		String[] array1 = menuNmChk.split(",");
		String[] array2 = chkIdxVal.split(",");

		String temp1 = "";
		String temp2 = "";
		String readYn = "N";
		String writeYn = "N";

		for(int i =0; i < array1.length; i++) {
			if(i >= 1) {
				temp1 = array1[i];
				i++;
				if(i == array1.length){
					temp2 = array1[i-1];
				}
				else{
				temp2 = array1[i];
				}
				if(temp1.equals(temp2)) {
					if(i == array1.length){
						if("1".equals(array2[i-1])){
							readYn = "Y";
						} else {
							writeYn = "Y";
						}
						layerMgrMapper.layerAuthEditInsert(array1[i-1], authVal, readYn, writeYn);
					}
					else{
					readYn = "Y";
					writeYn = "Y";

					layerMgrMapper.layerAuthEditInsert(array1[i], authVal, readYn, writeYn);
					}
					} else {
					i--;
					if("1".equals(array2[i])){
						readYn = "Y";
					} else {
						writeYn = "Y";
					}

					layerMgrMapper.layerAuthEditInsert(array1[i], authVal, readYn, writeYn);
				}
			} else {
				readYn = "Y";
				writeYn = "Y";
				layerMgrMapper.layerAuthEditInsert(array1[i], authVal, readYn, writeYn);
			}
			temp1 = "";
			temp2 = "";
			readYn = "N";
			writeYn = "N";
		}
	}

}
