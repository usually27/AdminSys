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
public class MenuInfoVO  extends ListSearchVO  {
	
	private static final long serialVersionUID = 1L;
	private String menuNm = "";
	private String menuId = "";
	private String parMenuId = "";
	private String menuLevel = "";
	private String orderNo = "";
	private String useFlag = "";
	private String useFlagYn = "";
	private String progName = "";
	private String progId = "";
	private String progNm = "";
	private String progPath = "";
	private String menuOrderNo = "";
	private String topMenuId = "";
	private String childCount = "";
	private String treeLevel = "";
	private String isLeaf = "";
	private String parMenuLevel = "";
	private String parMenuNm = "";
	
	private String searchType = "";
	
	private String upDownGb = "";
	
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getParMenuId() {
		return parMenuId;
	}
	public void setParMenuId(String parMenuId) {
		this.parMenuId = parMenuId;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getUseFlagYn() {
		return useFlagYn;
	}
	public void setUseFlagYn(String useFlagYn) {
		this.useFlagYn = useFlagYn;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
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
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}
	public String getMenuOrderNo() {
		return menuOrderNo;
	}
	public void setMenuOrderNo(String menuOrderNo) {
		this.menuOrderNo = menuOrderNo;
	}
	public String getTopMenuId() {
		return topMenuId;
	}
	public void setTopMenuId(String topMenuId) {
		this.topMenuId = topMenuId;
	}
	public String getChildCount() {
		return childCount;
	}
	public void setChildCount(String childCount) {
		this.childCount = childCount;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getUpDownGb() {
		return upDownGb;
	}
	public void setUpDownGb(String upDownGb) {
		this.upDownGb = upDownGb;
	}
	public String getTreeLevel() {
		return treeLevel;
	}
	public void setTreeLevel(String treeLevel) {
		this.treeLevel = treeLevel;
	}
	public String getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}
	public String getParMenuLevel() {
		return parMenuLevel;
	}
	public void setParMenuLevel(String parMenuLevel) {
		this.parMenuLevel = parMenuLevel;
	}
	public String getParMenuNm() {
		return parMenuNm;
	}
	public void setParMenuNm(String parMenuNm) {
		this.parMenuNm = parMenuNm;
	}

}
