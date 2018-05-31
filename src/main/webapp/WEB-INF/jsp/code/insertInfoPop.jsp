<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>

<!-- lp_inner -->
<div class="lp_inner">
	<div class="lp_header">
		<h1 id= "pageTitle" class="ico ico_star">코드 추가</h1>
	</div>
	<!-- lp_body -->
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn big black" id="save">저장</button>
			</div>
			<!-- section -->
<form id="insert_Frm" name="insert_Frm">
	<input type="hidden" id="method" name="method" value="${params.method}" />
		<div class="section">
			<div class="table_wrap">
				<table class="board_view" id="regT">
					<tbody>
						<tr>
							<th>코드번호<span class="necesaary">*</span></th>
							<td><input type="text" id="codeNum" name="codeNum"/></td>
						</tr>
						<tr>
							<th>코드한글명<span class="necesaary">*</span></th>
							<td><input type="text" id="codeExp" name="codeExp"/></td>
						</tr>
						<tr>
							<th>코드 아이디<span class="necesaary">*</span></th>
							<td><input type="text" id="codeId" name="codeId"/></td>
						</tr>
						<tr>
							<th>코드 내용<span class="necesaary">*</span></th>
							<td><input type="text" id="codeVal" name="codeVal"/></td>
						</tr>
									<tr>
					<th>사용여부</th>
					<td><select id="codeUse" name="codeUse">
					<option value="Y">Y</option>
					<option value="N">N</option>
					</select></td>
				</tr>
				<tr>
					<th>도로사용</th>
					<td><select id="useRd" name="useRd">
					<option value="Y">Y</option>
					<option value="N">N</option>
					</select></td>
				</tr>
				<tr>
					<th>상수사용</th>
					<td><select id="useWt" name="useWt">
					<option value="Y">Y</option>
					<option value="N">N</option>
					</select></td>
				</tr>
				<tr>
					<th>하수사용</th>
					<td><select id="useSw" name="useSw">
					<option value="Y">Y</option>
					<option value="N">N</option>
					</select></td>
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


<script>
//# sourceURL= /code/selectCUInfoPop.jsp

$(function(){
	var $frm = $("#insert_Frm");

	$("#find").click(function(){
		$("#findFrm").lp_open("${context}/code/SearchPop.do", {
			reqData : {
				title : "코드 검색",
				method : "find"
			},
			width : "1200px"
		});
	});


	$("#save").click(function(){
		if($frm.find("#codeNum").val()==""||$frm.find("#codeExp").val()==""||$frm.find("#codeId").val()==""||$frm.find("#codeVal").val()==""){
			alert("필수값을 입력하세요");
			return;
		}
		if(confirm("저장하시겠습니까?")) {
			var options = {
				url				: "${context}/code/${params.method}Info.json",
				type			: "post",
				dataType		: "json",
				success			:  function(json) {
					if(json.respFlag == "Y"){
						alert("정상적으로 저장되었습니다.");
						reloadList();
// 						$("#list").jqGrid('setGridParam').trigger('reloadGrid');
						lp_close('.lp_memberInfo');

					} else {
						alert("오류발생, 다시 시도하여 주십시오");
					}
				},
				error : function(response) {
					alert("오류발생, 다시 시도하여 주십시오");
				},
			};

			$frm.ajaxSubmit( options );
		}
	});
});

</script>
