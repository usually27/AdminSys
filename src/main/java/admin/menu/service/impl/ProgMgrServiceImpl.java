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
package admin.menu.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import admin.menu.service.ProgMgrMapper;
import admin.menu.service.ProgMgrService;

@Service("progMgrService")
public class ProgMgrServiceImpl implements ProgMgrService {

	@Resource(name = "progMgrMapper")
	private ProgMgrMapper progMgrMapper;

	@Override
	public List<?> progList(HashMap<String, Object> params) throws Exception {
		return progMgrMapper.progList(params);
	}

	@Override
	public void insertProg(HashMap<String, Object> params) throws Exception {
		progMgrMapper.insertProg(params);
	}

	@Override
	public void updateProg(HashMap<String, Object> params) throws Exception {
		progMgrMapper.updateProg(params);
	}

	@Override
	public void updateProgMenu(HashMap<String, Object> params) throws Exception {
		progMgrMapper.updateProgMenu(params);
	}

	@Override
	public void deleteProg(HashMap<String, Object> params) throws Exception {
		progMgrMapper.deleteProg(params);
	}

	@Override
	public List<?> progSearchList(HashMap<String, Object> params) throws Exception {
		return progMgrMapper.progSearchList(params);
	}

}
