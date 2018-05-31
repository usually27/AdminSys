<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script type="text/javascript">
var method="${param.method}";
var methodName = "";
if(method == "insert"){
	methodName = "등록";
}else{
	methodName = "수정";
}

</script>

<script type="text/javascript">
var roleId = "${userInfoVO.roleId}";	//권한

$("document").ready(function() {
// 	$('.lp_wrap .lp_inner').draggable(false);

// 	$('#editor').trumbowyg();
// 	$('#editor').trumbowyg({
// 	    btns: [
// 	        ['foreColor', 'backColor']
// 	    ]
// 	});
// 	$(".integer").numeric();
// 	$("#ntContent2").val($("#ntContent2").html().replace("<br>" ,"\n"));
	if( method == "update" ){
		//$("#tempTitle").val("${noticeDetail.ntTitle}");
		$("#ntDuring").val("${noticeDetail.ntDuring}");
// 		$("#ntContent2").val("${noticeDetail.ntContent}");
	}

	if( method == "insert" ){
		$("#prtCon1").hide();
		$("#prtCon3").hide();
	}
});

function noticeInsert(){
	if($('#method').val() == "update"){
		confirmMsg = "수정하시겠습니까";
	}else
	{
		var confirmMsg = "등록하시겠습니까?";
	}
	var check = confirm(confirmMsg);
	if(!check) {
		return;
	}

	var chkTitle = $("#ntTitle").val();
	var changeTitle = replaceAll(chkTitle, '&','&amp;', '<','&lt;', '>','&gt;', '"','&quot;'); //제목필터링 기능

	regForm.ntTitle.value = changeTitle;

	if($('#ntPart_pop').val() == ""){
		alert("구분을 선택하세요.");
		$('#ntPart_pop').focus();
		return false;
	}else
		regForm.ntPart.value = $('#ntPart_pop').val();

	if($("#ntTitle").val() == ""){
		alert("제목을 입력하세요.");
		$('#ntTitle').focus();
		return false;
	}

// 	var during = $('#ntDuring').val();
// 	if( during > 0 & during < 31){
// 	}else{
// 		alert("기간은 1일에서 30일 사이로 입력하세요.");
// 		$('#ntDuring').focus();
// 		return false;
// 	}

	if ($('#ntContent2').summernote('isEmpty')){
		alert("내용을 입력하세요.");
		$('#ntContent2').focus();
		return false;
	}
debugger;
	//엔터값 치환
// 	var temCon = $('#ntContent2').val().replace(/\n/g, "<br>");
	$('#ntContent').val($('#ntContent2').summernote('code'));

	var options = {

			//url			: "noticeMgr.do?method=insert",
			url			: "${pageContext.request.contextPath}/board/noticeMgrInsert.json" ,
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			type		: "post",
			dataType 	: "Json",
			success		: function( str ){
				alert("정상적으로 등록 되었습니다.");
				responseResult();}
	};

	try{
		$("#regForm").ajaxSubmit( options );
	}catch(e){
		alert("error= " + e);
	}
}

function responseResult(){
	lp_close('.lp_notice');
	location.href="${pageContext.request.contextPath}/board/noticeInfo.do";
}

function replaceAll(sValue, param1, param2, param3, param4, param5, param6, param7, param8) {
	return sValue.split(param1).join(param2).split(param3).join(param4).split(param5).join(param6).split(param7).join(param8);
}

function noticeDetele(){
	if( confirm("삭제하시겠습니까?") ){
		$.ajax({
			type	: "POST",
			url		: "${pageContext.request.contextPath}/board/noticeMgrDelete.json" ,
			data	: { noticeNum : $("#ntNum").val() },
			dataType:"json",
			cache	: false,
			success	: function( str ){
				alert("정상적으로 삭제가 되었습니다.");
				responseResult();
			}
		});
	}
}

function noticePrint(){
	$("#printControl").hide();
	$("#prtCon1").hide();
	$("#prtCon2").hide();
	$("#prtCon3").hide();
	$("#prtCon4").hide();
	window.print();
	$("#printControl").show();
	$("#prtCon1").show();
	$("#prtCon2").show();
	$("#prtCon3").show();
	$("#prtCon4").show();
}
</script>
<!-- Common Layer Pop -->
<form name="regForm" id="regForm" method="post">
<input type="hidden" id="ntNum" name="ntNum" value="${noticeDetail.ntNum}" />
<input type="hidden" id="ntPart" name="ntPart"  />
<input type="hidden" id="method" name="method" value="${param.method}" />
<input type="hidden" id="ntContent" name="ntContent" value="" />
	<!-- (팝업) 공지사항 작성 -->
	<div class="lp_wrap lp_notice lp_w1200">
		<!-- lp_inner -->
		<div class="lp_inner">
			<div class="lp_header">
				<h1 class="ico ico_star">공지사항 작성</h1>
			</div>
			<!-- lp_body -->
			<div class="lp_body">
				<div class="lp_box">
					<div class="btn_wrap r">
						<button type="button" id="prtCon1" class="btn mid black" onclick="noticePrint();return false;">인쇄</buttion>
						<button type="button" id="prtCon2" class="btn mid black" onclick="noticeInsert();return false;">저장</buttion>
						<button type="button" id="prtCon3" class="btn mid black" onclick="noticeDetele();return false;">삭제</buttion>
<!-- 						<button type="button"  onclick="javascript:lp_close('.lp_notice'); return;" class="btn mid gray">창닫기</buttion> -->
					</div>
					<!-- section -->
					<div class="section">
						<div class="hgroup_wrap">
							<h2>공지사항 작성</h2>
						</div>
						<div class="table_wrap">
							<table class="board_view">
								<colgroup>
									<col width="140">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th><label>구분</label></th>
										<td>
											<select name="ntPart_pop" id="ntPart_pop" title="" class="size115">
													<option value="">선택</option>
													<option value="공통">공통</option>
													<option value="상수도">상수도</option>
													<option value="하수도">하수도</option>
													<option value="도로">도로</option>
													<option value="기타">기타</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><label>팝업기간</label></th>
										<td class="input_date" style="width:100%">
										<span class="input_date size120">시작일
<!-- 										<span class="txt_guide mg_l10">시작일</span> -->
											<input type="text" name="ntStart" id="ntStart" title="" onblur="dateCheck('ntStart')" value="" class="datepicker size30p">
											<a href="#ui-datepicker-div" onclick="javascript:openCal('ntStart'); return false;" title="날짜선택 레이어 열기" class="btn_datepicker"><span>날짜 선택</span></a>
										</span>
										
										<span class="input_date size120">종료일
<!-- 											<span class="txt_guide mg_l10">종료일</span> -->
											<input type="text" name="ntEnd" id="ntEnd" title="" onblur="dateCheck('ntEnd')" value="" class="datepicker size30p">
											<a href="#ui-datepicker-div" onclick="javascript:openCal('ntEnd'); return false;" title="날짜선택 레이어 열기" class="btn_datepicker"><span>날짜 선택</span></a>
										</span>
										</td>
									</tr>
									<tr>
										<th><label>제목</label></th>
										<td>
											<input type="text" name="ntTitle" id="ntTitle" maxlength="100" title="" class="size100p" >
										</td>
									</tr>
									<tr>
										<th><label>내용</label></th>
										<td>
												<div id ="ntContent2"></div>
<!-- 											<textarea name="ntContent2" id="ntContent2" rows="15" cols="130" class="size100p"></textarea> -->
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!--//section -->
				</div>
			</div>
			<!-- //lp_body -->
			<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_notice'); return;"></a>
		</div>
		<!-- //lp_inner -->
	</div>
	<!--//(팝업) 공지사항 작성 -->
</form>
	<!--//Common Layer Pop -->