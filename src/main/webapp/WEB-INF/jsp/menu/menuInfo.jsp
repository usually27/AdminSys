<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>

<link rel="stylesheet" href="<c:url value='/css/com/base.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui_style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.min.css'/>" type="text/css" />

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
<script src="<c:url value='/js/custom/combobox.js'/>"></script>
<script src="<c:url value='/js/custom/boardCustom.js'/>"></script>
<script type="text/javascript">
		var G = {};
		G.baseUrl = "${context}/";
		</script>

<script type="text/javascript">
//# sourceURL= /menu/menuInfo.jsp
$(function(){
	$Grid = $("#list");
	$Grid.jqGrid({
		url : '${context}/menu/menuInfoList.json',
		datatype : "json",
		mtype : "get",
		height: 700,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'메뉴명',
			'연결프로그램',
			'메뉴순서',
			'추가',
			'수정',
			'삭제',
			'menuId',
			'menuLevel',
			'parMenuId',
			'orderNo',
			'topMenuId',
			'childCount',
			'progId',
			'progNm',
			'progPath',
			'isLeaf',
			'parMenuLevel',
			'parMenuNm',
			'사용여부',
			'menuNm',
		],
		colModel : [
			{name:'menuNm', width:200, sortable:false},
			{name:'progName', sortable:false},
			{name:'menuorder', width:70, sortable:false,  align:'center',formatter: function (cellvalue, options, record) {
				 if(record['menuNm'] == '루트 메뉴'){
 					return '';
 				}else{
 					return '<a style="color : blue;" href="javascript:menuMove(\'up\',\'' + record['menuId'] + '\',\'' + record['parMenuId'] + '\',\'' + record['orderNo'] + '\',\'' + record['menuLevel'] + '\',\'' + record['parMenuLevel'] + '\');">△</a>' +
    							'&nbsp;&nbsp;<a style="color : blue;"  href="javascript:menuMove(\'down\',\'' + record['menuId'] + '\',\'' + record['parMenuId'] + '\',\'' + record['orderNo']  + '\',\'' + record['menuLevel'] + '\',\'' + record['parMenuLevel'] + '\');">▽</a>';
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
				if(record['menuNm'] == '루트 메뉴'){
					return '';
				}else{
					  return '<a style="color : blue;"  href="javascript:cellClick(\''+options.rowId+'\',\''+options.pos+'\');">수정</a>';
				}
			}},
			{name:'menudel', width:70, sortable:false, align:'center', formatter:  function (cellvalue, options, record) {
				if(record['menuNm'] == '루트 메뉴'){
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
			{name: 'progId',		hidden:true},
			{name: 'progNm',		hidden:true},
			{name: 'progPath',		hidden:true},
			{name: 'isLeaf',		hidden:true},
			{name: 'parMenuLevel',	hidden:true},
			{name: 'parMenuNm',		hidden:true},
			{name: 'useFlag', width:70, align:'center', sortable:false},
			{name: 'menuNm',		hidden:true}
		],
		treeGridModel: 'adjacency',
		treeGrid: true,
// 		ExpandColumn: 'desc',
// 		ExpandColClick: true,
		tree_root_level: 0,
		treeReader: {
			level_field : "treeLevel",
			parent_id_field: "parMenuId",
			leaf_field : "isLeaf",
			expanded_field : "ex"
		},
		treeIcons : {
// 			plus:' ui-icon-plus',
// 			minus:'ui-icon-minus',
// 			leaf : 'ui-icon-contact'
			},
		viewrecords: true,
		gridview : true,
// 		autowidth : true,
		shrinkToFit : false,
	}).navGrid("#pager", { edit: false, add: false, search: true, del: false });

});


function regPopup(){
	$("#modal").modalWindow('${context}/menu/menuInfoRegPopup.do', {
		reqData : $("#frm").getFormToJsonData()
	});
}

function menuMove(gb,menuId,parMenuId,orderNo,menuLevel,parMenuLevel){

		if(!confirm("메뉴를 이동하시겠습니까?")) {
			return;
		}
		$.ajax({
			type		: "post",
			url			: "${context}/menu/moveMenuInfo.json",
			data:{
				method:"menumove",
				upDownGb:gb,
				menuId:menuId,
				parMenuId:parMenuId,
				orderNo:orderNo,
				menuLevel:menuLevel,
				parMenuLevel:parMenuLevel
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
					reloadMenuLst();
				}
			}
		});

}

function reloadMenuLst(){
	$("#list").jqGrid('setGridParam',{
		url : '${context}/menu/menuInfoList.json',
		datatype: "json",
		}).trigger('reloadGrid');
}

function cellClick (rowIndex,cellIndex) {

	var recode = $("#list").getRowData(rowIndex);

	if( cellIndex == 3 ){
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
		$('#progId').val( recode['progId']);
		$('#progName').val( recode['progNm']);
		$('#progPath').val( recode['progPath']);
		$('#parmenuLevel').val( recode['parMenuLevel']);
		$('#parmenuNm').val( recode['parMenuNm']);
		$('#useFlag').val( recode['useFlag']);

		regPopup();

	}else if( cellIndex == 4 ){

		if( recode['menuNm'] == '루트메뉴' ){
			return false;
		}

		$('#method').val('update');
		$('#menuLevel').val( recode['menuLevel']);
		$('#menuName').val( recode['menuNm']);
		$('#menuId').val( recode['menuId']);
		$('#parMenu').val( recode['parMenuId']);
		$('#topMenu').val( recode['topMenuId']);
		$('#progId').val( recode['progId']);
		$('#progName').val( recode['progNm']);
		$('#progPath').val( recode['progPath']);
		$('#parmenuLevel').val( recode['parMenuLevel']);
		$('#parmenuNm').val( recode['parMenuNm']);
		$('#useFlag').val( recode['useFlag']);

		regPopup();

	}else if( cellIndex == 5 ){
		if( recode['childCount'] != 0 ){
			alert('하위 메뉴가 있어서 삭제 불가능합니다.');
		}else if( recode['menuNm'] == '루트메뉴' ){
			return false;
		}else{
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					type			: "post",
					url				: "${context}/menu/deleteMenuInfo.json",
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
							reloadMenuLst();
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


<div>
	<h1 class="page-title">
		<i class=" icon-docs font-green"></i> <!-- 레이어 모양 -->
		<span class="caption-subject font-green bold uppercase">메뉴 관리</span>
	</h1>
</div>

	<form id="frm" name="frm" method="post">
		<input type="hidden" id="method" name="method"/>
		<input type="hidden" id="menuLevel" name="menuLevel"/>
		<input type="hidden" id="menuId" name="menuId"/>
		<input type="hidden" id="menuName" name="menuName"/>
		<input type="hidden" id="parMenu" name="parMenu"/>
		<input type="hidden" id="topMenu" name="topMenu"/>
		<input type="hidden" id="progId" name="progId"/>
		<input type="hidden" id="progName" name="progName"/>
		<input type="hidden" id="progPath" name="progPath"/>
		<input type="hidden" id="parmenuLevel" name="parmenuLevel"/>
		<input type="hidden" id="useFlag" name="useFlag" />
		<input type="hidden" id="parmenuNm" name="parmenuNm"/>
		<div class="portlet light bordered">
			<div class="portlet-body">
				<table id="list"></table>
		</div>
			</div>
	</form>

	<div id="modal" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false"></div>


