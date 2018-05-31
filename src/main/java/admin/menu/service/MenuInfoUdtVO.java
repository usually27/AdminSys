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
public class MenuInfoUdtVO  {
	
	private String updateGb     = "";
	private String menuLevel    = "";
	private String menuNM       = "";
	private String menuId       = "";
	private String parMenuId    = "";
	private String rootMenuName = "";
	private String rootUse      = "";
	private String midMenuName  = "";
	private String midUse       = "";
	private String parselect    = "";
	private String leafMenuName = "";
	private String leafUse      = "";
	private String rootlevel    = "";
	private String midlevel     = "";
	private String progpath     = "";
	private String progid       = "";
	private String prognm       = "";
	
	private String midLeafFlag  = "";
	private String parMenu_Level  = "";
	
	private int maxMenuOrderNo;
	
	public String getUpdateGb() {
		return updateGb;
	}
	public void setUpdateGb(String updateGb) {
		this.updateGb = updateGb;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getMenuNM() {
		return menuNM;
	}
	public void setMenuNM(String menuNM) {
		this.menuNM = menuNM;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getRootMenuName() {
		return rootMenuName;
	}
	public void setRootMenuName(String rootMenuName) {
		this.rootMenuName = rootMenuName;
	}
	public String getRootUse() {
		return rootUse;
	}
	public void setRootUse(String rootUse) {
		this.rootUse = rootUse;
	}
	public String getMidMenuName() {
		return midMenuName;
	}
	public void setMidMenuName(String midMenuName) {
		this.midMenuName = midMenuName;
	}
	public String getMidUse() {
		return midUse;
	}
	public void setMidUse(String midUse) {
		this.midUse = midUse;
	}
	public String getParselect() {
		return parselect;
	}
	public void setParselect(String parselect) {
		this.parselect = parselect;
	}
	public String getLeafMenuName() {
		return leafMenuName;
	}
	public void setLeafMenuName(String leafMenuName) {
		this.leafMenuName = leafMenuName;
	}
	public String getLeafUse() {
		return leafUse;
	}
	public void setLeafUse(String leafUse) {
		this.leafUse = leafUse;
	}
	public String getRootlevel() {
		return rootlevel;
	}
	public void setRootlevel(String rootlevel) {
		this.rootlevel = rootlevel;
	}
	public String getMidlevel() {
		return midlevel;
	}
	public void setMidlevel(String midlevel) {
		this.midlevel = midlevel;
	}
	public String getProgpath() {
		return progpath;
	}
	public void setProgpath(String progpath) {
		this.progpath = progpath;
	}
	public String getProgid() {
		return progid;
	}
	public void setProgid(String progid) {
		this.progid = progid;
	}
	public String getPrognm() {
		return prognm;
	}
	public void setPrognm(String prognm) {
		this.prognm = prognm;
	}
	public int getMaxMenuOrderNo() {
		return maxMenuOrderNo;
	}
	public void setMaxMenuOrderNo(int maxMenuOrderNo) {
		this.maxMenuOrderNo = maxMenuOrderNo;
	}
	public String getParMenuId() {
		return parMenuId;
	}
	public void setParMenuId(String parMenuId) {
		this.parMenuId = parMenuId;
	}
	public String getMidLeafFlag() {
		return midLeafFlag;
	}
	public void setMidLeafFlag(String midLeafFlag) {
		this.midLeafFlag = midLeafFlag;
	}
	public String getParMenu_Level() {
		return parMenu_Level;
	}
	public void setParMenu_Level(String parMenu_Level) {
		this.parMenu_Level = parMenu_Level;
	}

	
	
	
	
}
