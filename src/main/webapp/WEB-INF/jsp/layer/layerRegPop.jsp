<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var method="${params.method}";
var methodName = "";

if(method == "insert"){
	methodName = "등록";
}else{
	methodName = "수정";
}

$(function() {
	if( method == "update" ){
		$("#pageTitle").text("레이어 "+methodName);
		$("#regForm").find("#layerIdVal").text('${param.layerId}');
		$("#regForm").find("#layerNm").val('${param.layerNm}');
		$("#regForm").find("#layerPath").val('${param.layerPath}');
		$("#regForm").find("#tableNm").val('${param.tableNm}');
		$("table#regT tr:nth-child(1)").remove();
	}else{
		$("#pageTitle").text("레이어 "+methodName);
		$("#regForm").find("#layerGb").val('');
		$("#regForm").find("#layerGbNm").val('');
		$("#regForm").find("#layerNm").val('');
		$("#regForm").find("#layerPath").val('');
		$("#regForm").find("#tableNm").val('');
		$("table#regT tr:nth-child(2)").remove();
	}
});

function selectGb(){
	$("#regForm").find("#layerGbNm").val($("#regForm").find("#layerGb").val());
}

function layerInfoSave(){
	var stat = confirm("모든 가입정보를 확인하셨습니까?");
	if(!stat) {
		return;
	}

	if( method == "insert" ){
		$("#regForm").find("#workGubun").val('insert');
		if(	$("#regForm").find("#layerGbNm").isEmptyAlert("레이어 구분")) 	return;
	}else{
		$("#regForm").find("#workGubun").val('update');
	}
	if(	$("#regForm").find("#layerNm").isEmptyAlert("레이어 명")) 	return;
	if($("#regForm").find("#layerPath").isEmptyAlert("레이어 경로")) 	return;
	if($("#regForm").find("#tableNm").isEmptyAlert("테이블 명")) 	return;
	var options = {
		success : function(json) {
			if( method == "update" ){
				alert("정상적으로 수정되었습니다.");
				lp_close('.lp_memberInfo');
				reloadList();
			}else{
				alert("정상적으로 저장되었습니다.");
				lp_close('.lp_memberInfo');
				reloadList();
			}
		},
		error : function(response) {
			alert("오류발생, 다시 시도하여 주십시오");
		},
		data :{
			layerGbNm : $("#regForm").find("#layerGbNm").val()
		},
		url : "${context}/layer/layerInfoSave.json",
		type : "post",
		dataType : "Json"
	};
	$("#regForm").ajaxSubmit( options );
}

</script>

<!-- lp_inner -->
<div class="lp_inner">
	<div class="lp_header">
		<h1 id= "pageTitle" class="ico ico_star"></h1>
	</div>
	<!-- lp_body -->
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn big black" onclick="layerInfoSave();return false;">저장</button>
			</div>
			<!-- section -->
			<form name="regForm" id="regForm">
			<input type="hidden" name="workGubun" id="workGubun">
				<input type="hidden" name="layerId" id="layerId" value="${param.layerId}">
			<div class="section">
				<div class="table_wrap">
					<table class="board_view" id="regT">
						<colgroup>
							<col width="100">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label>레이어 구분</label></th>
								<td>
									<select name="layerGb" id="layerGb" class="size115" onchange="selectGb()">
										<option value="">-- 선택 --</option>
										<option value="WTL">상수도</option>
										<option value="SWL">하수도</option>
										<option value="RDL">도로</option>
										<option value="UML">지하시설물</option>
										<option value="BML">기본도</option>
									</select>
								</td>
								<td>
									<input type="text" name="layerGbNm" id="layerGbNm" class="size115" readonly disabled>
								</td>
							</tr>
							<tr>
								<th>레이어 ID</th>
								<td colspan="2">
									<span id="layerIdVal"></span>
									&nbsp;
								</td>
							</tr>
							<tr>
								<th><label>테이블 명</label></th>
								<td colspan="2">
									<input type="text" name="tableNm" id="tableNm" class="size200">
								</td>
							</tr>
							<tr>
								<th><label>레이어 명</label></th>
								<td colspan="2">
									<input type="text" name="layerNm" id="layerNm" class="size200" style="IME-MODE:active">
								</td>
							</tr>
							<tr>
								<th><label>레이어 경로</label></th>
								<td colspan="2">
									<input type="text" name="layerPath" id="layerPath" class="size200">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</form>
			<!-- // section -->
		</div>
	</div>
	<!-- // lp_body -->
	<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_memberInfo'); return;"></a>
</div>
<!-- // lp_inner -->