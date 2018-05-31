package admin.board.service;

/**
 * 정보/참여 마당 - 공지사항 관리
 * 
 * @author  krc
 * @since 2016.03.04
 * @version 1.0
 * @see 
 * <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2016.03.04        			phk         	 최초 생성
 * 
 * </pre>
 */
public class NoticeMgrVO {
	
	private String ntPart		= "";
	private String ntTitle		= "";
	private String ntNum		= "";
	private String ntReadnum	= "";
	private String totalrows	= "";
	private String ntStart		= "";
	private String ntEnd		= "";
	private String ntContent	= "";
	private String userNm		= "";
	private String num			= "";
	private String ntDate		= "";
	
	private String searchType	= "";
	private String word			= "";
	private int start			= 0;
	private int limit			= 10;
	private int pageSize		= 20;
	
	private String noticeNum	= "";
	private String method		= "";
	private String flag			= "";
	
	public String getNtPart() {
		return ntPart;
	}
	public void setNtPart(String ntPart) {
		this.ntPart = ntPart;
	}
	public String getNtTitle() {
		return ntTitle;
	}
	public void setNtTitle(String ntTitle) {
		this.ntTitle = ntTitle;
	}
	public String getNtNum() {
		return ntNum;
	}
	public void setNtNum(String ntNum) {
		this.ntNum = ntNum;
	}
	public String getNtReadnum() {
		return ntReadnum;
	}
	public void setNtReadnum(String ntReadnum) {
		this.ntReadnum = ntReadnum;
	}
	public String getTotalrows() {
		return totalrows;
	}
	public void setTotalrows(String totalrows) {
		this.totalrows = totalrows;
	}
	public String getNtStart() {
		return ntStart;
	}
	public void setNtStart(String ntStart) {
		this.ntStart = ntStart;
	}
	public String getNtEnd() {
		return ntEnd;
	}
	public void setNtEnd(String ntEnd) {
		this.ntEnd = ntEnd;
	}
	public String getNtContent() {
		return ntContent;
	}
	public void setNtContent(String ntContent) {
		this.ntContent = ntContent;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getNtDate() {
		return ntDate;
	}
	public void setNtDate(String ntDate) {
		this.ntDate = ntDate;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getNoticeNum() {
		return noticeNum;
	}
	public void setNoticeNum(String noticeNum) {
		this.noticeNum = noticeNum;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
}
