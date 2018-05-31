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
	setSnb(3);

	$("#list").jqGrid({
		url : '${pageContext.request.contextPath}/layer/layerList.json',
		postData : {
			layerIdGb : '',
			layerName : ''
		},
		datatype : "json",
		mtype : "get",
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'레이어 ID',
			'테이블 명',
			'레이어 명',
			'레이어 경로',
			'수정',
			'삭제'
		],
		colModel : [
			{name:'layerId', width:50, align:'center', sortable:false},
			{name:'tableNm', width:100, align:'center', sortable:false},
			{name:'layerNm', width:100, align:'center' ,sortable:false},
			{name:'layerPath', width:230, sortable:false},
			{name:'layerModify', width:80, sortable:false, align:'center', formatter:  function  (value, options, record) {
				   return '<a style="color : blue;"  href="javascript:layerModify(\'' + record["layerId"] + '\', \'' + record["layerNm"] + '\', \''+record["layerPath"]+'\', \''+record["tableNm"]+'\');">수정</a>';
			}},
			{name:'layerDel', width:80, sortable:false,  align:'center', formatter: function  (value, options, record) {
				   return '<a style="color : red;"  href="javascript:layerDel(\'' + record["layerId"] + '\');">삭제</a>';
			}}
		],
		cmTemplate: { autoResizable: true, editable: true },
		iconSet: "fontAwesome",
		autoResizing: { compact: true },
		autoencode: true,
		navOptions: { add: false, edit: false, del: false, search: false },
		searching: { searchOnEnter: false, searchOperators: true },
		rowNum: 20,
		rownumbers: true,
		viewrecords: true,
		gridview : true,
		autowidth : true
	}).jqGrid("navGrid")

	$("#layerIdGb").change(function(){
		/* jqGrid 리로드 */
		$("#list").jqGrid('setGridParam',{
			url : '${context}/layer/layerList.json',
			datatype: "json",
			postData : {
				layerIdGb : $(this).val()
			}
		}).trigger('reloadGrid');
	});

});

function reloadList(){
	$("#list").jqGrid('setGridParam').trigger('reloadGrid');
}

function searchList() {
	var layerNm = $("#layerName").val();
	$("#layerName").val(layerNm.trim());

	$("#list").jqGrid('setGridParam', {
		url : "${context}/layer/layerList.json",
		datatype : "json",
		postData : {
			layerName : $("#layerName").val(),
			layerIdGb : $("#layerIdGb").val()
		}
	}).trigger('reloadGrid');
}

function initList() {
	$("#layerIdGb").val("");
	$("#layerName").val("");

	$("#list").jqGrid('setGridParam', {
		url : "${context}/layer/layerList.json",
		datatype : "json",
		postData : {
			layerName : $("#layerName").val(),
			layerIdGb : $("#layerIdGb").val()
		}
	}).trigger('reloadGrid');
}

function insertFun(){
	var params = {method : "insert" };
	regPopup(params);
};

function regPopup(params){
	$("#lyrPop").modalWindow('${context}/layer/layerRegPopup.do', {reqData : params});
}

function layerDel(layerId) {
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({
			type: "post",
			url	 : "${context}/layer/layerInfoDelete.json",
			data : {
				"layerId" : layerId
			},
			dataType:"json",
			cache: false,
			success: function( data ){
				if(data.respFlag == "Y") {
					alert("정상적으로 삭제하였습니다.");
					reloadList();
				} else {
					alert("삭제 처리 중 에러가 발생하였습니다.");
				}
			}
		});
	}
}

function layerModify(layerId, layerNm, layerPath, tableNm) {
	var params = { method : "update", layerId : layerId, layerNm : layerNm, layerPath : layerPath, tableNm : tableNm };
	regPopup(params);
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
					<li><a href="/layer/layerInfo">레이어 관리</a></li>
					<li class="active">레이어 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">레이어 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="frm" id="frm" method="post" onSubmit="return false;">
					<div class="section">
						<div class="table_wrap">
							<table border="1" cellspacing="0" class="board_search">
								<caption>게시물 검색</caption>
								<colgroup>
									<col width="140">
									<col width="*">
									<col width="140">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th><label for="">레이어 구분</label></th>
										<td>
											<select name="layerIdGb" id="layerIdGb" class="size115">
												<option value="">전체</option>
												<option value="WTL">상수도</option>
												<option value="SWL">하수도</option>
											</select>
										</td>
										<th><label for="">레이어 명</label></th>
										<td>
											<input type="text" name="layerName" id="layerName" maxlength="50" title="검색어입력" class="size115">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap mg_t10">
							<span>
								<button type="button" class="btn big blue" onclick="javascript:initList();"><span>초기화</span></button>
								<button type="button" class="btn big blue" onclick="javascript:searchList();"><span>검색</span></button>
								<button type="button" class="btn big black" onclick="javascript:insertFun();"><span>레이어 추가</span></button>
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