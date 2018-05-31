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
package admin.layer.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

/**
 * 레이어관리
 *
 * @author  phk
 * @since 2015.11.04
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2015.11.04            phk          최초 생성
 *
 * </pre>
 */
@Transactional
public interface LayerMgrService {

	public List<?> layerList(HashMap<String, Object> params) throws Exception;

	public void insertLayer(HashMap<String, Object> params) throws Exception;

	public void updateLayer(HashMap<String, Object> params) throws Exception;

	public void updateLayerMenu(HashMap<String, Object> params) throws Exception;

	public void deleteLayer(HashMap<String, Object> params) throws Exception;

	public List<?> menuInfoList(HashMap<String, Object> params) throws Exception;

	public void updateMenu(HashMap<String, Object> params) throws Exception;

	public void deleteLayerMenu(HashMap<String, Object> params) throws Exception;

	public List<?> layerSearchList(HashMap<String, Object> params) throws Exception;

	public int menuMoveUdt(HashMap<String, Object> params) throws Exception;

	public List<?> layerAuthList(HashMap<String, Object> params) throws Exception;

	public void layerAuthEditInsert(String menuNmChk, String authVal, String chkIdxVal) throws Exception;

}
