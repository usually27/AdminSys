<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">


<title>공간정보통합관리시스템</title>
<link rel="stylesheet" href="<c:url value='/css/plugins/jqueryui/jquery-ui.css'/>" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/plugins/jqgrid/ui.jqgrid.css'/>" type="text/css" />


<link rel="stylesheet" href="<c:url value='/css/com/base.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui_style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/ui.jqgrid.css'/>" type="text/css"><!-- Plug-in -->
<link rel="stylesheet" href="<c:url value='/css/com/common.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/layout.css'/>"  type="text/css">
<link rel="stylesheet" href="<c:url value='/css/com/content.css'/>" type="text/css">

<script type="text/javascript" src="<c:url value='/js/publish/jquery-1.12.4.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/publish/jquery-ui-1.12.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/publish/jquery.jqGrid.min.js'/>"></script><!-- Plug-in -->
<script type="text/javascript" src="<c:url value='/js/publish/common-ui.js'/>"></script>

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
					<li class="active">자료실 관리</li>
				</ul>
				<!--// Breadcrumb -->
				
				<h1 class="currentPage">자료실 관리</h1>
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
							<button type="button" onclick="javascript:lp_open('.lp_download');" class="btn mid black"><span>자료실 작성</span></button>
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

	<!-- Common Layer Pop -->
	
	<!-- (팝업) 자료실 작성 -->
	<div class="lp_wrap lp_download lp_w600">
		<!-- lp_inner -->
		<div class="lp_inner">
			<div class="lp_header">
				<h1 class="ico ico_star">자료실 작성</h1>
			</div>
			<!-- lp_body -->
			<div class="lp_body">
				<div class="lp_box">
					<div class="btn_wrap r">
						<button type="button" class="btn mid black">저장</buttion>
						<button type="button"  onclick="javascript:lp_close('.lp_download'); return;" class="btn mid gray">창닫기</buttion>
					</div>
					<!-- section -->
					<div class="section">
						<div class="hgroup_wrap">
							<h2>자료실 작성</h2>
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
											<select name="" id="" title="" class="size115">
												<option>선택</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><label>작성자</label></th>
										<td>
											도로 및 상하수도 관리시스템 관리자
										</td>
									</tr>
									<tr>
										<th><label>이메일</label></th>
										<td>
											<input type="text" name="" id="" maxlength="" title="" class="size160" value="">
										</td>
									</tr>
									<tr>
										<th><label>비밀번호</label></th>
										<td>
											<input type="text" name="sTitle" id="sTitle" maxlength="100" title="" class="size115">
											<p class="txt_guide">비밀번호는 4자리 이상 입력하여 하며,<br>
											향후 수정 또는 삭제시 반드시 숙지하셔야 처리 가능합니다.</p>
										</td>
									</tr>
									<tr>
										<th><label>제목</label></th>
										<td>
											<input type="text" name="sTitle" id="sTitle" maxlength="100" title="" class="size100p">
										</td>
									</tr>
									<tr>	
										<th><label for="sUpFilePath">첨부파일</label></th>
										<td colspan="3">
											<span class="input_file">
												<input type="text" name="sUpFilePath" id="sUpFilePath" size="100" value="" title="첨부파일경로" class="size320" readonly="">
												<input type="file" name="sUpFile" id="sUpFile" title="첨부파일선택" onchange="javascript:setFilePath('sUpFile','sUpFilePath');">
											</span>
											<label for="sUpFile" title="첨부파일선택" tabindex="0" class="btn sml gray"><span>파일선택</span></label>	
										</td>
									</tr>
									<tr>
										<th><label>내용</label></th>
										<td>
											<textarea name="sContent" id="sContent" rows="15" cols="130" class="size100p"></textarea>
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
			<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_download'); return;"></a>
		</div>
		<!-- //lp_inner -->
	</div>
	<!--//(팝업) 자료실 작성 -->
	
	<!--//Common Layer Pop -->

</div>
</body>
</html>