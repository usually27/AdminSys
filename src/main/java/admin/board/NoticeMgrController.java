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

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

//import org.apache.commons.mail.DefaultAuthenticator;
//import org.apache.commons.mail.Email;
//import org.apache.commons.mail.EmailException;
//import org.apache.commons.mail.SimpleEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import admin.board.service.NoticeMgrService;
import admin.board.service.NoticeMgrVO;
import admin.common.annotation.AuthExclude;
import admin.common.annotation.AuthHandler;
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
public class NoticeMgrController {
	
	@Resource(name = "noticeMgrService")
	private NoticeMgrService masterService;


	private static final Logger LOGGER = LoggerFactory.getLogger(NoticeMgrController.class);

	// 공지사항 리스트 관리자 초기화면
	@RequestMapping(value = "/board/noticeMgr.do")
	public String baseNoticeMgr(ModelMap model) throws Exception {
		model.addAttribute("paramGubun", "mgr");
		return "board/noticeList";
	}

	//공지사항 리스트 일반사용자 초기화면
		@RequestMapping(value = "/board/noticeInfo.do")
		public String baseNoticeInfo(ModelMap model) throws Exception {
			model.addAttribute("paramGubun", "info");
			return "board/noticeList";
		}

		//공지사항 리스트
		@AuthHandler(handler="baseNoticeInfo")
		@RequestMapping(value="/board/noticeMgrList.json", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
		public ModelMap memberInfoList(@RequestParam HashMap<String, Object> params, NoticeMgrVO noticeMgrVO, ModelMap model) throws Exception {
//			LOGGER.debug("getConWord1....................{}",memberSerchVO.getConWord1());

			int rows = Integer.parseInt(params.get("rows").toString());
			int page = Integer.parseInt(params.get("page").toString());

			params.put("rows", rows);
			params.put("page", page);
			//메뉴리스트조회
			List<?> rstNotceList = masterService.noticeList(params);

			//데이터 총 개수
			int totCnt = masterService.noticeListTotCnt(noticeMgrVO);
			
			double totalPage = 0.0;
			Long totalRows = Long.valueOf(((EgovMap) rstNotceList.get(0)).get("totalrows").toString());

			if (totCnt > 0) {
				totalPage = Math.ceil(totalRows / rows) + 1;
			}

			HashMap<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("records", totalRows);
			jsonMap.put("total", totalPage);
			jsonMap.put("page", page);
			jsonMap.put("root", rstNotceList);

			model.addAttribute("jsonView", jsonMap);

			return model;
		}

		//공지사항 관리 관리자용 등록화면
		@AuthHandler(handler="baseNoticeMgr")
		@RequestMapping(value = "/board/noticeMgrInsertPopup.json", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
		@ResponseBody
		public ModelMap noticeInsertPopup(@RequestParam HashMap<String, Object> params, NoticeMgrVO noticeMgrVO,ModelMap model) throws Exception {
//			ObjectMapper mapper = new ObjectMapper();
			HashMap<String, Object> jsonMap = new HashMap<String, Object>();
			if("update".equals(noticeMgrVO.getMethod())){
				List<?> rstNotceList = masterService.noticeDetail(noticeMgrVO);
//				model.addAttribute("noticeDetail", rstNotceList);
				jsonMap.put("rstNotceList",  rstNotceList);
//				return mapper.writeValueAsString(rstNotceList);
			}

		
			jsonMap.put("success",  true);
			model.addAttribute("jsonView", jsonMap);
//
			return model;
		}

		//공지사항 등록/수정
		@AuthHandler(handler="baseNoticeMgr")
		@RequestMapping(value="/board/noticeMgrInsert.json", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
		public ModelMap noticeMgrInsert(NoticeMgrVO noticeMgrVO, ModelMap model) throws Exception {
			LOGGER.debug("noticeMgrVO.getMethod()....................{}",noticeMgrVO.getMethod());
			try{
				if("insert".equals(noticeMgrVO.getMethod())){
					masterService.noticeMgrInsert(noticeMgrVO);
				}else if("update".equals(noticeMgrVO.getMethod())){
					masterService.noticeMgrUpdate(noticeMgrVO);
				}
			}catch(Exception e){
				LOGGER.debug("##########저장에 실패 하였습니다##########{}",e.toString());
			}

			HashMap<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("success",  true);
			model.addAttribute("jsonView", jsonMap);

			return model;
		}

		//공지사항 상세보기(관리자)
		@AuthHandler(handler="baseNoticeMgr")
		@RequestMapping(value = "/board/noticeMgrUpdatePopup.do")
		public String noticeUpdatePopup(NoticeMgrVO noticeMgrVO,ModelMap model) throws Exception {
			LOGGER.debug("noticeMgrVO.getNoticeNum()....................{}",noticeMgrVO.getNoticeNum());
			List<?> noticeDetail = masterService.noticeDetail(noticeMgrVO);

			try{
				masterService.noticeUpdateReadNum(noticeMgrVO.getNoticeNum());
			}catch(Exception e){
				LOGGER.debug("##########저장에 실패 하였습니다##########{}",e.toString());
			}

			model.addAttribute("noticeDetail", noticeDetail);

			return "infoJoin/noticeMgrInsertPopup";
		}

		//공지사항 삭제
		@AuthHandler(handler="baseNoticeMgr")
		@RequestMapping(value="/board/noticeMgrDelete.json", method=RequestMethod.POST, produces={MediaType.APPLICATION_JSON_VALUE})
		public ModelMap noticeMgrDelete(String noticeNum, ModelMap model) throws Exception {
			LOGGER.debug("noticeNum....................{}",noticeNum);
			try{
				masterService.noticeMgrDelete(noticeNum);
			}catch(Exception e){
				LOGGER.debug("##########삭제에 실패 하였습니다##########{}",e.toString());
			}

			HashMap<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("success",  true);
			model.addAttribute("jsonView", jsonMap);

			return model;
		}

		//공지사항 상세보기(일반사용자)
		@AuthExclude
		@RequestMapping(value = "/board/noticeInfoUpdatePopup.do")
		public String noticeInfoPopup(NoticeMgrVO noticeMgrVO,ModelMap model) throws Exception {
			LOGGER.debug("noticeMgrVO.getNoticeNum()....................{}",noticeMgrVO.getNoticeNum());
			List<?> noticeDetail = masterService.noticeDetail(noticeMgrVO);

			try{
				masterService.noticeUpdateReadNum(noticeMgrVO.getNoticeNum());
			}catch(Exception e){
				LOGGER.debug("##########저장에 실패 하였습니다##########{}",e.toString());
			}

			model.addAttribute("noticeDetailInfo", noticeDetail);

			return "infoJoin/noticeInfoPopup";
		}
}
