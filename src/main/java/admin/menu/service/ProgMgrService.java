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

@Transactional
public interface ProgMgrService {

	public List<?> progList(HashMap<String, Object> params) throws Exception;

	@Transactional
	public void insertProg(HashMap<String, Object> params) throws Exception;

	@Transactional
	public void updateProg(HashMap<String, Object> params) throws Exception;

	@Transactional
	public void updateProgMenu(HashMap<String, Object> params) throws Exception;

	@Transactional
	public void deleteProg(HashMap<String, Object> params) throws Exception;

	public List<?> progSearchList(HashMap<String, Object> params) throws Exception;


}
