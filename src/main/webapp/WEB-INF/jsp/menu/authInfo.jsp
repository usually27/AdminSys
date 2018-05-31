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
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />

<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.colorbox.js'/>"></script>
<script src="<c:url value='/js/plugins/jquery/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/grid.locale-kr.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/gridPager.js'/>"></script>
<script src="<c:url value='/js/plugins/jqgrid/jquery.jqGrid.min.js'/>"></script>

<script src="<c:url value='/js/com/common-ui.js'/>"></script>
<script src="<c:url value='/js/custom/boardCustom.js'/>"></script>

<script type="text/javascript">

var jqGrid;
var params;

function insertFun(){
	params = { method : "insert" };
	regPopup(params);
};

function regPopup(params){
	$("#lyrPop").modalWindow('${context}/menu/authRegPopup.do', {reqData : params});
};

function authModify(roleId, roleNm, roleDesc, useFlag) {
	if(useFlag == "사용") {
		useFlag = "Y";
	} else {
		useFlag = "N";
	}

	params = { method : "update", roleId : roleId, roleNm : roleNm, roleDesc : roleDesc, useFlag : useFlag }
	regPopup(params);
}

function authDelete(roleId) {
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({
			async : false,
			cache : false,
			type  : "POST",
			url	  : "${context}/menu/authDelete.json" ,
			dataType : "json",
			data : {
				method : "delete",
				roleId : roleId,
			},
			success : function(json) {
				if(json.respFlag == 'Y'){
					alert("성공적으로 삭제하였습니다.");
					reloadList();
				}else{
					alert("삭제 처리 중 에러가 발생하였습니다.");
				}
			},
			error : function(response) {
				alert("삭제 처리 중 에러가 발생하였습니다.");
			}
		});
	}
}

function reloadList() {
	$("#gridTable").jqGrid('setGridParam').trigger('reloadGrid');
}

$(function() {
	setSnb(2);

	$Grid = $("#gridTable");
	$Grid.jqGrid({
		url : "${context}/menu/authInfoList.json",
		datatype : "json",
		mtype : "get",
		jsonReader : {
			root : 'root'
		},
		colNames : [
			'권한 ID',
			'권한 명',
			'권한 설명',
			'사용여부',
			'수정',
			'삭제'
		],
		colModel : [
			{name:'roleId', index:'role_id', width:100, align:'center'},
			{name:'roleNm', index:'role_nm', width:100, align:'center'},
			{name:'roleDesc', index:'role_desc', width:100, align:'center'},
			{name:'useFlag', index:'use_flag', width:100, align:'center'},
			{name:'수정', align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:authModify(\'' + record["roleId"] + '\', \'' + record["roleNm"] + '\', \'' + record["roleDesc"] + '\', \''+record["useFlag"]+'\')">수정</a>';
			}},
			{name:'삭제', align:'center', formatter: function (value, options, record) {
				return '<a style="color:red;" href="javascript:authDelete(\''+record["roleId"]+'\')">삭제</a>';
			}}
		],
		viewrecords : true,
		gridview : true,
		autowidth : true,
		shrinkToFit : false,
		rownumbers : true
	}).navGrid("#paper", { edit : false, add : false, search : true, del : false });

});
</script>
</head>

<body>
<div id="wrap">
	<%@ include file="../common/menu.jsp"%>
		<div id="content">
			<div class="content_header">
				<ul class="breadcrumb">
					<li><a href="/">관리자</a></li>
					<li><a href="${context}/menu/programList.do">메뉴 관리</a></li>
					<li class="active">권한 관리</li>
				</ul>

				<h1 class="currentPage">권한 관리</h1>
			</div>

			<div class="content_body">
				<form id="menuRegForm" name="menuRegForm" method="post">
				<input type="hidden" id="method" name="method"/>
				<input type="hidden" id="roleId" name="roleId"/>
				<input type="hidden" id="roleNm" name="roleNm"/>
				<input type="hidden" id="roleDesc" name="roleDesc"/>
				<input type="hidden" id="useFlag" name="useFlag"/>
				<div class="section">
					<div class="btn_wrap mg_t10">
						<span class="btn_right">
							<button type="button" id="addBtn" class="btn big black" onclick="insertFun();"><span>권한 추가</span></button>
						</span>
					</div>
				</div>
				</form>

				<div id="jqGridDiv">
					<!-- grid영역 -->
					<table id="gridTable"></table>
					<!-- page영역  -->
				</div>
			</div>
		</div>
	</div>
	<hr>

	<div id="footer_wrap">
		<div id="footer">
			<div class="copyright">Copyright © <script>document.write((new Date()).getFullYear());</script> 광주광역시 All rights reserved.</div>
		</div>
	</div>

	<div id="lyrPop" class="lp_wrap lp_memberInfo lp_w600"></div>
</div>
</body>
</html>