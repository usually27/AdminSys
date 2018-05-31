<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" id="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>공간정보통합관리시스템</title>

<link rel="stylesheet" href="<c:url value='/css/com/base.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui_style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>"  type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />

<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.colorbox.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.form.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/grid.locale-kr.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/gridPager.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/jquery.jqGrid.min.js'/>"></script>

<script src="<c:url value='/js/com/common.js'/>"></script>
<script src="<c:url value='/js/com/common-ui.js'/>"></script>
<script src="<c:url value='/js/custom/boardCustom.js'/>"></script>
<script src="<c:url value='/js/custom/combobox.js'/>"></script>

<script type="text/javascript">
var customGird = null;
$(function(){
	jqGrid = new JqGrid("#gridTable", true, {
		url	: "${context}/log/selectInfoList.json",
		postData : {
		},
		colNames : ["번호","업무구분","아이디", "접속시간","접속메뉴" 
		],
		colModel : [
			{name:'num', index:'num', width:40, align:'center'},
			{name:'gubun', index:'gubun', width:130, align:'center'},
			{name:'userId', index:'userId', align:'center', width:130},
			{name:'times', index:'times', width:130, align:'center'},
			{name:'url', index:'url', width:130, align:'center'}
		],
		pager : true,
		shrinkToFit : true,
		gridView : true
	});
	
});
function searchList(consonantWord) {
	$("#gridTable").jqGrid('setGridParam', {
		url : "${context}/log/selectInfoList.json",
		datatype : "json",
		"postData" : { userId : $("#userId").val(), gubun : $("#gubun").val()
		}}).trigger('reloadGrid');
		
}
function reloadList() {
	$("#gridTable").jqGrid('setGridParam').trigger('reloadGrid');
}
</script>

</head>

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
					<li><a href="${context}/log/selectInfoList.json">로그 관리</a></li>
					<li class="active">사용자 로그 관리</li>
				</ul>
				<!-- // Breadcrumb -->

				<h1 class="currentPage">사용자 로그 관리</h1>
			</div>
			<!-- // Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="searchLogForm" id="searchLogForm" onSubmit="return false;">
				<div class="section">
					<div class="table_wrap">
						<table border="1" cellspacing="0" class="board_search">
							<caption>사용자 검색</caption>
							<colgroup>
								<col width="135">
								<col width="*">
								<col width="145">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="">사용자 아이디</label></th>
									<td>
									<input type ="text" name="userId" id="userId" title="" class="size115">
									
									</td>
									<th><label for="">사용 시스템</label></th>
									<td><select name="gubun" id="gubun" title="" class="size115">
											<option value="" selected>전체</option>
											<option value="web">웹 시스템</option>
											<option value="cs">편집 시스템</option>
										</select></td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<div class="btn_wrap mg_t10">
						<span class="btn_right">
							<button type="button" class="btn big blue" onclick="searchList();"><span>검색</span></button>
						</span>
					</div>
				</div>
				</form>
				<!-- // Board Search -->

				<!-- Board List -->
				<div id="jqGridDiv">
					<!-- grid영역 -->
					<table id="gridTable"></table>
					<!-- page영역  -->
				</div>
				<!-- // Board List -->

			</div>
			<!-- // Content body -->
		</div>
		<!-- // Content -->
	</div>
	<!-- // Container -->
	<hr>

	<!-- Footer Wrap -->
	<div id="footer_wrap">
		<!-- Footer -->
		<div id="footer">
			<div class="copyright">Copyright © <script>document.write((new Date()).getFullYear());</script> 광주광역시 All rights reserved.</div>
		</div>
		<!-- // Footer -->
	</div>
	<!-- // Footer Wrap -->

	<div id="lyrPop" class="lp_wrap lp_memberInfo lp_w600"></div>

</body>
</html>