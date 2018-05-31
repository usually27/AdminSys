<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var layerId = "${params.layerId}";
var menuLevel = "${params.menuLevel}";
var updateGb = "${params.updateGb}";

function searchLayerList() {
	var layerNm = $("#layerGbNm").val();
	$("#layerGbNm").val(layerNm.trim());

	$("#searchList").jqGrid('setGridParam', {
		url : "${context}/layer/layerSearchList.json",
		datatype : "json",
		"postData" : { layerGb : $("#layerGb").val(), layerGbNm : $("#layerGbNm").val() }
	}).trigger('reloadGrid');
}

$(function() {
	$Grid = $("#searchList");
	$Grid.jqGrid({
		url : '${context}/layer/layerSearchList.json',
		datatype : "json",
		mtype : "get",
		height: 300,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'레이어 ID',
			'레이어 명',
			'테이블 명',
			'레이어 경로'
		],
		colModel : [
			{name:'layerId',width:75,  align:'center'},
			{name:'layerNm',width:95},
			{name:'tableNm',width:137},
			{name:'layerPath',width:200}
		],
		viewrecords: true,
		gridview : true,
		autowidth : true,
		shrinkToFit : false,
		rownumbers: true,
		onCellSelect: function(rowid, iCol){
			var recode =	$Grid .getRowData(rowid);
			if((menuLevel == "1" && updateGb =="insert") || (menuLevel == "2" && updateGb =="update")){
				$("#regForm").find("#midLayerid").val(recode['layerId']);
				$("#regForm").find("#midLayernm").val(recode['layerNm']);
				$("#regForm").find("#midTableNm").val(recode['tableNm']);
				$("#regForm").find("#midLayerpath").val(recode['layerPath']);
				
				
				$("#regForm").find("#midMenuName").val(recode['layerNm']);
			}else{
				$("#regForm").find("#leafLayerid").val(recode['layerId']);
				$("#regForm").find("#leafLayernm").val(recode['layerNm']);
				$("#regForm").find("#leafTableNm").val(recode['tableNm']);
				$("#regForm").find("#leafLayerpath").val(recode['layerPath']);
				
				
				$("#regForm").find("#leafMenuName").val(recode['layerNm']);
			}
			lp_close('#lyrSearchPop');
		}
	}).navGrid("#pager", { edit: false, add: false, search: true, del: false });

	$("#layerGb").change(function(){
		/* jqGrid 리로드 */
		$("#searchList").jqGrid('setGridParam',{
			url : '${context}/layer/layerSearchList.json',
			datatype: "json",
			postData : {
				layerGb : $(this).val(),
				layerGbNm : $("#layerGbNm").val()
			}
		}).trigger('reloadGrid');
	});

	$("#close").click(function() {
		lp_close('#lyrSearchPop');
	});

});

</script>

<!-- lp_inner -->
<div class="lp_inner">
	<div class="lp_header">
		<h1 class="ico ico_star">레이어 추가</h1>
	</div>
	<!-- lp_body -->
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn mid black" onclick="javascript:searchLayerList();">검색</button>
			</div>
			<!-- section -->
			<form name="searchForm" id="searchForm" onSubmit="return false;">
			<div class="section">
				<div class="table_wrap">
					<table class="board_view">
						<colgroup>
							<col width="130">
							<col>
							<col width="130">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label>레이어 구분</label></th>
								<td>
									<select name="layerGb" id="layerGb" class="size115">
										<option value="">-- 전체 --</option>
										<option value="BML">기본도</option>
										<option value="WTL">상수도</option>
										<option value="SWL">하수도</option>
										<option value="RDL">도로</option>
										<option value="UML">지하시설물</option>
									</select>
								</td>
								<th><label>레이어 명</label></th>
								<td colspan="2">
									<input type="text" name="layerGbNm" id="layerGbNm" class="size160" style="IME-MODE:active">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<table id="searchList"></table>
			</form>
			<!-- // section -->
		</div>
	</div>
	<!-- // lp_body -->
	<a href="#this" id="close" class="lp_close"></a>
</div>
<!-- // lp_inner -->