<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">


<title>공간정보통합관리시스템</title>
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />
<link rel="stylesheet" href="/css/com/base.css" type="text/css">
<link rel="stylesheet" href="/css/com/ui_style.css" type="text/css">
<link rel="stylesheet" href="/css/com/ui.jqgrid.css" type="text/css"><!-- Plug-in -->
<link rel="stylesheet" href="/css/com/common.css" type="text/css">
<link rel="stylesheet" href="/css/com/layout.css" type="text/css">
<link rel="stylesheet" href="/css/com/content.css" type="text/css">

<script type="text/javascript" src="/js/publish/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/js/publish/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="/js/publish/jquery.jqGrid.min.js"></script><!-- Plug-in -->
<script type="text/javascript" src="/js/publish/common-ui.js"></script>

<script src="<c:url value='/js/com/common.js'/>"></script>
<script src="<c:url value='/js/custom/common.js'/>"></script>
<script src="<c:url value='/js/custom/boardCustom.js'/>"></script>
<script type="text/javascript">
<!--
jQuery(document).ready(function(e) {
	setSnb(1);	
});
//-->
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
					<li class="active">매거진 관리</li>
				</ul>
				<!--// Breadcrumb -->
				
				<h1 class="currentPage">매거진 관리</h1>
			</div>
			<!--// Content Header -->
			
			<!-- Content body -->
			<div class="content_body">
			
				<!-- Board Search -->
				<form name="SearchFrm" id="SearchFrm" method="post" onSubmit="">
				
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
										<select name="" id="" title="" class="size115">
											<option>선택</option>
										</select>
									</td>
									<th><label for="">조건</label></th>
									<td>
										<select name="" id="" title="" class="size115">
											<option value="0">제목</option>
										</select>
										<input type="text" name="" id="" maxlength="50" title="검색어입력" class="size115">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn_wrap mg_t10">
						<span class="btn_right">
							<button type="submit" class="btn mid blue"><span>검색</span></button>
						</span>						
					</div>
				</div>
				</form>
				<!--// Board Search -->
				
				<!-- Board List -->
				<div class="section">
					<div class="table_wrap">
						<div class="board_info">
							<div class="board_left">
								<p class="board_count">게시물 <em>0</em>건</p>
							</div>
							<div class="board_right">
								
							</div>
						</div>
						<div class="table_wrap">
						<table brder="1" cellspacing="0" class="board_list_type1">
							<caption>게시물 리스트</caption>
							<colgroup>
								<col width="70">
								<col width="*">
								<col width="100">
								<col width="100">
								<col width="70">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">등록일</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="7" class="noData">검색된 게시물이 없습니다.</td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td>1</td> -->
<!-- 									<td class="l15">[사용자 설명서] 시스템 사용자 매뉴얼</td> -->
<!-- 									<td>관리자</td> -->
<!-- 									<td>2017-02-28</td> -->
<!-- 									<td>111</td> -->
<!-- 								</tr> -->

							</tbody>
						</table>
					</div>
</div>
					<!-- Board Pager -->
					<div class="boardPage_wrap">
						<div class="boardPage">
							<strong>1</strong>

						</div>
					</div>
					<!--// Board Pager -->
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
</body>
</html>