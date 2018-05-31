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
<link rel="stylesheet" href="<c:url value='/css/com/ui_styleCustom.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>"  type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/contentCustom.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />

<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.colorbox.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.form.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.blockUI.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/grid.locale-kr.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/gridPager.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/jquery.jqGrid.min.js'/>"></script>

<script src="<c:url value='/js/com/common.js'/>"></script>
<script src="<c:url value='/js/com/common-ui.js'/>"></script>
<script src="<c:url value='/js/custom/board.js'/>"></script>
<script src="<c:url value='/js/custom/commonCustom.js'/>"></script>
<script src="<c:url value='/js/custom/combobox.js'/>"></script>

<script type="text/javascript">
var statsResultList;

$(function() {
	statsResultList = new StatisticsResultList("#gridTable", {
		url      : "${context}/log/logStatsList.json",
		reqData  : {},
		colNames : [
			{name : "연도"},
			{name : "계"},
			{name : "월"},
			{name : "계"},
			{name : "일"},
			{name : "계"},
			{name : "메뉴"},
			{name : "계"}
		],
		colModel : [
			{name:'years'},
			{name:'yCnt'},
			{name:'months'},
			{name:'mCnt'},
			{name:'days'},
			{name:'dCnt'},
			{name:'url'},
			{name:'urlCnt'}
		],
	});

	$("form#searchLogForm #reset").click(function() {
		$("#years").val("");
		$("#months").val("");
		$("#days").val("");
		$("#url").val("");
		statsResultList.reloadList();
	});

	$("form#searchLogForm #search").click(function() {
		statsResultList.reloadList($("#searchLogForm").getFormToJsonData());
	});
});

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
					<li><a href="${context}/log/logStatsList.json">로그 관리</a></li>
					<li class="active">로그 통계 관리</li>
				</ul>
				<!-- // Breadcrumb -->

				<h1 class="currentPage">로그 통계 관리</h1>
			</div>
			<!-- // Content Header -->

			<!-- Content body -->
			<div class="content_body">
				<form name="searchLogForm" id="searchLogForm" onSubmit="return false;">
				<div class="section">
					<div class="table_wrap">
						<table border="1" cellspacing="0" class="board_search">
							<caption>통계 검색</caption>
							<colgroup>
								<col width="135">
								<col width="*">
								<col width="145">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th><label>기간</label></th>
									<td>
										연도<input type ="text" name="years" id="years" title="연도" class="size50" maxlength="4">
										월<input type ="text" name="months" id="months" title="월" class="size40" maxlength="2">
										일<input type ="text" name="days" id="days" title="일" class="size40" maxlength="2">
									</td>
									<th><label>메뉴</label></th>
									<td>
										<select name="url" id="url" title="메뉴" class="size115">
											<option value="" selected>전체</option>
											<option value="login">로그인</option>
											<option value="board">게시판</option>
											<option value="search">지도 검색</option>
											<option value="stat">통계</option>
											<option value="attrw">상수 시설물</option>
											<option value="attrs">하수 시설물</option>
											<option value="attrr">도로 시설물</option>
											<option value="attru">지하 시설물</option>
											<option value="attrrw">상수 공사대장</option>
											<option value="attrrs">하수 공사대장</option>
											<option value="attrrr">도로 공사대장</option>
											<option value="attrmw">상수 민원</option>
											<option value="attrms">하수 민원</option>
											<option value="attrmr">도로 민원</option>
										</select>
									</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<div class="btn_wrap mg_t10">
						<span class="btn_right">
							<button type="button" id="reset" class="btn mid red" ><span>초기화</span></button>
							<button type="button" id="search" class="btn mid blue" ><span>검색</span></button>
						</span>
					</div>
				</div>
				</form>
				<!-- // Board Search -->

				<!-- Board List -->
				<div id="jqGridDiv" class="board_tp1 mar_t30 stats">
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