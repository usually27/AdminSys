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

	$Grid = $("#list");
	$Grid.jqGrid({
		url : '${context}/layer/layerInfoList.json',
		datatype : "json",
		mtype : "get",
		height: 700,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'레이어 명',
			'연결 레이어',
			'테이블 명',
			'레이어 순서',
			'추가',
			'수정',
			'삭제',
			'menuId',
			'menuLevel',
			'parMenuId',
			'orderNo',
			'topMenuId',
			'childCount',
			'layerId',
			'layerNm',
			'layerPath',
			'isLeaf',
			'parMenuLevel',
			'parMenuNm',
			'사용여부',
			'menuNm',
		],
		colModel : [
			{name:'menuNm', width:300, sortable:false},
			{name:'tableName', width:300, sortable:false},
			{name:'tableNm', hidden:true},
			{name:'menuorder', width:70, sortable:false, align:'center', formatter: function (cellvalue, options, record) {
				 if(record['menuNm'] == '레이어'){
 					return '';
 				}else{
 					return '<a style="color : blue;" href="javascript:menuMove(\'up\',\'' + record['menuId'] + '\',\'' + record['parMenuId'] + '\',\'' + record['orderNo'] + '\',\'' + record['menuLevel'] + '\',\'' + record['parMenuLevel'] + '\');">△</a>' +
    							'&nbsp;&nbsp;&nbsp;&nbsp;<a style="color : blue;"  href="javascript:menuMove(\'down\',\'' + record['menuId'] + '\',\'' + record['parMenuId'] + '\',\'' + record['orderNo']  + '\',\'' + record['menuLevel'] + '\',\'' + record['parMenuLevel'] + '\');">▽</a>';
 				}
			}},
			{name:'menuinsert', width:70, sortable:false, align:'center', formatter: function (cellvalue, options, record) {
				if(record['menuLevel'] == '3'){
					return '';
				}else{
					  return '<a style="color : blue;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">추가</a>';
				}
			}},
			{name:'menuupdate', width:70, sortable:false, align:'center', formatter:  function (cellvalue, options, record) {
				if(record['menuNm'] == '레이어'){
					return '';
				}else{
					  return '<a style="color : blue;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">수정</a>';
				}
			}},
			{name:'menudel', width:70, sortable:false, align:'center', formatter:  function (cellvalue, options, record) {
				if(record['menuNm'] == '레이어'){
					return '';
				}else{
					 return '<a style="color : red;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">삭제</a>';
				}
			}},
			{name: 'menuId',		hidden:true, key:true, sortable:false},
			{name: 'menuLevel',		hidden:true},
			{name: 'parMenuId',		hidden:true},
			{name: 'orderNo',		hidden:true},
			{name: 'topMenuId',		hidden:true},
			{name: 'childCount',	hidden:true},
			{name: 'layerId',		hidden:true},
			{name: 'layerNm',		hidden:true},
			{name: 'layerPath',		hidden:true},
			{name: 'isLeaf',		hidden:true},
			{name: 'parMenuLevel',	hidden:true},
			{name: 'parMenuNm',		hidden:true},
			{name: 'useFlag', width:70, align:'center', sortable:false},
			{name: 'menuNm',		hidden:true}
		],
		cmTemplate: { autoResizable: true, editable: true },
// 		iconSet: "fontAwesome",
		autoResizing: { compact: true },
		autoencode: true,
		treeGridModel: 'adjacency',
		treeGrid: true,
		tree_root_level: 0,
		treeReader: {
			level_field : "treeLevel",
			parent_id_field: "parMenuId",
			leaf_field : "isLeaf",
			expanded_field : true
		},
		viewrecords: true,
		gridview : true,
		autowidth : true,
		shrinkToFit : false,
		gridComplete: function() {
			var rData = $("#list").jqGrid('getGridParam','data');
			if (rData[0]) {
				setTimeout(function(){
					for (i=0;i<rData.length;i++) {
						$("#list").jqGrid('expandRow',rData[i]);
						$("#list").jqGrid('expandNode',rData[i]);
					}
				}, 0);
			}
		}
	})



});

function regPopup(){
	var params = {
		method : $("#method").val(),
		menuLevel : $("#menuLevel").val(),
		menuId : $("#menuId").val(),
		menuName : $("#menuName").val(),
		parMenu : $("#parMenu").val(),
		topMenu : $("#topMenu").val(),
		layerId : $("#layerId").val(),
		layerName : $("#layerName").val(),
		tableName : $("#tableName").val(),
		layerPath : $("#layerPath").val(),
		parmenuLevel : $("#parmenuLevel").val(),
		useFlag : $("#useFlag").val(),
		parmenuNm : $("#parmenuNm").val()
	};
	$("#lyrPop").modalWindow('${context}/layer/layerMenuRegPopup.do', {reqData : params});

}

function menuMove(gb,menuId,parMenuId,orderNo,menuLevel,parMenuLevel){

		if(!confirm("레이어 메뉴를 이동하시겠습니까?")) {
			return;
		}
		$.ajax({
			type		: "post",
			url			: "${context}/layer/moveMenuInfo.json",
			data:{
				method : "menumove",
				upDownGb : gb,
				menuId : menuId,
				parMenuId : parMenuId,
				orderNo : orderNo,
				menuLevel : menuLevel,
				parMenuLevel : parMenuLevel
			},
			dataType	: "json",
			cache		: false,
			async 		: false,
			success		: function( data ){
				if(data.move_result == 99){
					if( gb == "up" ){
						msg = "더 이상 위로 이동할 수 없습니다.";
						alert( msg );
					}else{
						msg = "더 이상 아래로 이동할 수 없습니다.";
						alert( msg );
					}
				}else if(data.move_result==0){
					msg = "메뉴 이동에 실패하였습니다.";
					alert( msg );
				}else{
					reloadMenuList();
				}
			}
		});

}

function reloadMenuList(){
	$("#list").jqGrid('setGridParam',{
		url : '${context}/layer/layerInfoList.json',
		datatype: "json",
		}).trigger('reloadGrid');
}

function cellClick (rowIndex,cellIndex) {
	var recode = $("#list").getRowData(rowIndex);

	if( cellIndex == 4 ){
		//마지막노드일경우 추가팝업 띄우지 않는다.
		if( recode['menuLevel'] == '3' ){
			return false;
		}

		$('#method').val('insert');
		$('#menuLevel').val( recode['menuLevel']);
		$('#menuName').val( recode['menuNm']);
		$('#menuId').val( recode['menuId']);
		$('#parMenu').val( recode['parMenuId']);
		$('#topMenu').val( recode['topMenuId']);
		$('#layerId').val( recode['layerId']);
		$('#layerName').val( recode['layerNm']);
		$('#tableName').val( recode['tableNm']);
		$('#layerPath').val( recode['layerPath']);
		$('#parmenuLevel').val( recode['parMenuLevel']);
		$('#parmenuNm').val( recode['parMenuNm']);
		$('#useFlag').val( recode['useFlag']);

		regPopup();

	}else if( cellIndex == 5 ){

		if( recode['menuNm'] == '루트메뉴' ){
			return false;
		}

		$('#method').val('update');
		$('#menuLevel').val( recode['menuLevel']);
		$('#menuName').val( recode['menuNm']);
		$('#menuId').val( recode['menuId']);
		$('#parMenu').val( recode['parMenuId']);
		$('#topMenu').val( recode['topMenuId']);
		$('#layerId').val( recode['layerId']);
		$('#layerName').val( recode['layerNm']);
		$('#tableName').val( recode['tableNm']);
		$('#layerPath').val( recode['layerPath']);
		$('#parmenuLevel').val( recode['parMenuLevel']);
		$('#parmenuNm').val( recode['parMenuNm']);
		$('#useFlag').val( recode['useFlag']);

		regPopup();

	}else if( cellIndex == 6 ){
		if( recode['childCount'] != 0 ){
			alert('하위 메뉴가 있어서 삭제 불가능합니다.');
		}else if( recode['menuNm'] == '루트메뉴' ){
			return false;
		}else{
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					type			: "post",
					url				: "${context}/layer/deleteLayerMenu.json",
					data			:{
						method : "delete",
						menuId : recode['menuId'],
						parMenuId : recode['parMenuId']
					},
					dataType	: "json",
					cache		: false,
					async 		: false,
					success		: function( json ){
						if(json.respFlag == "Y"){
							alert('성공적으로 삭제 하였습니다.');
							reloadMenuList();
						}else{
							alert('삭제 처리중 에러가 발생하였습니다.');
						}
					}
				});
			}
		}
	}
};



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
					<li><a href="/layer/layerInfo.do">레이어 관리</a></li>
					<li class="active">레이어 메뉴 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">레이어 메뉴 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form id="frm" name="frm" method="post">
					<input type="hidden" id="method" name="method"/>
					<input type="hidden" id="menuLevel" name="menuLevel"/>
					<input type="hidden" id="menuId" name="menuId"/>
					<input type="hidden" id="menuName" name="menuName"/>
					<input type="hidden" id="parMenu" name="parMenu"/>
					<input type="hidden" id="topMenu" name="topMenu"/>
					<input type="hidden" id="layerId" name="layerId"/>
					<input type="hidden" id="layerName" name="layerName"/>
					<input type="hidden" id="tableName" name="tableName"/>
					<input type="hidden" id="layerPath" name="layerPath"/>
					<input type="hidden" id="parmenuLevel" name="parmenuLevel"/>
					<input type="hidden" id="useFlag" name="useFlag" />
					<input type="hidden" id="parmenuNm" name="parmenuNm"/>
					<div class="portlet light bordered">
						<div class="section">
							<table id="list"></table>
						</div>
					</div>
				</form>
				<!--// Board Search -->
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