<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var layerId = "${params.progId}";
var menuLevel = "${params.menuLevel}";
var updateGb = "${params.updateGb}";

function searchProgList() {
	var progNm = $("#progGbNm").val();
	$("#progGbNm").val(progNm.trim());

	$("#searchList").jqGrid('setGridParam', {
		url : "${context}/menu/progSearchPopup.json",
		datatype : "json",
		"postData" : { progGb : $("#progGb").val(), progGbNm : $("#progGbNm").val() }
	}).trigger('reloadGrid');
}

$(function() {
	$Grid = $("#searchList");
	$Grid.jqGrid({
		url : '${context}/menu/progSearchPopup.json',
		datatype : "json",
		mtype : "get",
		height: 300,
		jsonReader : {
			root: 'root'
		},
		colNames : [
			'프로그램 ID',
			'프로그램 명',
			'프로그램 경로'
		],
		colModel : [
			{name:'progId',width:75,  align:'center'},
			{name:'progNm',width:95},
			{name:'progPath',width:200}
		],
		viewrecords: true,
		gridview : true,
		autowidth : true,
		shrinkToFit : false,
		rownumbers: true,
		onCellSelect: function(rowid, iCol){
			var recode =	$Grid .getRowData(rowid);
			if((menuLevel == "1" && updateGb =="insert") || (menuLevel == "2" && updateGb =="update")){
				$("#regForm").find("#midProgid").val(recode['progId']);
				$("#regForm").find("#midPrognm").val(recode['progNm']);
				$("#regForm").find("#midProgpath").val(recode['progPath']);
			}else{
				$("#regForm").find("#leafProgid").val(recode['progId']);
				$("#regForm").find("#leafPrognm").val(recode['progNm']);
				$("#regForm").find("#leafProgpath").val(recode['progPath']);
			}
			lp_close('#progSearchPop');
		}
	}).navGrid("#pager", { edit: false, add: false, search: true, del: false });

	$("#progGb").change(function(){
		/* jqGrid 리로드 */
		$("#searchList").jqGrid('setGridParam',{
			url : '${context}/menu/progSearchPopup.json',
			datatype: "json",
			postData : {
				progGb : $(this).val(),
				progGbNm : $("#progGbNm").val()
			}
		}).trigger('reloadGrid');
	});

	$("#close").click(function() {
		lp_close('#progSearchPop');
	});

});

</script>

<!-- lp_inner -->
<div class="lp_inner">
	<div class="lp_header">
		<h1 class="ico ico_star">프로그램 추가</h1>
	</div>
	<!-- lp_body -->
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn mid black" onclick="javascript:searchProgList();">검색</button>
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
								<th><label>프로그램 구분</label></th>
								<td>
									<select name="progGb" id="progGb" class="size115">
										<option value="">-- 전체 --</option>
										<option value="GIS">지도 서비스</option>
										<option value="MGR">시설물 관리</option>
										<option value="STS">통계</option>
										<option value="BRD">게시판</option>
										<option value="SYS">시스템 관리</option>
									</select>
								</td>
								<th><label>프로그램 명</label></th>
								<td colspan="2">
									<input type="text" name="progGbNm" id="progGbNm" class="size160" style="IME-MODE:active">
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