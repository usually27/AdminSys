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
package admin.board;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 회원관리
 *
 * @author phk
 * @since 2015.11.20
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2015.11.20        			phk          최초 생성
 *
 *      </pre>
 */
@Controller
public class magazineMgrController {
	

	private static final Logger LOGGER = LoggerFactory.getLogger(magazineMgrController.class);

	// 공지사항 리스트 관리자 초기화면
	@RequestMapping(value = "/board/magazineMgr.do")
	public String basePdsMgr(ModelMap model) throws Exception {
		return "board/magazineList";
	}

	
}
