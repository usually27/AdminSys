<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>공간정보통합관리시스템</title>
<link rel="stylesheet" href="<c:url value='/css/com/base.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui_style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.min.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />

<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.colorbox.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.form.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui-1.12.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui-1.12.1.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/grid.locale-kr.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/gridPager.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/jquery.jqGrid.min.js'/>"></script>

<script src="<c:url value='/js/com/common.js'/>"></script>
<script src="<c:url value='/js/com/common-ui.js'/>"></script>
<script src="<c:url value='/js/custom/boardCustom.js'/>"></script>

<script type="text/javascript">
$(function(){
	setSnb(4);
	jqGrid = new JqGrid("#list", true, {
		url : '${context}/code/selectInfoList.json',
		postData : {
		},
		datatype : "json",
		mtype : "post",
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'코드 번호',
			'코드한글명',
			'코드 아이디',
			'코드 내용',
			'사용여부',
			'도로사용',
			'상수사용',
			'하수사용',
			'수정',
			'삭제'
		],
		colModel : [
			{name:'codeNum', width:100, align:'center', sortable:false},
			{name:'codeExp', width:100, align:'center', sortable:false},
			{name:'codeId', width:100, align:'center', sortable:false},
			{name:'codeVal', width:120, align:'center', sortable:false},
			{name:'codeUse', width:70, align:'center', sortable:false},
			{name:'useRd', width:70, align:'center', sortable:false},
			{name:'useWt', width:70, align:'center', sortable:false},
			{name:'useSw', width:70, align:'center', sortable:false},
			{name : "수정", align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:codeModify(\'' + record["codeId"] + '\', \''+record["codeNum"]+'\')">수정</a>';
			}},
			{name : "삭제", align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:codeDelete(\'' + record["codeId"] + '\', \''+record["codeNum"]+'\')">삭제</a>';
			}}
		],
		pager : true,
		shrinkToFit : false,
		gridView : true
	});

});
//코드 등록(관리자)
function codeDelete(id, num) {
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({
			url			: "${context}/code/deleteInfo.json",
			type		: "post",
			data		: { codeId : id, codeNum : num },
			dataType	: "json",
			success		: function(json) {
				if(json.respFlag == "Y"){
					alert("정상적으로 삭제되었습니다.");
					reloadList();
				} else {
					alert("오류발생, 다시 시도하여 주십시오");
				}
			},
			error		: function(response) {
				alert("오류발생, 다시 시도하여 주십시오");
			},
		});
	}
}
function reloadList(){
	$("#list").jqGrid('setGridParam').trigger('reloadGrid');
}
//코드 추가
function codeInsert() {
	var params = { method : "insert"};
	$("#lyrPop").modalWindow('${context}/code/selectCUInfoPop.do', {reqData : params});
}
//코드 정보 수정
function codeModify(codeId, codeNum) {
	var params = { method : "update", codeId : codeId, codeNum : codeNum };
	$("#lyrPop").modalWindow('${context}/code/selectCUInfoPop.do', {reqData : params});
}
//검색
function searchList() {
	$("#list").jqGrid('setGridParam', {
		url : "${context}/code/selectInfoList.json",
		datatype : "json",
		"postData" : { codeVal : $("#cdVal").val(), codeExp : $("#cdExp").val(), codeNum : $("#cdNum").val() }
	}).trigger('reloadGrid');

}
</script>

<body>
<div id="wrap">
<%@ include file="../common/menu.jsp"%>
		<!-- Contents -->
		<div id="content">
			<!-- Content Header -->
			<div class="content_header">
				<!-- Breadcrumb -->
				<ul class="breadcrumb">
					<li><a href="/">관리자</a></li>
					<li><a href="/code/selectInfoList">코드 관리</a></li>
					<li class="active">코드 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">코드 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<div class="section">
						<div class="table_wrap">
							<table border="1" cellspacing="0" class="board_search">
								<caption>코드 검색</caption>
								<colgroup>
									<col width="90">
									<col width="*">
									<col width="90">
									<col width="*">
									<col width="90">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th><label for="">코드번호</label></th>
										<td>
											<input type="text" name="cdNum" id="cdNum" maxlength="50" title="검색어입력" class="size100">
										</td>
										<th><label for="">코드명</label></th>
										<td>
											<input type="text" name="cdExp" id="cdExp" maxlength="50" title="검색어입력" class="size100">
										</td>
										<th><label for="">코드내용</label></th>
										<td>
											<input type="text" name="cdVal" id="cdVal" maxlength="50" title="검색어입력" class="size100">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap mg_t10">
							<span>
								<button type="button" class="btn big blue" onclick="javascript:searchList();"><span>검색</span></button>
								<button type="button" class="btn big black" onclick="javascript:codeInsert();"><span>코드 추가</span></button>
							</span>
						</div>
					</div>
					<table id="list"></table>
				</form>
				<!--// Board Search -->

				<!-- Board List -->

				<!--// Board List -->

			</div>
			<!--// Content body -->
		</div>
		<!--// Content -->
	</div>
	<!--// Container -->
	<hr>

	<!-- Footer Wrap -->
	<div id="footer_wrap">
		<!-- Footer -->
		<div id="footer">
			<div class="copyright">Copyright © <script>document.write((new Date()).getFullYear());</script> 광주광역시 All rights reserved.</div>
		</div>
		<!--// Footer -->
	</div>
	<!--// Footer Wrap -->

	<div id="lyrPop" class="lp_wrap lp_memberInfo lp_w600"></div>

</div>
</body>
</html>