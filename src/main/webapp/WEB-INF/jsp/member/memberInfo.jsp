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
var jqGrid;

var conWord1;
var conWord2;
var conWord;

//검색
function searchList(consonantWord) {
	consWord = consonantWord;

	switch (consonantWord) {
	case 'ㄱ':
		conWord1 = "가"; conWord2 = "나"; $("#name").val(""); break;
	case 'ㄴ':
		conWord1 = "나"; conWord2 = "다"; $("#name").val(""); break;
	case 'ㄷ':
		conWord1 = "다"; conWord2 = "라"; $("#name").val(""); break;
	case 'ㄹ':
		conWord1 = "라"; conWord2 = "마"; $("#name").val(""); break;
	case 'ㅁ':
		conWord1 = "마"; conWord2 = "바"; $("#name").val(""); break;
	case 'ㅂ':
		conWord1 = "바"; conWord2 = "사"; $("#name").val(""); break;
	case 'ㅅ':
		conWord1 = "사"; conWord2 = "아"; $("#name").val(""); break;
	case 'ㅇ':
		conWord1 = "아"; conWord2 = "자"; $("#name").val(""); break;
	case 'ㅈ':
		conWord1 = "자"; conWord2 = "차"; $("#name").val(""); break;
	case 'ㅊ':
		conWord1 = "차"; conWord2 = "카"; $("#name").val(""); break;
	case 'ㅋ':
		conWord1 = "카"; conWord2 = "타"; $("#name").val(""); break;
	case 'ㅌ':
		conWord1 = "타"; conWord2 = "파"; $("#name").val(""); break;
	case 'ㅍ':
		conWord1 = "파"; conWord2 = "하"; $("#name").val(""); break;
	case 'ㅎ':
		conWord1 = "하"; conWord2 = "히"; $("#name").val(""); break;
	case '전체':
		conWord1 = ""; conWord2 = ""; $("#name").val(""); break;
	default:
		conWord1 = ""; conWord2 = ""; break;
	}

	var name = $("#name").val();
	$("#name").val(name.trim());

	$("#gridTable").jqGrid('setGridParam', {
		url : "${context}/member/memberInfoList.json",
		datatype : "json",
		"postData" : { auth : $("#auth").val(), aprState : $("#apr_state").val(), orgName : $("#org_name").val(), userClass : $("#user_class").val(), name : $("#name").val(), conWord1 : conWord1, conWord2 : conWord2 }
	}).trigger('reloadGrid');

}

//사용자 등록(관리자)
function insertMember() {
	$("#lyrPop").modalWindow('${context}/member/memberInfoRegPopup.do');
}

//사용자 정보 수정
function memberModify(userId, roleId) {
	var params = { gubunflag : "modifyMgr", userId : encodeURI(userId) };
	$("#lyrPop").modalWindow('${context}/member/memberInfoModPopup.do', {reqData : params});
}

//사용자 메뉴 권한 수정
function memberMenuAuth(userId, roleId) {
	var params = { userId : userId, roleId : roleId };
	$("#lyrPop").modalWindow('${context}/member/memberAuthModPopup.do', {reqData : params});
}

//사용자 레이어 권한 수정
function memberLayerAuth(userId, roleId) {
	var params = { userId : userId, roleId : roleId };
	$("#lyrPop").modalWindow('${context}/member/layerAuthModPopup.do', { reqData : params });
}

//사용자 접속차단
function memberBlock( flag ){
	var obj = $("#gridTable");
	var idx= $("#gridTable").getGridParam("selarrrow");
	var cnt = idx.length;
	var fdata = "";

	if(cnt == 0) {
		alert("차단/해제할 사용자를 한 명 이상 선택해주세요.");
		return;
	} else {
		for(var i=0; i<idx.length; i++) {
			var value = obj.jqGrid("getCell", idx[i], "id");
			if(i != idx.length-1) {
				fdata += value + ",";
			} else {
				fdata += value;
			}
		}

		if(flag == 'S') {
			if(confirm("사용자의 접속을 차단하시겠습니까?")) {
				$.ajax({
					type	: "post",
					url		: "${context}/member/memberBlock.json",
					data	: {
						"userId" : fdata,
						"flag" : flag
					},
					dataType:"json",
					cache	: false,
					async	: false,
					success	: function( data ){
						if(data.respFlag == 'Y'){
							alert('해당 사용자(들)의 접속이 차단되었습니다.');
							reloadList();
						}else{
							alert("오류발생, 다시 시도하여 주십시오");
						}
					}
				});
			}
		} else if(flag == 'Y') {
			if(confirm("사용자의 접속 차단을 해제하시겠습니까?")) {
				$.ajax({
					type	: "post",
					url		: "${context}/member/memberBlock.json",
					data	: {
						"userId" : fdata,
						"flag" : flag
					},
					dataType:"json",
					cache	: false,
					async	: false,
					success	: function( data ){
						if(data.respFlag == 'Y'){
							alert('해당 사용자(들)의 접속 차단이 해제되었습니다.');
							reloadList();
						}else{
							alert("오류발생, 다시 시도하여 주십시오");
						}
					}
				});
			}
		} else if(flag == 'N') {
			if(confirm("사용자의 가입을 승인하시겠습니까?")) {
				$.ajax({
					type	: "post",
					url		: "${context}/member/memberBlock.json",
					data	: {
						"userId" : fdata,
						"flag" : 'ㅛ'
					},
					dataType:"json",
					cache	: false,
					async	: false,
					success	: function( data ){
						if(data.respFlag == 'Y'){
							alert('해당 사용자(들)의 접속 차단이 해제되었습니다.');
							reloadList();
						}else{
							alert("오류발생, 다시 시도하여 주십시오");
						}
					}
				});
			}
		} 
	}
}

function reloadList() {
	$("#gridTable").jqGrid('setGridParam').trigger('reloadGrid');
}

$(function() {
	setSnb(0);

	/* 권한 콤보 */
	var comboArea = new AjaxComboBox("#auth", {
		url			: "<c:url value='/common/util/code/combobox.json?codegroup=authCode' />",
		baseItem 	: {name: "-- 전체 --", value: "all"}
	}).load({select: "all"});
	
	jqGrid = new JqGrid("#gridTable", true, {
		url : "${context}/member/memberInfoList.json",
		postData : {
			auth : $("#auth").val(),
			aprState : $("#apr_state").val(),
			userClass : $("#user_class").val(),
			name : "",
			conWord1 : "",
			conWord2 : ""
		},
		colNames : [
					'순번',
					'메뉴권한',
					'ID',
					'사용자 ID',
					'사용자 이름',
					'기관명',
					'실국',
					'부서',
					'사무실 전화번호',
					'회원 상태',
					'최근로그인',
					'메뉴 권한',
					'레이어 권한'
		],
		colModel : [
			{name:'num', index:'num', width:40, align:'center'},
			{name:'roleNm', index:'role_nm', width:90, align:'center'},
			{name:'id', index:'id', align:'center', hidden:true},
			{name:'userId', index:'user_id', width:80, align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:memberModify(\'' + record["userId"] + '\', \''+record["roleId"]+'\')">' + value + '</a>';
			}},
			{name:'userName', index:'user_name', width:90, align:'center'},
			{name:'gbnL', index:'gbn_l', width:100, align:'center'},
			{name:'gbnM', index:'gbn_m', width:100, align:'center'},
			{name:'gbnS', index:'gbn_s', width:100, align:'center'},
			{name:'userTel', index:'user_tel', width:100, align:'center'},
			{name:'aprState', index:'apr_state', width:80, align:'center'},
			{name:'lastConn', index:'last_conn', width:130, align:'center'},
			{name:'메뉴 권한', width:75, align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:memberMenuAuth(\'' + record["userId"] + '\', \''+record["roleId"]+'\')">수정</a>';
			}},
			{name:'레이어 권한', width:75, align:'center', formatter: function (value, options, record) {
				return '<a style="color:blue;" href="javascript:memberLayerAuth(\'' + record["userId"] + '\', \''+record["roleId"]+'\')">수정</a>';
			}}
		],
		pager : true,
		multiselect : true,
		shrinkToFit : false,
		gridView : true
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
					<li><a href="./">관리자</a></li>
					<li><a href="${context}/member/memberInfo.do">회원 관리</a></li>
					<li class="active">회원 관리</li>
				</ul>
				<!-- // Breadcrumb -->

				<h1 class="currentPage">회원 관리</h1>
			</div>
			<!-- // Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="searchForm" id="searchForm" onSubmit="return false;">
				<div class="section">
					<div class="table_wrap">
						<table border="1" cellspacing="0" class="board_search">
							<caption>게시물 검색</caption>
							<colgroup>
								<col width="135">
								<col width="*">
								<col width="145">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="">메뉴권한</label></th>
									<td>
										<select name="auth" id="auth" title="" class="size115"></select>
									</td>
									<th><label for="">등록상태</label></th>
									<td>
										<select name="apr_state" id="apr_state" title="" class="size115">
											<option value="all" selected>-- 전체 --</option>
											<option value="Y">사용가능</option>
											<option value="N">승인요청</option>
											<option value="S">접속차단</option>
										</select>
									</td>
								</tr>
								<tr>
									<th><label for="">기관명</label></th>
									<td>
										<select name="org_name" id="org_name" title="" class="size115">
											<option value="all" selected>-- 전체 --</option>
											<option value="시청">광주광역시청</option>
											<option value="서구">서구</option>
											<option value="남구">남구</option>
											<option value="동구">동구</option>
											<option value="북구">북구</option>
											<option value="광산구">광산구</option>
										</select>
									</td>
									<th><label for="">사용자 이름/ID</label></th>
									<td colspan="3">
										<input type="text" name="name" id="name" style="IME-MODE:active" title="검색어 입력" class="size115" onkeypress='if(event.keyCode==13) javascript:searchList()'/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn_wrap mg_t10">
						<span class="btn_left">
							<button type="button" class="btn big blue" onclick="memberBlock('Y');"><span>차단해제</span></button>
							<button type="button" class="btn big blue" onclick="memberBlock('S');"><span>접속차단</span></button>
							<button type="button" class="btn big blue" onclick="memberBlock('N');"><span>승인</span></button>
						</span>
						<span class="btn_right">
							<button type="button" class="btn big blue" onclick="searchList();"><span>검색</span></button>
							<button type="button" class="btn big black" onclick="insertMember();"><span>추가</span></button>
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