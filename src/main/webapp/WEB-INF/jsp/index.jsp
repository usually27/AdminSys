<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>도로및상하수도관리시스템</title>

		<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
		<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
		<script src="<c:url value='/js/com/common.js'/>"></script>

		<script type="text/javascript">
				$(function(){
					$("#userMng").on("click", function(e){
						location.href = "${pageContext.request.contextPath}/member/memberInfo.do";
					});
 
					$("#boardMng").on("click", function(e){
						location.href = "${pageContext.request.contextPath}/board/noticeInfo.do";
					});

					$("#menuMng").on("click", function(e){
						location.href = "${pageContext.request.contextPath}/menu/programList.do";
					});

					$("#layerMng").on("click", function(e){
						location.href = "${pageContext.request.contextPath}/layer/layerInfo.do";
					});

					$("#codeMng").on("click", function(e){
						location.href = "${pageContext.request.contextPath}/code/selectInfoList.do";
					});

// 					$("#dev").on("click", function(e){
// 						$.popupWindow("${pageContext.request.contextPath}/dev/sample.do", { scrollbars : 0 });
// 					});

				});
		</script>
	</head>

	<body>
	<a id='userMng' href="#" >회원 관리</a>
	<br>
	<a id='boardMng' href="#" >게시판 관리</a>
	<br>
	<a id='menuMng' href="#" >메뉴 관리</a>
	<br>
	<a id='layerMng' href="#" >레이어 관리</a>
	<br>
	<a id='codeMng' href="#" >코드 관리</a>
<!-- 	<br> -->
<!-- 	<a id='dev' href="#" >dev</a> -->
	</body>
		</body>
</html>