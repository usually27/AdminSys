<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var roleId = "${params.roleId}";
var userId = "${params.userId}";

function responseResult(){
	alert("성공적으로 수정되었습니다.");
	$("#authList").jqGrid('setGridParam').trigger('reloadGrid');
}

// 권한 저장
$("#authSel").click(function(){
	if(confirm("사용자의 권한 정보를 수정하시겠습니까?")) {
		var chkBoxList =  $.merge(['M000000000'],  $("input:checkbox[name='checkData']:checked").map(function() {
			return $(this).val();
		}).get());

		$.ajax({
			async : false,
			cache : false,
			type  : "post",
			url	  : "${context}/member/menuAuthEdit.json" ,
			dataType : "json",
			data : {
				mappingIdVal : chkBoxList.toString(),
				userId : $("#userId").val(),
				roleId : $("#roleId").val()
			},
			success : function(json) {
				if(json.respFlag == 'Y'){
					responseResult();
				}else{
					alert("오류발생, 다시 시도하여 주십시오");
				}
			},
			error : function(response) {
				alert("오류발생, 다시 시도하여 주십시오");
			}
		});
	}
});

// 권한 초기화
$("#initAuth").click(function() {
	if(confirm("사용자의 메뉴 권한 정보를 초기화하시겠습니까?")) {
		$.ajax({
			async : false,
			cache : false,
			type  : "post",
			url	  : "${context}/member/memberAuthInit.json" ,
			dataType : "json",
			data : {
				userId : $("#userId").val()
			},
			success : function(json) {
				if(json.respFlag == 'Y'){
					responseResult();
				}else{
					alert("오류발생, 다시 시도하여 주십시오");
				}
			},
			error : function(response) {
				alert("오류발생, 다시 시도하여 주십시오");
			}
		});
	}
});

$(function(){
	$Grid = $("#authList");
	$Grid.jqGrid({
		url : '${context}/member/menuAuthList.json',
		datatype : "json",
		mtype : "post",
		postData : {
			roleId : roleId,
			userId : userId
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
			var rData = $("#authList").jqGrid('getGridParam','data');
			if (rData[0]) {
				setTimeout(function(){
					for (i=0;i<rData.length;i++) {
						$("#authList").jqGrid('expandRow',rData[i]);
						$("#authList").jqGrid('expandNode',rData[i]);
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

});

</script>

<div class="lp_inner">
	<div class="lp_header">
		<h1 class="ico ico_star">메뉴 권한 수정</h1>
	</div>
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn big black" name="authSel" id="authSel">저장</button>
				<button type="button" class="btn big blue" name="initAuth" id="initAuth">초기화</button>
			</div>
			<form id="memberAuthForm">
			<input type="hidden" id="userId" name="userId" value="${params.userId}"/>
			<input type="hidden" id="roleId" name="roleId" value="${params.roleId}"/>
			<input type="hidden" id="mappingIdVal" name="mappingIdVal"/>
			</form>
			<div class="row">
				<table  id="authList"></table>
			</div>
		</div>
	</div>
	<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_memberInfo'); return;"></a>
</div>