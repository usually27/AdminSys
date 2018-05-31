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

import admin.common.vo.ListSearchVO;
/**
 * 사원정보를 저장하기 위한 VO클래스
 * 
 * @author  표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see 
 * <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 * 
 * </pre>
 */
public class ProgMgrVO  extends ListSearchVO  {
	
	private static final long serialVersionUID = 1L;
	private String progId = "";
	private String progNm = "";
	private String progDesc = "";
	private String progPath = "";
	private String popupFlag = "";
	private String width = "";
	private String height = "";
	private String useFlag = "";
	private String totalrows = "";
	private String num = "";
	
	private String progGb = "";
	private String progGbNm = "";
	
	private String useFlag2 = "";
	private String workGubun = "";
	
	private String resourceId = "";
	private String resourceName = "";
	private String resourcePattern = "";
	private String description = "";
	
	
	public String getProgId() {
		return progId;
	}
	public void setProgId(String progId) {
		this.progId = progId;
	}
	public String getProgNm() {
		return progNm;
	}
	public void setProgNm(String progNm) {
		this.progNm = progNm;
	}
	public String getProgDesc() {
		return progDesc;
	}
	public void setProgDesc(String progDesc) {
		this.progDesc = progDesc;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getPopupFlag() {
		return popupFlag;
	}
	public void setPopupFlag(String popupFlag) {
		this.popupFlag = popupFlag;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getTotalrows() {
		return totalrows;
	}
	public void setTotalrows(String totalrows) {
		this.totalrows = totalrows;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getProgGb() {
		return progGb;
	}
	public void setProgGb(String progGb) {
		this.progGb = progGb;
	}
	public String getProgGbNm() {
		return progGbNm;
	}
	public void setProgGbNm(String progGbNm) {
		this.progGbNm = progGbNm;
	}
	public String getUseFlag2() {
		return useFlag2;
	}
	public void setUseFlag2(String useFlag2) {
		this.useFlag2 = useFlag2;
	}
	public String getWorkGubun() {
		return workGubun;
	}
	public void setWorkGubun(String workGubun) {
		this.workGubun = workGubun;
	}
	public String getResourceId() {
		return resourceId;
	}
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	public String getResourcePattern() {
		return resourcePattern;
	}
	public void setResourcePattern(String resourcePattern) {
		this.resourcePattern = resourcePattern;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
