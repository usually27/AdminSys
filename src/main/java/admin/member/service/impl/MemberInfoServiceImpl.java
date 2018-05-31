package admin.member.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.member.service.MemberInfoMapper;
import admin.member.service.MemberInfoService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("memberInfoService")
public class MemberInfoServiceImpl implements MemberInfoService {

	@Resource(name = "memberInfoMapper")
	private MemberInfoMapper memberInfoMapper;

	@Override
	public List<?> memberInfoList(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.memberInfoList(params);
	}

	@Override
	public int memberCnt(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.memberCnt(params);
	}

	@Override
	public void memberBlock(HashMap<String, Object> params) throws Exception {
		if(!"".equals(params.get("userId").toString()) &&  params.get("userId").toString() != null){
			StringTokenizer st = new StringTokenizer(params.get("userId").toString(), ",");
			while (st.hasMoreTokens()) {
				memberInfoMapper.memberBlock(st.nextToken(), params.get("flag").toString());
			}
		}
//		return memberInfoMapper.memberBlock(params);
	}

	@Override
	public int memberInfoRegIdchk(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.memberInfoRegIdchk(params);
	}

	@Override
	public void memberInfoInsert(HashMap<String, Object> params) throws Exception {
		memberInfoMapper.memberInfoInsert(params);
	}

	@Override
	public String generatePasswd() throws Exception {
		String initPass = "";

		Random rd = new Random();
		String[] array1 = {"a","b","c","d","e","f","g","h","i","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z"};
		String[] array2 = {"2","3","4","5","6","7","8","9"};
		String[] array3 = {"!","@","#","$","%","&","*"};
		for(int i=0; i<6; i++){ // 1~5번째 자리까지는 소문자
			initPass += array1[rd.nextInt(array1.length)];
		}
		initPass += array2[rd.nextInt(array2.length)];
		initPass += array2[rd.nextInt(array2.length)];
		// 6,7번째 자리는 숫자
		initPass += array3[rd.nextInt(array3.length)]; // 8번째는 특수문자

		return initPass;
	}

	@Override
	public EgovMap getMemberDetail(String userId) throws Exception {
		return memberInfoMapper.getMemberDetail(userId);
	}

	@Override
	public void memberInfoPwdInit(HashMap<String, Object> params) throws Exception {
		memberInfoMapper.memberInfoPwdInit(params);
	}

	@Override
	public void memberInfoBlock(HashMap<String, Object> params) throws Exception {
		memberInfoMapper.memberInfoBlock(params);
	}

	@Override
	public void memberInfoDelete(HashMap<String, Object> params) throws Exception {
		memberInfoMapper.memberInfoDelete(params);
	}

	@Override
	public int memberInfoApproval(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.memberInfoApproval(params);
	}

	@Override
	public int memberInfoDefer(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.memberInfoDefer(params);
	}

	@Override
	public void memberInfoModifyMgr(HashMap<String, Object> params) throws Exception {
		memberInfoMapper.memberInfoModifyMgr(params);
	}

	@Override
	public List<?> menuAuthList(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.menuAuthList(params);
	}

	@Override
	public void menuAuthEditInsert(String userId, String mappingIdVal, String roleId) throws Exception {
		//기존 매핑목록 제거
		memberInfoMapper.memberAuthSaveDel(userId);

		if(!"".equals(mappingIdVal) &&  mappingIdVal != null){
			List<String> goneMenuId = new ArrayList<String>();
			List<String> newMenuId = new ArrayList<String>();

			//화면에서 전달받은 인자
			StringTokenizer st = new StringTokenizer(mappingIdVal, ",");
			String[] spVal = mappingIdVal.split(",");
			int spValLength = 0;
			if(spVal != null) {
				spValLength = spVal.length;
			}

			//권한별 메뉴권한 목록 가져오기
			List<?> getAuthList = memberInfoMapper.menuMappingList(roleId);

			int listSize = 0;
			if(getAuthList != null) {
				listSize = getAuthList.size();
			}

			//기존에 있었지만 없어진 메뉴 (USE_YN = 'N')
			for(int i=0; i<listSize; i++) {
				EgovMap getMenuId = (EgovMap)getAuthList.get(i);

				//루트 메뉴 PASS
				if("M000000000".equals(getMenuId.get("menuId"))) {
					continue;
				}

				boolean stateGubun = true;
				for(int j=0; j<spValLength; j++) {
					if(getMenuId.get("menuId").equals(spVal[j])) {
						stateGubun = false;
						break;
					}
				}

				if(stateGubun) {
					goneMenuId.add((String)getMenuId.get("menuId"));
				}
			}

			//기존엔 없었지만 추가된 메뉴 (USE_YN = 'Y')
			while(st.hasMoreTokens()) {
				String stMenuId = st.nextToken();
				boolean stateGubun2 = true;
				for(int i=0; i < listSize; i++){
					EgovMap getMenuId2 = (EgovMap)getAuthList.get(i);
					if(stMenuId.equals(getMenuId2.get("menuId"))){
						stateGubun2 =false;
						break;
					}
				}

				if(stateGubun2){
					newMenuId.add(stMenuId);
				}
			}

			int goneMenuIdSize = 0;
			int newMenuIdSize = 0;
			if(goneMenuId != null){
				goneMenuIdSize = goneMenuId.size();
			}
			if(newMenuId != null){
				newMenuIdSize = newMenuId.size();
			}

			for(int ix=0; ix<goneMenuIdSize;ix++){
				memberInfoMapper.memberAuthSaveIst(userId, goneMenuId.get(ix),"N");
			}
			for(int ik=0; ik<newMenuIdSize;ik++){
				memberInfoMapper.memberAuthSaveIst(userId, newMenuId.get(ik),"Y");
			}
		}
	}

	@Override
	public void memberAuthInit(String userId) throws Exception {
		memberInfoMapper.memberAuthSaveDel(userId);
	}

	@Override
	public List<?> layerMemAuthList(HashMap<String, Object> params) throws Exception {
		return memberInfoMapper.layerMemAuthList(params);
	}

	@Override
	public void layerMemAuthEditInsert(String userId, String mappingIdVal, String authVal, String chkIdxVal) throws Exception {
		//기존 매핑목록 제거
		memberInfoMapper.layerMemAuthSaveDel(userId);

		if(!"".equals(mappingIdVal) &&  mappingIdVal != null){
			List<String> newLayerId = new ArrayList<String>();
			List<String> newReadVal = new ArrayList<String>();
			List<String> newWriteVal = new ArrayList<String>();

			//화면에서 전달받은 인자
			String[] array1 = mappingIdVal.split(",");
			String[] array2 = chkIdxVal.split(",");

			String temp1 = "";
			String temp2 = "";
			String chkVal1 = "";
			String chkVal2 = "";
			String readYn = "N";
			String writeYn = "N";

			int array1Length = 0;
			if(array1 != null) {
				array1Length = array1.length;
			}

			//권한별 메뉴권한 목록 가져오기
			List<?> getAuthList = memberInfoMapper.layerMappingList(authVal);

			int listSize = 0;
			if(getAuthList != null) {
				listSize = getAuthList.size();
			}

			//기존에 있었지만 없어진 레이어 (read : N, write : N) 혹은 기존에 있던 레이어지만 read/wirte 체크 값이 달라진 경우
			for(int i=0; i<listSize; i++) {
				EgovMap getLayerId = (EgovMap)getAuthList.get(i);

				//루트 메뉴 PASS
				if("M000000000".equals(getLayerId.get("layerId"))) {
					continue;
				}

				boolean lChk = true;
				boolean rChk = true;
				boolean wChk = true;
				for(int j=0; j<array1Length; j++) {
					if(getLayerId.get("layerId").equals(array1[j])) {
						lChk = false;

						temp1= array1[j];
						chkVal1 = array2[j];
						j++;
						if(j==array1Length)
						{
							temp2 = array1[j-1];
							chkVal2 = array2[j-1];
						}else{
						temp2 = array1[j];
						chkVal2 = array2[j];
						}
						if(temp1.equals(temp2)) {
							chkVal1 = "Y";
							chkVal2 = "Y";
							if(getLayerId.get("read").equals(chkVal1)) {
								rChk = false;
							}
							if(getLayerId.get("write").equals(chkVal2)) {
								wChk = false;
							}
							if(rChk || wChk) {
								newLayerId.add(temp1);
								newReadVal.add(chkVal1);
								newWriteVal.add(chkVal2);
							}
						} else {
							j--;
							newLayerId.add(temp1);
							if("1".equals(array2[j])) {
								readYn = "Y";
							} else {
								writeYn = "Y";
							}
							newReadVal.add(readYn);
							newWriteVal.add(writeYn);
						}
					}
				}

				if(lChk) {
					newLayerId.add(getLayerId.get("layerId").toString());
					newReadVal.add("N");
					newWriteVal.add("N");
				}

				temp1 = "";
				temp2 = "";
				chkVal1= "";
				chkVal2 = "";
				readYn = "N";
				writeYn = "N";
			}

			//기존에 없었지만 새로 생긴 레이어
			for(int i=0; i<array1Length; i++) {
				String array1Val = array1[i];

				boolean layerChk = true;
				for(int j=0; j<listSize; j++) {
					EgovMap getLayerId = (EgovMap)getAuthList.get(j);

					if(array1Val.equals(getLayerId.get("layerId"))) {
						layerChk = false;
					}
				}

				if(layerChk) {
					temp1 = array1[i];
					chkVal1 = array2[i];
					i++;
					if(i==array1Length)
					{
						temp2 = array1[i-1];
						chkVal2 = array2[i-1];
					}else{
					temp2 = array1[i];
					chkVal2 = array2[i];
					}

					if(temp1.equals(temp2)) {
						newLayerId.add(temp1);
						newReadVal.add("Y");
						newWriteVal.add("Y");
					} else {
						i--;
						newLayerId.add(temp1);
						if("1".equals(chkVal1)) {
							readYn = "Y";
						} else {
							writeYn = "Y";
						}
						newReadVal.add(readYn);
						newWriteVal.add(writeYn);
					}
					temp1 = "";
					temp2 = "";
					chkVal1 = "";
					chkVal2 = "";
					readYn = "N";
					writeYn = "N";
				}
			}

			int newLayerIdSize = 0;
			if(newLayerId != null) {
				newLayerIdSize = newLayerId.size();
			}
			for(int i=0; i<newLayerIdSize; i++) {
				memberInfoMapper.layerMemAuthSave(userId, newLayerId.get(i), newReadVal.get(i), newWriteVal.get(i));
			}
		}
	}

	@Override
	public void layerMemAuthInit(String userId) throws Exception {
		memberInfoMapper.layerMemAuthSaveDel(userId);
	}

	@Override
	public List<?> selectInfoList(HashMap<String, Object> params) throws Exception{
		return memberInfoMapper.selectInfoList(params);
	}
	
	@Override
	public List<?> logStatsList(HashMap<String, Object> params) throws Exception{
		return memberInfoMapper.logStatsList(params);
	}
	
}
