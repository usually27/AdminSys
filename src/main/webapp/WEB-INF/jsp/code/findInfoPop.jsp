<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp" %>

<form id="findFrm" name="findFrm">

				<!-- search_wrap -->
				<div class="search_wrap">
					<div class="secrchBox tp1">
						<!-- searchSec_wrap -->
						<div class="searchSec_wrap sec_3">
							<!-- search_sec -->
							<div class="search_sec">
								<div class="tit">코드한글명</div>
								<div class="cont_wrap">
									<div class="inp_wrap">
										<div class="inp">
											<p class="inp"><input type="text" id="hanNam" name="hanNam" /></p>
									</div>
									</div>
								</div>
							</div>
							<!-- //search_sec -->
							<!-- search_sec -->
							<div class="search_sec">
								<div class="tit">코드명</div>
								<div class="cont_wrap">
									<div class="inp_wrap">
										<p class="inp"><input type="text" id="cdNam" name="cdNam" /></p>
									</div>
								</div>
							</div>
							<!-- //search_sec -->
							<!-- search_sec -->
							<div class="search_sec">
								<div class="tit">코드</div>
								<div class="cont_wrap">
									<div class="inp_wrap">
										<p class="inp"><input type="text" id="cdVal" name="cdVal" /></p>
									</div>
								</div>
							</div>
							<!-- //search_sec -->
						</div>
						<div class="btn_wrap tp1">
							<a href="#this" id="search2" class="btn mid blue">검색</a>
						</div>
					</div>
				</div>
				<!-- /search_wrap -->

				<div class="searchResult_wrap contBox_tp1">
					<div class="codeResult">

						<!-- board -->
						<div class="board_tp1">
						</div>
						<!-- //board -->

						<!-- board_pager_wrap -->
						<div class="board_pager_wrap">
						</div>
						<!-- //board_pager_wrap -->
					</div>
				</div>
				<!-- //searchResult_wrap -->


</form>
<script>

//# sourceURL= /code/findInfoPop.jsp

var searchResultList;

$(function() {
	searchResultList = new SearchResultList("div.codeResult", {
		url					: "${context}/code/selectInfoList.json",
		reqData			: {},
		colNames		: [
			{name : "번호", width : "10%"},
			{name : "코드한글명", width : "20%"},
			{name : "코드", width : "10%"},
			{name : "코드명", width : "20%"},
			{name : "관련테이블", width : "10%"},
			{name : "관련코드", width : "*%"}
		],
		colModel		: [
			{name : "num"},
			{name : "hanNam"},
			{name : "cdVal"},
			{name : "cdNam"},
			{name : "tbNam"},
			{name : "refCd"}
		],onCellClick		: function(rowIdx, colIdx, cellContent, evt) {
			$("#insert_Frm").find("#engNam").val(searchResultList.getData(rowIdx, "engNam"));
			$("#insert_Frm").find("#hanNam").val(searchResultList.getData(rowIdx, "hanNam"));
			$("#insert_Frm").find("#cdVal").val(searchResultList.getData(rowIdx, "cdVal"));
			$("#insert_Frm").find("#cdNam").val(searchResultList.getData(rowIdx, "cdNam"));
			$("#insert_Frm").find("#tbNam").val(searchResultList.getData(rowIdx, "tbNam"));
			$("#insert_Frm").find("#refCd").val(searchResultList.getData(rowIdx, "refCd"));
			$.lp_close($("#findFrm"));

		}
	});

	$("#search2").click(function(){
		searchResultList.reloadList({
			hanNam : $("#findFrm").find("#hanNam").val(),
			cdNam : $("#findFrm").find("#cdNam").val(),
			cdVal : $("#findFrm").find("#cdVal").val()
		});
	});

});

</script>