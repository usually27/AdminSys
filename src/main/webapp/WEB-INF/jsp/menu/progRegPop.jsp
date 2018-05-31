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
	debugger;
	if( method == "update" ){
		$("#pageTitle").text("프로그램 "+methodName);
		$("#regForm").find("#progIdVal").text('${params.progId}');
		$("#regForm").find("#progNm").val('${params.progNm}');
		$("#regForm").find("#progPath").val('${params.progPath}');
		$("table#regT tr:nth-child(1)").remove();
	}else{
		$("#pageTitle").text("프로그램 "+methodName);
		$("#regForm").find("#progGb").val('');
		$("#regForm").find("#progGbNm").val('');
		$("#regForm").find("#progNm").val('');
		$("#regForm").find("#progPath").val('');
		$("table#regT tr:nth-child(2)").remove();
	}
});

function selectGb(){
	$("#regForm").find("#progGbNm").val($("#regForm").find("#progGb").val());
}

function progInfoSave(){
	var stat = confirm("모든 가입정보를 확인하셨습니까?");
	if(!stat) {
		return;
	}

	if( method == "insert" ){
		$("#regForm").find("#workGubun").val('insert');
		if(	$("#regForm").find("#progGbNm").isEmptyAlert("프로그램 구분")) 	return;
	}else{
		$("#regForm").find("#workGubun").val('update');
	}
	if(	$("#regForm").find("#progNm").isEmptyAlert("프로그램 명")) 	return;
	if($("#regForm").find("#progPath").isEmptyAlert("프로그램 경로")) 	return;
	var options = {
		success : function(json) {
			if( method == "update" ){
				alert("정상적으로 수정되었습니다.");
				lp_close('.lp_memberInfo');
				reloadProgAllList();
			}else{
				alert("정상적으로 저장되었습니다.");
				lp_close('.lp_memberInfo');
				reloadProgAllList();
			}
		},
		error : function(response) {
			alert("오류발생, 다시 시도하여 주십시오");
		},
		data :{
			progGbNm : $("#regForm").find("#progGbNm").val()
		},
		url : "${context}/menu/progInfoSave.json",
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
				<button type="button" class="btn big black" onclick="progInfoSave();return false;">저장</button>
			</div>
			<!-- section -->
			<form name="regForm" id="regForm">
			<input type="hidden" name="workGubun" id="workGubun">
				<input type="hidden" name="progId" id="progId" value="${params.progId}">
			<div class="section">
				<div class="table_wrap">
					<table class="board_view" id="regT">
						<colgroup>
							<col width="120">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label>프로그램 구분</label></th>
								<td>
									<select name="progGb" id="progGb" class="size115" onchange="selectGb()">
										<option value="">-- 선택 --</option>
										<option value="GIS">지도 서비스</option>
										<option value="MGR">시설물 관리</option>
										<option value="STS">통계</option>
										<option value="BRD">게시판</option>
										<option value="SYS">시스템 관리</option>
									</select>
								</td>
								<td>
									<input type="text" name="progGbNm" id="progGbNm" class="size115" readonly disabled>
								</td>
							</tr>
							<tr>
								<th>프로그램 ID</th>
								<td colspan="2">
									<span id="progIdVal"></span>
									&nbsp;
								</td>
							</tr>
							<tr>
								<th><label>프로그램 명</label></th>
								<td colspan="2">
									<input type="text" name="progNm" id="progNm" class="size200" style="IME-MODE:active">
								</td>
							</tr>
							<tr>
								<th><label>프로그램 경로</label></th>
								<td colspan="2">
									<input type="text" name="progPath" id="progPath" class="size200">
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