var customPageInfo = ""; // 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
var customPageInfoType = ""; // 페이지 정보의 종류
var pageCount = 10; // 한 페이지에 보여줄 페이지 수 (ex:1 2 3 4 5)

/**
* 그리드 페이징
*
* @param gridId
* @param pagerId
* @param pI : 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
* @param pit : 페이지 정보의 종류 (pI : true 일때) :
*
* TOT = 총 페이지수 / 갯수 (현재 페이지의 시작 레코드 ~ 현재 페이지의 마지막 레코드) <=== 기본값
* TOTP = 총 페이지수 / 갯수
* PSE = (현재 페이지의 시작 레코드 ~ 현재 페이지의 마지막 레코드)
*/

function initPage(gridId, pagerId, pI, pit){

	if(pI == null || pI == ""){
		customPageInfo = false;
	}else{
		customPageInfo = true;
	}

	if(pit != "TOTP" && pit != "PSE"){
		customPageInfoType = "TOT";
	}else{
		customPageInfoType = pit;
	}

	// 현재 페이지
	var currentPage = $('#'+gridId).getGridParam('page');

	// 전체 리스트 수
	var totalSize = $('#'+gridId).getGridParam('records');

	// 그리드 데이터 전체의 페이지 수
	var totalPage = Math.ceil(totalSize/$('#'+gridId).getGridParam('rowNum'));

	// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
	var totalPageList = Math.ceil(totalPage/pageCount);

	// 페이지 리스트가 몇번째 리스트인지
	var pageList=Math.ceil(currentPage/pageCount);

	//alert("currentPage="+currentPage+"/ totalPage="+totalSize);
	//alert("pageCount="+pageCount+"/ pageList="+pageList);


	// 페이지 정보 셋팅
	var pageInfoText = ""; // 페이지 정보를 담을 변수
	if(customPageInfo){

		//////////////////////////////////////////////////////////////////////////////////////////
		var base = parseInt($('#'+gridId).getGridParam('page'),10)-1 ;

		if(base < 0) { base = 0; }
			base = base*parseInt($('#'+gridId).getGridParam('rowNum'),10);

		var from = base+1;
		var to = base + $('#'+gridId).getGridParam('reccount') ;
		//////////////////////////////////////////////////////////////////////////////////////////

		if(totalSize == 0){
			pageInfoText = "표시할 데이터가 없습니다";
		}else{
			 var totpTxt = "총 " + totalPage + " 페이지" + " / " + totalSize + " 개";
			 var pseTxt = "( " + from + " ~ " + to + " )";
			// var totpTxt = "총 " + commify(totalPage) + " 페이지" + " / " + commify(totalSize) + " 개";
			// var pseTxt = "( " + commify(from) + " ~ " + commify(to) + " )";
			 var totTxt = totpTxt+ " 중 " + pseTxt;

			 if(customPageInfoType == "TOTP"){
				 pageInfoText = totpTxt;
			 }else if(customPageInfoType == "PSE"){
				 pageInfoText = pseTxt;
			 }else{
				 pageInfoText = totTxt;
			 }
		}
	}

	// 페이지 리스트가 1보다 작으면 1로 초기화
	if(pageList<1) pageList=1;

	// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
	if(pageList>totalPageList) pageList = totalPageList;

	// 시작 페이지
	var startPageList=((pageList-1)*pageCount)+1;

	// 끝 페이지
	var endPageList=startPageList+pageCount-1;

	//alert("startPageList="+startPageList+"/ endPageList="+endPageList);

	// 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
	// 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
	if(startPageList<1) startPageList=1;
	if(endPageList>totalPage) endPageList=totalPage;
	if(endPageList<1) endPageList=1;

	// 페이징 DIV에 넣어줄 태그 생성변수
	var pageInner="";

	// 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
	if(pageList<2){
//		pageInner+="<span class='customPageMoveBtn'><i class='fa fa-angle-double-left'></i></span>"; //<<
//		pageInner+="<span class='customPageMoveBtn'><i class='fa fa-angle-left'></i></span>"; //<

		pageInner+="<li class='prev disabled'><a href='#'><i class='fa fa-angle-double-left'></i></a></li>"; //<<
		pageInner+="<li class='prev disabled'><a href='#'><i class='fa fa-angle-left'></i></a></li>"; //<
	}
	// 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
	if(pageList>1){
		var titleFirstPage = "첫 페이지로 이동";
		var titlePrePage = (startPageList-10) + "페이지에서 " + (endPageList-10) + "페이지까지 이동";

//		pageInner+="<a class='first' href='javascript:firstPage(\""+ gridId +"\");' title='"+ titleFirstPage +"'><span class='customPageMoveBtn'><i class='fa fa-angle-double-left faPointer'></i></span></a>";
//		pageInner+="<a class='pre' href='javascript:prePage(\""+ gridId +"\");' title='"+ titlePrePage +"'><span class='customPageMoveBtn'><i class='fa fa-angle-left faPointer'></i></span></a>";

		pageInner+="<li class='prev'><a class='first' href='javascript:firstPage(\""+ gridId +"\");' title='"+ titleFirstPage +"'><i class='fa fa-angle-double-left'></i></a></li>";
		pageInner+="<li class='prev'><a class='pre' href='javascript:prePage(\""+ gridId +"\");' title='"+ titlePrePage +"'><i class='fa fa-angle-left'></i></a></li>";
	}
	// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
	for(var i=startPageList; i<=endPageList; i++){
		var titleGoPage = i + "페이지로 이동";

		if(i==currentPage){
//			pageInner =
//				pageInner +"<a href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"' style='color: #fff'><span class='currentPageNumberBtn'>"+(i)+"</span></a>";
			pageInner += "<li class='active'><a href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'>"+(i)+"</a></li>";

		}else{
//			pageInner =
//				pageInner +"<a href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'><span class='customPageNumberBtn'>"+(i)+"</span></a>";
			pageInner += "<li><a href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'>"+(i)+"</a></li>";
		}
	}

	//alert("총페이지 갯수"+totalPageList);
	//alert("현재페이지리스트 번호"+pageList);

	// 다음 페이지 리스트가 있을 경우
	if(totalPageList>pageList){
		var titleNextPage = (startPageList+10) + "페이지에서 " + (endPageList+10) + "페이지까지 이동";
		var titleLastPage = "마지막 페이지로 이동";

//		pageInner+="<a class='next' href='javascript:nextPage(\""+ gridId +"\");' title='"+ titleNextPage +"'><span class='customPageMoveBtn'><i class='fa fa-angle-right faPointer'></i></span></a>"; //>
//		pageInner+="<a class='last' href='javascript:lastPage(\""+ gridId +"\");' title='"+ titleLastPage +"'><span class='customPageMoveBtn'><i class='fa fa-angle-double-right faPointer'></i></span></a>"; //>>

		pageInner+="<li class='next'><a class='next' href='javascript:nextPage(\""+ gridId +"\");' title='"+ titleNextPage +"'><i class='fa fa-angle-right'></i></a></li>"; //>
		pageInner+="<li class='next'><a class='last' href='javascript:lastPage(\""+ gridId +"\");' title='"+ titleLastPage +"'><i class='fa fa-angle-double-right'></i></a></li>"; //>>
	}

	// 현재 페이지리스트가 마지막 페이지 리스트일 경우
	if(totalPageList==pageList){
//		pageInner+="<span class='customPageMoveBtn'><i class='fa fa-angle-right'></i></span>";
//		pageInner+="<span class='customPageMoveBtn'><i class='fa fa-angle-double-right'></i></span>";

		pageInner+="<li class='next disabled'><a href='#'><i class='fa fa-angle-right'></i></a></li>"; //>
		pageInner+="<li class='next disabled'><a href='#'><i class='fa fa-angle-double-right'></i></a></li>"; //>>
	}
	//alert(pageInner);

	var smallpage = "";
	smallpage += customPageInfo ? pageInfoText + " " : "" ;

	var html = "";
//	html += "<ul class='pagination' style='visibility: visible;'>";
	html += "<ul class='pagination'>";
	html += pageInner;
	html += "</ul>"

	// 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
	$("#"+pagerId).html("");
	$("#small-"+pagerId).html("");

	// 너비 조정
//	var w = $('#'+gridId).width()+18;
//	$("#"+pagerId).width(w);

	// 페이징 html 추가
//	$("#"+pagerId).append(table);
	$("#"+pagerId).append(html);
	$("#small-"+pagerId).append(smallpage);

	// 페이징 클래스 추가
//	$("#"+pagerId).addClass("customPaginateBar");
	$("#"+pagerId).css("text-align", "center");

}

//그리드 첫페이지로 이동
function firstPage(gridId){
	$("#"+gridId).jqGrid('setGridParam', {
	page:1,
	}).trigger("reloadGrid");
}

//그리드 이전페이지 이동
function prePage(gridId){
	var currentPage = $("#"+gridId).getGridParam('page');

	currentPage-=pageCount;
	pageList=Math.ceil(currentPage/pageCount);
	currentPage=(pageList-1)*pageCount+pageCount;

	$("#"+gridId).jqGrid('setGridParam', {
	page:currentPage,
	}).trigger("reloadGrid");
}

//그리드 다음페이지 이동
function nextPage(gridId){
	var currentPage = $("#"+gridId).getGridParam('page');

	currentPage+=pageCount;
	pageList=Math.ceil(currentPage/pageCount);
	currentPage=(pageList-1)*pageCount+1;

	$("#"+gridId).jqGrid('setGridParam', {
	page:currentPage,
	}).trigger("reloadGrid");
}

//그리드 마지막페이지 이동
function lastPage(gridId){
	var totalSize = jQuery('#'+gridId).getGridParam('records');
	var totalPage = Math.ceil(totalSize/$('#'+gridId).getGridParam('rowNum'));

	$("#"+gridId).jqGrid('setGridParam', {
	page:totalPage,
	}).trigger("reloadGrid");
}

//그리드 페이지 이동
function goPage(gridId, num){
	$("#"+gridId).jqGrid('setGridParam', {
	page:num,
	}).trigger("reloadGrid");
}
