<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>공간정보통합관리시스템</title>
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.min.css'/>" type="text/css" />
<%-- <link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" /> --%>
<link rel="stylesheet" href="<c:url value='/css/com/base.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui_style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui.jqgrid.css'/>" type="text/css"><!-- Plug-in -->
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/font-awesome.css'/>" type="text/css">

<%-- <link rel="stylesheet" href="<c:url value='/js/plugins/trumbowyg/ui/trumbowyg.min.css'/>" type="text/css" /> --%>
<%-- <link rel="stylesheet" href="<c:url value='/js/plugins/trumbowyg/plugins/colors/ui/trumbowyg.colors.css'/>" type="text/css" /> --%>
<link rel="stylesheet" href="<c:url value='/js/plugins/summernote/summernote-lite.css'/>" type="text/css" />

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

<%-- <script src="<c:url value='/js/plugins/trumbowyg/trumbowyg.min.js'/>"></script> --%>
<%-- <script src="<c:url value='/js/plugins/trumbowyg/plugins/colors/trumbowyg.colors.min.js'/>"></script> --%>
<script src="<c:url value='/js/plugins/summernote/summernote-lite.js'/>"></script>
<script type="text/javascript">
<!--
jQuery(document).ready(function(e) {
	setSnb(1);
});
-->
</script>
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
					<li><a href="./notice_list.html">게시판 관리</a></li>
					<li class="active">공지사항 관리</li>
				</ul>
				<!--// Breadcrumb -->

				<h1 class="currentPage">공지사항 관리</h1>
			</div>
			<!--// Content Header -->

			<!-- Content body -->
			<div class="content_body">

				<!-- Board Search -->
				<form name="frm" id="frm" method="post" onSubmit="">

				<div class="section">
					<div class="table_wrap">
						<table border="1" cellspacing="0" class="board_search">
							<caption>게시물 검색</caption>
							<colgroup>
								<col width="140">
								<col width="*">
								<col width="140">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="">구분</label></th>
									<td>
										<select id="ntPart" name="ntPart" class="size115">
											<option value="" selected>전체</option>
											<option value="공통" >공통</option>
											<option value="상수도" >상수도</option>
											<option value="하수도" >하수도</option>
											<option value="도로" >도로</option>
											<option value="기타" >기타</option>
										</select>
									</td>
									<th><label for="">조건</label></th>
									<td>
										<select id="searchType" name="searchType" class="size115">
												<option value="nt_title">제목</option>
												<option value="nt_content">내용</option>
										</select>
										<input type="text" id="word" name="word" maxlength="50" title="검색어입력" class="size115">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn_wrap mg_t10">
						<span class="btn_right">
							<button type="submit" class="btn big blue" onclick="searchNotice();return false;" ><span>검색</span></button>
							<button type="button" onclick="noticeInsertPop();return false;" class="btn big black"><span>공지사항 작성</span></button>
						</span>
					</div>
				</div>
				</form>
				<!--// Board Search -->

				<!-- Board List -->
				<div class="section">
					<div class="table_wrap">
						<table id="list">
						</table>
					</div>

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
<%@ include file="./noticePop.jsp"%>
</body>

<script type="text/javascript">

var	jqGrid = null;

function searchList(){
	jqGrid.reloadGrid({page : '20'});
}
function noticeInsertPop(){
		$('#ntContent2').summernote('reset');
		$('#ntContent2').summernote('ntContent2.insertText', '');
		$("#prtCon2").text('저장');
		$("#ntNum").val('');
		$("#ntPart_pop").val('');
		$("#ntTitle").val('');
		$("#ntStart").val('');
		$("#ntEnd").val('');
		$("#ntContent2").val('');
		$("#method").val("insert");
		lp_open('.lp_notice');
 		$("#prtCon3").hide();

	}
function noticeModifyPop(rowIndex){
	var recode = $("#list").getRowData(rowIndex);
		$("#prtCon2").text('수정');
		$("#ntNum").val(recode['ntNum']);
		$("#ntPart_pop").val(recode['ntPart']);
		$("#ntTitle").val(recode['ntTitle']);
		$("#ntStart").val(recode['ntStart']);
		$("#ntEnd").val(recode['ntEnd']);
		var temCon = recode['ntContent'].replace(/<br>/g ,"\n");
// 		$('#ntContent2').summernote('ntContent2.insertText', temCon);
		$('#ntContent2').summernote('code', recode['ntContent']);
// 		$('#ntContent2').val(temCon);
// 		var temCon = recode['ntContent'].replace(/\n/g ,"\n");
// 		$("#ntContent2").val(recode['ntContent']);
		$("#method").val("update");
	lp_open('.lp_notice');
 	$("#prtCon3").show();

}

function noticeDetail( noticeNum ){
	$('#ntContent2').summernote('ntContent2.insertText', recode['ntContent']);
		var updateNoticePopMgr = window.open('noticeMgrInsertPopup.do?method=update&noticeNum='+noticeNum, 'updateNoticePopMgr', 'centerMiddle', 700, 800, 'no', 'no');
		updateNoticePopMgr.focus();

}

function insertNotice(){
	var insertNoticePop = window.open('noticeMgrInsertPopup.do?method=insert', 'insertNoticePop', 'centerMiddle', 1200, 800, 'no', 'no');
	insertNoticePop.focus();
}
function searchNotice(){
	jqGrid.reloadGrid({postData : $("#frm").getFormToJsonData()})

}

$(function(){
	$('#ntContent2').summernote({
		  toolbar: [
		            // [groupName, [list of button]]
		            ['style', ['bold', 'underline', 'clear']],
		            ['font', ['strikethrough']],
		            ['fontsize', ['fontsize']],
		            ['color', ['color']]
		          ],
	        height: 300
	      });
	jqGrid = new JqGrid("#list", true, {
		url : "${pageContext.request.contextPath}/board/noticeMgrList.json",
		datatype : "json",
		jsonReader : {
			root: 'root'
		},
		colNames:['번호','업무구분', '제목', '등록일','조회수','ntTitle', 'ntContent', 'ntStart', 'ntEnd'],
		colModel:[

		{name:'ntNum',  width:200, align:'center'},
		{name:'ntPart', width:200, align:'center'},
		{name:'ntTitle', width:200, align:'center', formatter:  function  (value, options, record) {
			   return '<a style="color:blue;" href="javascript:noticeModifyPop(\''+options.rowId+'\')">' + value + '</a>';
		}},
		{name:'ntDate', width:200, align:'center'},
// 		{name:'ntDuring', width:200, align:'center'},
		{name:'ntReadnum', width:200, align:'center'},
		{name: 'ntTitle',		hidden:true},
		{name: 'ntContent',	hidden:true},
		{name: 'ntStart',	hidden:true},
		{name: 'ntEnd',	hidden:true}
		],
		pager : true,
		rowNum : 20,
		rownumbers: false,
	});
	});



</script>