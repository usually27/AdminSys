<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>

<html lang="ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" id="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>가이드 - 공간정보 통합관리시스템</title>
<meta name="Keywords" content="광주광역시 공간정보 통합관리시스템">
<meta name="Description" content="광주광역시 공간정보 통합관리시스템 페이지입니다.">

<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css" /><!-- subPage -->

<script src="<c:url value='/js/plugins/jquery/jquery-3.2.1.min.js'/>"></script>
<script src="<c:url value='/js/plugins/jqueryui/jquery-ui.min.js'/>"></script>

<script src="<c:url value='/js/plugins/jquery/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/com/common-ui.js'/>"></script>

<script type="text/javascript">
// jQuery(document).ready(function(e){
// 	// Loading
// 	showLoading();

// 	$(document).on('click','.loading_wrap',function(e){ // 임시
// 		$(this).hide();
// 	});

// 	// Snb메뉴 활성화
// 	setSnb (3);

// 	// Slider
// 	var prodItem = $('.slider').bxSlider({
// 		//slideWidth: 301,
// 		//slideMargin: 20,
// 		//maxSlides: maxLen,
// 		//minSlides: minLen,
// 		//moveSlides:slideNum,
// 		//nextText: 'Next',
// 		//prevText: 'Prev',
// 		autoControls: true,
// 		//responsive: false,
// 		auto: false,
// 		pager:false,
// 		infiniteLoop:false,
// 		hideControlOnEnd: true
// 	});
// });
</script>

</head>
<body class="snb_open">

<c:forEach  var="ds" items="${resultList}" varStatus="status">
	   ${ds.GID },${ds.OBJECTID }, ${ds.LANDCODE }, ${ds.U_NAME }, ${ds.U_NUMBER }
	<br>
</c:forEach>
</body>
</html>