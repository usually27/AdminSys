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
<script src="<c:url value='/js/custom/combobox.js'/>"></script>

<script type="text/javascript">

//Insert Popup
function insertFun(){
	var params = {method : "insert" };
	regPopup(params);
};

function regPopup(params){
	$("#progPop").modalWindow('${context}/menu/progRegPopup.do', {reqData : params});
}

function deleteFun(progId){
	if(confirm("삭제하시겠습니까?")) {
		$.ajax({
			async : false,
			cache : false,
			type  : "post",
			url	  : "${context}/menu/progDelete.json" ,
			dataType : "json",
			data : {
				method:	"delete",
				progId:	progId
			},
			success : function(json) {
				if(json.respFlag =="Y"){
					alert('성공적으로 삭제 하였습니다.');
					reloadProgAllList();
				}else{
					alert('삭제 처리중 에러가 발생하였습니다.');
				}
			},
			error : function(response) {
				alert('삭제 처리중 에러가 발생하였습니다.');
			}
		});
	}
}

function modifyFun(progId, progNm, progPath) {
	var params = { method : "update", progId : progId, progNm : progNm, progPath : progPath };
	regPopup(params);
}

function reloadProgAllList(){
	$("#list").jqGrid('setGridParam').trigger('reloadGrid');
}

function cellClick (rowIndex,cellIndex) {
	var recode = $("#list").getRowData(rowIndex);

	if( cellIndex == 4 ){
		modifyFun(recode['progId'], recode['progNm'], recode['progPath']);
	}else if( cellIndex == 5 ){
		deleteFun(recode['progId']);
	}
};

$(function(){
	setSnb(2);

	jqGrid = new JqGrid("#list", true, {
		url : '${pageContext.request.contextPath}/menu/progList.json',
		datatype : "json",
		mtype : "get",
		height: 600,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'프로그램ID',
			'프로그램명',
			'프로그램경로',
			'수정',
			'삭제'
		],
		colModel : [
			{name:'progId', width:90, align:'center',sortable:false},
			{name:'progNm', width:150,  align:'center',sortable:false},
			{name:'progPath', width:230, sortable:false},
			{name:'progModify', width:80, sortable:false, align:'center', formatter:  function  (cellvalue, options, rowObject) {
				   return '<a style="color : blue;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">수정</a>';
			}},
			{name:'progDel', width:80, sortable:false,  align:'center', formatter: function  (cellvalue, options, rowObject) {
				   return '<a style="color : red;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">삭제</a>';
			}}
		],
		cmTemplate: { autoResizable: true, editable: true },
		iconSet: "fontAwesome",
		autoResizing: { compact: true },
		autoencode: true,
		navOptions: { add: false, edit: false, del: false, search: false },
		viewrecords: true,
		gridview : true,
		autowidth : true,
		shrinkToFit : false,
		rownumbers: true
	})
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
					<li><a href="./program_list.html">메뉴 관리</a></li>
					<li class="active">프로그램 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">프로그램 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="frm" id="frm" method="post">
					<div class="section">
						<div class="btn_wrap mg_t10">
							<span class="btn_right">
								<button type="button" class="btn big black" onclick="javascript:insertFun();"><span>프로그램 추가</span></button>
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

	<div id="progPop" class="lp_wrap lp_memberInfo lp_w600"></div>

</div>
</body>
</html>