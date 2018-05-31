<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var method = "${params.method}";
var methodName = "";

if(method == "insert") {
	methodName = "추가";
} else {
	methodName = "수정";
}

$(function (){
	if(method == "update") {
		$("#pageTitle").text("권한 "+methodName);
		$("#role_nm").val("${params.roleNm}");
		$("#role_desc").val("${params.roleDesc}");
		$("#use_flag").val("${params.useFlag}");
	} else {
		$("#pageTitle").text("권한 "+methodName);
		$("#role_nm").val("");
		$("#role_desc").val("");
		$("#use_flag").val("Y");
	}
});

function authProc(){
	if( $('#role_nm').val()  == '' ){
		alert("권한 명을 입력하세요.");
		return false;
	}else if( $('#role_desc').val()  == '' ){
		alert("권한 설명을 입력하세요.");
		return false;
	}

	$.ajax({
		async : false,
		cache : false,
		type  : "POST",
		url	  : "${context}/menu/authRegPopup.json" ,
		dataType : "json",
		data : {
			roleId : $("#role_id").val(),
			workGubun : $("#workGubun").val(),
			roleNm : $("#role_nm").val(),
			roleDesc : $("#role_desc").val(),
			useFlag : $("#use_flag").val()
		},
		success : function(json) {
			if(json.respFlag == 'Y'){
				if( method == "update" ){
					alert("정상적으로 수정되었습니다.");
				}else{
					alert("정상적으로 저장되었습니다.");
				}
				responseResult();
			}else{
				alert("오류발생, 다시 시도하여 주십시오");
			}

		},
		error : function(response) {
			alert("오류발생, 다시 시도하여 주십시오");
		}
	});
};

function responseResult(){
	lp_close('.lp_memberInfo');
	reloadList();
};
</script>

<div class="lp_inner">
	<div class="lp_header">
		<h1 id="pageTitle" class="ico ico_star"></h1>
	</div>
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn big black" onclick="authProc();">저장</button>
			</div>
			<form id="regForm" name="regForm" method="post">
			<input type="hidden" id="role_id" name="role_id" value="${params.roleId}"/>
			<input type="hidden" id="workGubun" name="workGubun" value="${params.method}"/>
			<div class="section">
				<div class="table_wrap">
					<table id="regT" class="board_view">
						<colgroup>
							<col width="150"/>
							<col />
							<col width="150"/>
						</colgroup>
						<tbody>
							<tr>
								<th><label class="est">권한 명</label></th>
								<td>
									<input type="text" id="role_nm" name="role_nm" size="50" style="IME-MODE:active;">
								</td>
							</tr>
							<tr>
								<th><label class="est">권한 설명</label></th>
								<td>
									<input type="text" id="role_desc" name="role_desc" size="50" maxlength="255" style="IME-MODE:active;">
								</td>
							</tr>
							<tr>
								<th><label>사용여부</label></th>
								<td>
									<select id="use_flag" name="use_flag">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</form>
		</div>
	</div>
	<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_memberInfo'); return;"></a>
</div>