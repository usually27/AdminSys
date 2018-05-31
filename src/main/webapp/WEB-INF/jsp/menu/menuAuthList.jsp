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
					<li><a href="/menu/programList.do">메뉴 관리</a></li>
					<li class="active">메뉴권한 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">메뉴권한 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">
				<div class="board_count">
				<label> 대상권한 선택 </label>
					<select id="roleId" name="roleId" >
					</select>
				<button type="button" class="btn mid gray" name="authSel" id="authSel">저장</button>
				</div>

				<!-- Board Search -->
				<form id="frm" action="" method="post" >
					<input type="hidden" name="authVal" id="authVal">
					<input type="hidden" name="mappingIdVal" id="mappingIdVal">

				</form>
				<!--// Board Search -->

				<!-- Board List -->
				<div class="section">
					<table id="list"></table>
				</div>
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

</div>
</body>
</html>

<script type="text/javascript">
//# sourceURL= /menu/menuAuth.jsp

function reloadMenuAuth(){
	$("#list").jqGrid('setGridParam',{
		postData : {
			roleId : $("#roleIdSelect").val(),
		},
		}).trigger('reloadGrid');
}

function responseResult(){
	alert("성공적으로 수정되었습니다.");
	reloadMenuAuth();
}


$(function(){
	setSnb(2);

	$Grid = $("#list");
	$Grid.jqGrid({
		url : '${context}/menu/menuAuthList.json',
		datatype : "json",
		mtype : "post",
		postData : {
			roleId : 'R0001',
		},
		height: 700,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'메뉴명',
			'메뉴 ID',
			'연결프로그램',
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
			'mappingMenuId',
			'사용여부'
		],
		colModel : [
			{name:'menuNm', width:200, sortable:false,formatter: function (cellvalue, options, record) {
				if(record['menuNm'] == '루트 메뉴'){
					return cellvalue;
				}
				if(record['mappingMenuId'] == 'TRUE'){
					return '<input type="checkbox" name="checkData" parValue="'+record['parMenuId']+'" value="'+record['menuId']+'" checked="true" index="1"/> '+cellvalue ;
				}else{
					return '<input type="checkbox" name="checkData" parValue="'+record['parMenuId']+'" value="'+record['menuId']+'" index="1"/> '+cellvalue;
				}
			}},
			{name:'menuId', width:100, align:'center', key:true, sortable:false},
			{name:'progName',	sortable:false},
			{name: 'menuLevel',		hidden:true},
			{name: 'parMenuId',		hidden:true},
			{name: 'menuOrderNo',	hidden:true},
			{name: 'topMenuId',		hidden:true},
			{name: 'childCount',	hidden:true},
			{name: 'progId',		hidden:true},
			{name: 'progNm',		hidden:true},
			{name: 'progPath',		hidden:true},
			{name: 'isLeaf',		hidden:true},
			{name: 'parMenuLevel',	hidden:true},
			{name: 'parMenuNm',		hidden:true},
			{name: 'mappingMenuId',		hidden:true},
			{name: 'useFlag', width:100, sortable:false,align:'center'}
		],
		treeGridModel: 'adjacency',
		treeGrid: true,
		tree_root_level: 0,
		treeReader: {
			level_field : "treeLevel",
			parent_id_field: "parMenuId",
			leaf_field : "isLeaf",
			expanded_field : "ex"
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
		},
		loadComplete : function(data){
			$("input:checkbox[name='checkData']").change(function() {
				var parValue = $(this).attr("parValue");
				var value = $(this).val();
				var idx = $(this).attr("index");
				var chk = $(this).is(":checked");
				$("input:checkbox[name='checkData']").each(function() {
					if(parValue == "M000000000") {
						if(value == $(this).attr("parValue")) {
							if(idx == "2") {
								$(this).prop('checked', chk).trigger("change");
							} else if(idx == "1" && idx == $(this).attr("index")) {
								$(this).prop('checked', chk).trigger("change");
							}
						} else if(value == $(this).val()) {
							if(idx == "2" && $(this).attr("index") == "1") {
								$(this).prop('checked', chk).trigger("change");
							}
						}
					} else {
						if(value == $(this).attr("parValue")) {
							if(idx == "2") {
								$(this).prop('checked', chk).trigger("change");
							} else if(idx == "1" && idx == $(this).attr("index")) {
								$(this).prop('checked', chk).trigger("change");
							}
						} else if(value == $(this).val()) {
							if(idx == "2" && $(this).attr("index") == "1") {
								$(this).prop('checked', chk).trigger("change");
							}
						}
					}
				});
			});
		}
	}).navGrid("#pager", { edit: false, add: false, search: true, del: false });

	/* 권한 콤보 */
	var comboArea = new AjaxComboBox("#roleId", {
		url			: "<c:url value='/common/util/code/combobox.json?codegroup=authCode' />"
	}).load({select: "R0001"});

	/* 권한 변경 이벤트 */
	$("#roleId").change(function(){
		/* jqGrid 리로드 */
		$Grid.jqGrid('setGridParam',{
				url : '${context}/menu/menuAuthList.json',
				datatype: "json",
				postData : {	roleId : $(this).val()}
				}).trigger('reloadGrid');
	});

	$("#authSel").click(function(){
		var check = confirm("지금의 권한 정보로 수정하시겠습니까?");

		if(!check) {
			return;
		}

		var chkBoxList =  $.merge(['M000000000'],  $("input:checkbox[name='checkData']:checked").map(function() {
				return $(this).val();
			}).get());

		$.ajax({
			async : false,
			cache : false,
			type  : "post",
			url	  : "${context}/menu/menuAuthEdit.json" ,
			dataType : "json",
			data : {
				mappingIdVal 	: chkBoxList.toString(),
				authVal 		: $("#roleId").val()
			},
			success : function(json) {
				if(json.respFlag == 'Y'){
					responseResult();
				}else if(json.respFlag == 'R'){
					alert("권한이 없습니다.");
				}else{
					alert("오류발생, 다시 시도하여 주십시오");
				}
			},
			error : function(response) {
				alert("오류발생, 다시 시도하여 주십시오");
			}
		});
	});
});
</script>