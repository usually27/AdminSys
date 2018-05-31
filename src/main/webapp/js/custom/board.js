(function(window, $) {
	"use strict";

	var SearchResultList = function(elem, options) {
		this.$elem = $(elem);
		this.options = options;
		this._init();
	};

	SearchResultList.prototype = {
		config : null,

		_defaults : {
			url					: "",
			type				: "post",
			reqData			: {},
			cache			: false,
			dataType		: "json",
			async			: true,
			colModel		: [],
			colNames		: [],
			pagingYn		: true,
			daumFlag		: false,
			tpVer			: "1",
			onCellClick		: function(rowIdx, colIdx, cellContent, evt) {
			},
			onRowClick	: function(rowIdx, evt) {
			},
		},

		_pageConfig : {
			rows : "10",
			page : "1",
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this.config.reqData = $.extend({}, this._pageConfig, this.config.reqData);
			this._setTableStrucObj();
			this._setHeader();
			this.loadList();
		},

		_setTableStrucObj : function () {
			this.$elem.children("div.board_tp" + this.config.tpVer).append(
				"<table class='tbl_col_tp" + this.config.tpVer + "'>" +
					"<colgroup>" +
					"</colgroup>" +
					"<thead>" +
						"<tr>" +
						"</tr>" +
					"</thead>" +
					"<tbody>" +
					"</tbody>" +
				"</table>"
			);
		},

		_setHeader : function () {
			var colGroupHtml = "";
			var theadHtml = "";

			$.each(this.config.colNames, function(idx, col){
				theadHtml += "<th>" + col.name + "</th>";
				colGroupHtml += "<col width='" + col.width + "' />";
			});

			this.$elem.find("table").children("colgroup").append(colGroupHtml);
			this.$elem.find("table").children("thead").children("tr").append(theadHtml);
		},

		_jsonData : null,

		loadList : function () {
			var _self = this;

			if (_self.config.daumFlag) {
				var ps = new daum.maps.services.Places();

				var keyword = _self.config.reqData.keyword;

				if (keyword == "") return;

				if (keyword.indexOf("대전") < 0) keyword = "대전 " + keyword;

				$.showBlock();

				ps.keywordSearch( keyword, function(resultList, status, pagination) {
					if (status === daum.maps.services.Status.OK) {
						_self._jsonData = _self.daumDataProcessing(resultList, pagination);
						_self._setList();
					} else if (status === daum.maps.services.Status.ZERO_RESULT) {
						alert("검색 결과가 존재하지 않습니다.");
						return;
					} else if (status === daum.maps.services.Status.ERROR) {
						alert("검색 결과 중 오류가 발생했습니다.");
						return;
					}

					$.hideBlock();

				}, {
					size : _self.config.reqData.rows,
					page : _self.config.reqData.page,
				});
			} else {
				$.ajax({
					type			: _self.config.type,
					url				: _self.config.url,
					dataType	: _self.config.dataType,
					data			: _self.config.reqData,
					cache		: _self.config.cache,
					async		: _self.config.async,
					beforeSend	: function(){
						$.showBlock();
					},
					success		: function(jsonView){
						_self._jsonData = jsonView;
						_self._setList();
					},
					complete	: function(){
						$.hideBlock();
					},
				});
			}
		},

		daumDataProcessing : function (resultList, pagination) {
			var arrJson = new Array();

			$.each(resultList, function(idx){
//				var resultListJson = {
//					name : this.address_name + " " + this.place_name,
//					x : this.x,
//					y : this.y,
//				};

				var resultListJson = $.extend({}, {
					num : (idx+1)  + ((pagination.current - 1) * 10)
				}, this);

				arrJson.push(resultListJson)
			});

			var resultJson = {
				total : pagination.last,
				records : pagination.totalCount,
				root : arrJson,
				page : pagination.current
			};

			return resultJson;
		},

		reloadList : function (params) {
			if (!params) params = {};
			this.config.reqData = $.extend({}, this._pageConfig, params);
			this.loadList();
		},

		_setList : function () {
			var _self = this;

			var $tbody = _self.$elem.find("table>tbody");
			$tbody.empty();

			if(_self._jsonData.root.length != 0) {
				$.each(_self._jsonData.root, function(rowIdx, rowData){
					var $row = $("<tr>");

					$.each(_self.config.colModel, function(colIdx, colData){
						var $cell;
						if (colData.formatter) {
							var formtterHtml ="";

							if ("integer"==colData.formatter) {
								formtterHtml = rowData[colData.name];
								$cell = $("<td>").append(formtterHtml.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원");
							} else {
								formtterHtml = colData.formatter(rowData[colData.name], rowData);
								$cell = $("<td>").append(formtterHtml);
							}
						} else {
							$cell = $("<td>" + rowData[colData.name] + "</td>");
						}

						$cell.off("click");
						$cell.on("click", function(evt){
							_self.config.onCellClick(rowIdx, colIdx, rowData[colData.name], evt);
						});

						$row.append($cell);
					});

					//$row.css("cursor", "pointer");

					$row.off("click");
					$row.on({
						"click" : function(evt) {
							_self.config.onRowClick(rowIdx, evt);
						},
						"mouseenter" : function() {
							$(this).css("background", "#F6F6F6");
						},
						"mouseleave" : function() {
							$(this).css("background", "");
						},
					});

					$tbody.append($row);
				});

			} else {
				var $row = $("<tr>");
				var $cell = $("<td colspan='"+ _self.config.colModel.length +"'>")
				$cell.html("데이터가 존재하지 않습니다.")
				$row.append($cell);
				$tbody.append($row);
			}

			this._setPaging();
		},

		_pageCnt : 10,		//한 화면에 보여줄 페이지 갯수(1 2 3 4 5 6 7 8 9 10)

		_setPaging : function(){
			var $page = this.$elem.find("div.board_pager_wrap");

			var $p = this.$elem.find("p.tit");
			$p.empty();

			// 전체 리스트 수
			var totalSize = this._jsonData.records;

			if(!this.config.pagingYn) {
				if ($page.length > 0) $page.remove();
				$p.append(
					"총 " +
					"<span class='txt_blue fm'>" + totalSize + "</span>" +
					"개의 정보가 검색되었습니다."
				);
				return;
			}

			if (totalSize == 0) {
				$p.append("데이터가 존재하지 않습니다.");
			} else {
				$p.append(
					"총 " +
					"<span class='txt_blue fm'>" + this._jsonData.total + "</span>" +
					"페이지 /  " +
					"<span class='txt_blue fm'>" + this._jsonData.records + "</span>" +
					"개중(" + this._jsonData.root[0].num + "~" + this._jsonData.root[this._jsonData.root.length - 1].num + ")"
				);
			}

			// 현재 페이지
			var currentPage = this._jsonData.page;

			// 데이터 전체의 페이지 수
			var totalPage = this._jsonData.total;

			if(totalSize % this.config.reqData.rows == 0) totalPage -= 1;

			// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
			var totalPageList = Math.ceil(totalPage / this._pageCnt);

			// 페이지 리스트가 몇번째 리스트인지
			var pageList = Math.ceil(currentPage / this._pageCnt);

			// 페이지 정보 셋팅
			var pageInfoText = ""; // 페이지 정보를 담을 변수

			//////////////////////////////////////////////////////////////////////////////////////////
			var base = parseInt(this._jsonData.page, 10) - 1;

			if(base < 0) base = 0;

			base = base * parseInt(this.config.rows, 10);

			var from = base + 1;
			var to = base + this.config.rows;
			//////////////////////////////////////////////////////////////////////////////////////////

			// 페이지 리스트가 1보다 작으면 1로 초기화
			if(pageList < 1) pageList = 1;

			// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
			if(pageList > totalPageList) pageList = totalPageList;

			// 시작 페이지
			var startPageList = ((pageList - 1) * this._pageCnt) + 1;

			// 끝 페이지
			var endPageList = startPageList + this._pageCnt - 1;

			// 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
			// 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
			if(startPageList < 1) startPageList = 1;
			if(endPageList > totalPage) endPageList = totalPage;
			if(endPageList < 1) endPageList = 1;

			// 페이징 DIV에 넣어줄 태그 생성변수
			var pageInner = "";

			pageInner += "<ul class='boardNav'>";
			// 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
			if(pageList < 2){
				pageInner += "<li><a href='#' class='btn_first disabled'></a></li>"; //<<
				pageInner += "<li><a href='#' class='btn_prev disabled'></a></li>"; //<
			} else { // 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
				var titleFirstPage = "첫 페이지로 이동";
				var titlePrePage = (startPageList - 10) + "페이지에서 " + (endPageList - 10) + "페이지까지 이동";

				pageInner += "<li><a class='btn_first' href='#' title='" + titleFirstPage + "'></a></li>";
				pageInner += "<li><a class='btn_prev' href='#' title='" + titlePrePage + "'></a></li>";
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardPage'>";
			// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
			for(var i = startPageList; i <= endPageList; i++){
				var titleGoPage = i + "페이지로 이동";

				if(i == currentPage){
					pageInner += "<li class='on'><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}else{
					pageInner += "<li><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardNav'>";
			// 다음 페이지 리스트가 있을 경우
			if(totalPageList > pageList){
				var titleNextPage = (startPageList + 10) + "페이지에서 " + (endPageList + 10) + "페이지까지 이동";
				var titleLastPage = "마지막 페이지로 이동";

				pageInner += "<li><a class='btn_next' href='#' title='" + titleNextPage + "'></a></li>"; //>
				pageInner += "<li><a class='btn_last' href='#' title='" + titleLastPage + "'></a></li>"; //>>
			}

			// 현재 페이지리스트가 마지막 페이지 리스트일 경우
			if(totalPageList == pageList){
				pageInner += "<li><a href='#' class='btn_next disabled'></a></li>"; //>
				pageInner += "<li><a href='#' class='btn_last disabled'></a></li>"; //>>
			}
			pageInner += "</ul>";

			var html = "";
			html += "<div class='board_pager'>";
			html += pageInner;
			html += "</div>"

			$page.empty();
			$page.append(html);

			this._setPagingEvt($page);
		},

		_setPagingEvt : function($page) {
			var self = this;

			$page.find("ul>li>a").on("click", function(evt){
				evt.preventDefault();

				var className = $(this).attr("class");

				if(className != "" && className != null) {
					if(className.indexOf("disabled") != -1){
						return true;
					}
				}

				switch (className) {
					case "btn_first" :
						self._firstPage();
						break;
					case "btn_prev" :
						self._prePage();
						break;
					case "btn_next" :
						self._nextPage();
						break;
					case "btn_last" :
						self._lastPage();
						break;
					default :
						self._goPage($(this).attr("id"));
						break;
				}
			});
		},

		// 첫페이지로 이동
		_firstPage : function(){
			this.config.reqData.page = "1";
			this.loadList();
		},

		// 이전페이지 이동
		_prePage : function(){
			var currentPage = this._jsonData.page;

			currentPage -= this._pageCnt;
			var pageList = Math.ceil(currentPage / this._pageCnt);
			currentPage = (pageList - 1) * this._pageCnt + this._pageCnt;

			this.config.reqData.page = currentPage;
			this.loadList();
		},

		// 다음페이지 이동
		_nextPage : function(){
			var currentPage = this._jsonData.page;

			currentPage += this._pageCnt;
			var pageList = Math.ceil(currentPage / this._pageCnt);
			currentPage = (pageList - 1) * this._pageCnt + 1;

			this.config.reqData.page = currentPage;
			this.loadList();
		},

		// 마지막페이지 이동
		_lastPage : function(){
			var totalPage = this._jsonData.total;
			if(this._jsonData.records % this.config.reqData.rows == 0) totalPage -= 1;
			this.config.reqData.page = totalPage;
			this.loadList();
		},

		// 페이지 번호로 이동
		_goPage : function(num){
			this.config.reqData.page = num;
			this.loadList();
		},

		getData : function(rowIdx, key) {
			return this._jsonData.root[rowIdx][key];
		},

		pageMove : function(url, data) {
			var $form = $("<form>");

			$.each(data, function(key, val){
				var inputHtml = "<input type='hidden' id='" + key + "' name='" + key + "' value='" + val + "'/>";
				$form.append(inputHtml);
			});

			this.$elem.append($form);
			$form.attr({action : url, method : "post"}).submit();
			$form.remove();
		},
	}

	window.SearchResultList = SearchResultList;

	var MapSearchResultList = function($elem, options) {
		this.$elem = $elem;
		this.options = options;
		this._init();
	};

	MapSearchResultList.prototype = {
		config : null,

		_defaults : {
			url					: "",
			type				: "post",
			reqData			: {},
			cache			: false,
			dataType		: "json",
			async			: true,
			daumFlag		: false,
			onRowClick	: function(rowIdx, evt) {
			},
		},

		_pageConfig : {
			pageCnt : 5,			//한 화면에 보여줄 페이지 갯수(1 2 3 4 5)
			rows : "10",
			page : "1",
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this.config.reqData = $.extend({}, this._pageConfig, this.config.reqData);
			if(!this.$elem.hasClass("search_result")) this.$elem = this.$elem.find("div.search_result");

//			this.$elem.append(
//				"<h4>검색결과(0)</h4>" +
//				"<ul class='result_list'>" +
//				"</ul>" +
//				"<div class='board_pager_wrap'>" +
//					"<div class='board_pager'>" +
//						"<ul class='boardNav'>" +
////							"<li><a href='1' class='btn_first'></a></li>" +
//							"<li><a href='1' class='btn_prev disabled'></a></li>" +
//						"</ul>" +
//						"<ul class='boardPage'>" +
//							"<li class='on'><a href='1'>1</a></li>" +
//						"</ul>" +
//						"<ul class='boardNav'>" +
//							"<li><a href='1' class='btn_next disabled'>last</a></li>" +
////							"<li><a href='1' class='btn_last'>last</a></li>" +
//						"</ul>" +
//					"</div>" +
//				"</div>"
//			);

			this._loadList();
		},

		_jsonData : null,

		_loadList : function () {
			var _self = this;

			if (_self.config.daumFlag) {
				var ps = new daum.maps.services.Places();

				var keyword = _self.config.reqData.keyword;

				if (keyword.indexOf("대전") < 0) keyword = "대전 " + keyword;

				ps.keywordSearch( keyword, function(resultList, status, pagination) {
					if (status === daum.maps.services.Status.OK) {
//						_self._jsonData = _self.daumDataProcessing(resultList, pagination);
//						_self._setList();
					} else if (status === daum.maps.services.Status.ZERO_RESULT) {
//						alert("검색 결과가 존재하지 않습니다.");
//						return;
					} else if (status === daum.maps.services.Status.ERROR) {
//						alert("검색 결과 중 오류가 발생했습니다.");
//						return;
					}

					_self._jsonData = _self.daumDataProcessing(resultList, pagination);
					_self._setList();

				}, {
					size : _self.config.reqData.rows,
					page : _self.config.reqData.page,
				});
			} else {
				$.ajax({
					type			: _self.config.type,
					url				: G.baseUrl + _self.config.url,
					dataType	: _self.config.dataType,
					data			: _self.config.reqData,
					cache		: _self.config.cache,
					async		: _self.config.async,
					success		: function(jsonView){
						_self._jsonData = jsonView;
						_self._setList();
					}
				});
			}
		},

		daumDataProcessing : function (resultList, pagination) {
			var arrJson = new Array();

			$.each(resultList, function(idx){
				var resultListJson = {
					name : this.address_name + " " + this.place_name,
					x : this.x,
					y : this.y,
				};

				arrJson.push(resultListJson)
			});

			var total = pagination.last ? pagination.last : 0;
			var records = pagination.totalCount ? pagination.totalCount : 0;
			var page = pagination.current ? pagination.current : 1;

			var resultJson = {
				total : total,
				records : records,
				root : arrJson,
				page : page
			};

			return resultJson;
		},

		_setList : function () {
			var _self = this;

			_self.$elem.empty();

			_self.$elem.append("<h4>검색결과(" + _self._jsonData.records + ")</h4>");

			if(_self._jsonData.root.length != 0) {

				var $ul = $("<ul class='result_list'>");

				$.each(_self._jsonData.root, function(rowIdx, rowData){

					var $li = $("<li><a href='#this'>" + rowData.name + "</a></li>");
					$li.css("overflow", "hidden");
					$li.css("white-space", "nowrap");
					$li.css("text-overflow", "ellipsis");

					$li.on("click", function(evt){
						_self.config.onRowClick(rowIdx, evt);
					});

					$ul.append($li);

				});

				_self.$elem.append($ul);
			}

			this._setPaging();
		},

		_setPaging : function() {
			var $page = $("<div class='board_pager_wrap'>");

			// 전체 리스트 수
			var totalSize = this._jsonData.records;

			if(totalSize == 0) return;

			// 현재 페이지
			var currentPage = this._jsonData.page;

			// 데이터 전체의 페이지 수
			var totalPage = this._jsonData.total;

			if(totalSize % this.config.reqData.rows == 0) totalPage -= 1;

			// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
			var totalPageList = Math.ceil(totalPage / this.config.reqData.pageCnt);

			// 페이지 리스트가 몇번째 리스트인지
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);

			// 페이지 정보 셋팅
			var pageInfoText = ""; // 페이지 정보를 담을 변수

			//////////////////////////////////////////////////////////////////////////////////////////
			var base = parseInt(this._jsonData.page, 10) - 1;

			if(base < 0) base = 0;

			base = base * parseInt(this.config.rows, 10);

			var from = base + 1;
			var to = base + this.config.rows;
			//////////////////////////////////////////////////////////////////////////////////////////

			// 페이지 리스트가 1보다 작으면 1로 초기화
			if(pageList < 1) pageList = 1;

			// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
			if(pageList > totalPageList) pageList = totalPageList;

			// 시작 페이지
			var startPageList = ((pageList - 1) * this.config.reqData.pageCnt) + 1;

			// 끝 페이지
			var endPageList = startPageList + this.config.reqData.pageCnt - 1;

			// 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
			// 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
			if(startPageList < 1) startPageList = 1;
			if(endPageList > totalPage) endPageList = totalPage;
			if(endPageList < 1) endPageList = 1;

			// 페이징 DIV에 넣어줄 태그 생성변수
			var pageInner = "";

			pageInner += "<ul class='boardNav'>";
			// 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
			if(pageList < 2){
//				pageInner += "<li><a href='#' class='btn_first disabled'></a></li>"; //<<
				pageInner += "<li><a href='#' class='btn_prev disabled'></a></li>"; //<
			} else { // 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
//				var titleFirstPage = "첫 페이지로 이동";
				var titlePrePage = (startPageList - 10) + "페이지에서 " + (endPageList - 10) + "페이지까지 이동";

//				pageInner += "<li><a class='btn_first' href='#' title='" + titleFirstPage + "'></a></li>";
				pageInner += "<li><a class='btn_prev' href='#' title='" + titlePrePage + "'></a></li>";
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardPage'>";
			// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
			for(var i = startPageList; i <= endPageList; i++){
				var titleGoPage = i + "페이지로 이동";

				if(i == currentPage){
					pageInner += "<li class='on'><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}else{
					pageInner += "<li><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardNav'>";
			// 다음 페이지 리스트가 있을 경우
			if(totalPageList > pageList){
				var titleNextPage = (startPageList + 10) + "페이지에서 " + (endPageList + 10) + "페이지까지 이동";
//				var titleLastPage = "마지막 페이지로 이동";

				pageInner += "<li><a class='btn_next' href='#' title='" + titleNextPage + "'></a></li>"; //>
//				pageInner += "<li><a class='btn_last' href='#' title='" + titleLastPage + "'></a></li>"; //>>
			}

			// 현재 페이지리스트가 마지막 페이지 리스트일 경우
			if(totalPageList == pageList){
				pageInner += "<li><a href='#' class='btn_next disabled'></a></li>"; //>
//				pageInner += "<li><a href='#' class='btn_last disabled'></a></li>"; //>>
			}
			pageInner += "</ul>";

			var html = "";
			html += "<div class='board_pager'>";
			html += pageInner;
			html += "</div>"

			$page.empty();
			$page.append(html);

			this._setPagingEvt($page);
			this.$elem.append($page);
		},

		_setPagingEvt : function($page) {
			var self = this;

			$page.find("ul>li>a").on("click", function(evt){
				evt.preventDefault();

				var className = $(this).attr("class");

				if(className != "" && className != null) {
					if(className.indexOf("disabled") != -1){
						return true;
					}
				}

				switch (className) {
					case "btn_first" :
						self._firstPage();
						break;
					case "btn_prev" :
						self._prePage();
						break;
					case "btn_next" :
						self._nextPage();
						break;
					case "btn_last" :
						self._lastPage();
						break;
					default :
						self._goPage($(this).attr("id"));
						break;
				}
			});
		},

		// 첫페이지로 이동
		_firstPage : function(){
			this.config.reqData.page = "1";
			this._loadList();
		},

		// 이전페이지 이동
		_prePage : function(){
			var currentPage = this._jsonData.page;

			currentPage -= this.config.reqData.pageCnt;
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);
			currentPage = (pageList - 1) * this.config.reqData.pageCnt + this.config.reqData.pageCnt;

			this.config.reqData.page = currentPage;
			this._loadList();
		},

		// 다음페이지 이동
		_nextPage : function(){
			var currentPage = this._jsonData.page;

			currentPage += this.config.reqData.pageCnt;
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);
			currentPage = (pageList - 1) * this.config.reqData.pageCnt + 1;

			this.config.reqData.page = currentPage;
			this._loadList();
		},

		// 마지막페이지 이동
		_lastPage : function(){
			var totalPage = this._jsonData.total;
			if(totalSize % this.config.reqData.rows == 0) totalPage -= 1;
			this.config.reqData.page = totalPage;
			this._loadList();
		},

		// 페이지 번호로 이동
		_goPage : function(num){
			this.config.reqData.page = num;
			this._loadList();
		},

		getData : function(rowIdx, key) {
			if(key == null || key == "" || key == "undefined") key = "key";
			return this._jsonData.root[rowIdx][key];
		},

		reset : function () {
			this.$elem.empty();
		},
	}

	window.MapSearchResultList = MapSearchResultList;


	var StatisticsResultList = function(elem, options) {
		this.$elem = $(elem);
		this.options = options;
		this._init();
	};

	StatisticsResultList.prototype = {
		config : null,

		_defaults : {
			url					: "",
			type				: "post",
			reqData			: {},
			cache			: false,
			dataType		: "json",
			async			: true,
			colModel		: [],
			colNames		: [],
			ctkFlag			: false,
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this._setTableStrucObj();
			this._setHeader();
			this.loadList();
		},

		_setTableStrucObj : function () {
			this.$elem.append(
				"<table class='tbl_col_tp2 bor_tp1'>" +
					"<colgroup>" +
					"</colgroup>" +
					"<thead>" +
						"<tr>" +
						"</tr>" +
					"</thead>" +
					"<tbody>" +
					"</tbody>" +
				"</table>"
			);
		},

		_setHeader : function () {
			var colGroupHtml = "";
			var theadHtml = "";

			var width = 100 / this.config.colNames.length;

			$.each(this.config.colNames, function(idx, col){
				theadHtml += "<th>" + col.name + "</th>";
				colGroupHtml += "<col width='" + width + "%' />";
			});

			this.$elem.find("table").children("colgroup").append(colGroupHtml);
			this.$elem.find("table").children("thead").children("tr").append(theadHtml);
		},

		_jsonData : null,

		loadList : function () {
			var _self = this;

			$.ajax({
				type			: _self.config.type,
				url				: _self.config.url,
				dataType	: _self.config.dataType,
				data			: _self.config.reqData,
				cache		: _self.config.cache,
				async		: _self.config.async,
				beforeSend	: function(){
					$.showBlock();
				},
				success		: function(jsonView){
					_self._jsonData = jsonView;
					_self._setList();
				},
				complete	: function(){
					$.hideBlock();
				},
			});
		},

		reloadList : function (params) {
			if (!params) params = {};
			this.config.reqData = params;
			this.loadList();
		},

		_setList : function () {
			var _self = this;

			var $tbody = _self.$elem.find("table>tbody");
			$tbody.empty();

			if(_self._jsonData.root.length != 0) {
				$.each(_self._jsonData.root, function(rowIdx, rowData){
					var $row = $("<tr>");

					$.each(_self.config.colModel, function(colIdx, colData){
						var $cell = $("<td>" + rowData[colData.name] + "</td>");
						$row.append($cell);
					});

					$tbody.append($row);
				});

			} else {
				var $row = $("<tr>");
				var $cell = $("<td colspan='"+ _self.config.colModel.length +"'>")
				$cell.html("데이터가 존재하지 않습니다.")
				$row.append($cell);
				$tbody.append($row);
			}

			_self._setMergeCell();
		},

		_setMergeCell : function () {
			var arrColsIdx = [];

			for (var i = 0 ; i < this.config.colNames.length ; i++) {
				if (i % 2 == 0) arrColsIdx.push(i);
			}

			if(!this.config.ctkFlag) arrColsIdx.pop();

			var $tr = this.$elem.find("table>tbody>tr");

			$.each(arrColsIdx, function(){
				var colsIdx = this;

				var that;

				$tr.each(function(row){
					$(this).find("td:eq(" + colsIdx + ")").each(function(){
						if ($(this).html() == $(that).html()) {
							var rowspan = $(that).attr("rowSpan");

							if (rowspan == undefined) {
								$(that).attr("rowSpan",1);
								rowspan = $(that).attr("rowSpan");
							}

							rowspan = Number(rowspan) + 1;

							$(that).attr("rowSpan",rowspan);
							$(that).next().attr("rowSpan",rowspan);
							$(this).hide();
							$(this).next().hide();
						} else {
							that = this;
						}

						that = (that == null) ? this : that;
					});
				});
			});
		},
	}

	window.StatisticsResultList = StatisticsResultList;

	var MapSearchDrawingList = function(elem, options) {
		this.$elem = $(elem);
		this.options = options;
		this._init();
	};

	MapSearchDrawingList.prototype = {
		config : null,

		_defaults : {
			url					: "",
			type				: "post",
			reqData			: {},
			cache			: false,
			dataType		: "json",
			async			: true,
			onRowClick	: function(rowIdx, evt) {
			},
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this.loadList();
		},

		_jsonData : null,

		loadList : function () {
			var _self = this;

			$.ajax({
				type			: _self.config.type,
				url				: G.baseUrl + _self.config.url,
				dataType	: _self.config.dataType,
				data			: _self.config.reqData,
				cache		: _self.config.cache,
				async		: _self.config.async,
				success		: function(jsonView){
					_self._jsonData = jsonView;
					_self._setList();
				}
			});
		},

		_setList : function () {
			var _self = this;

			_self.$elem.empty();

			if(_self._jsonData.root.length != 0) {
				$.each(_self._jsonData.root, function(rowIdx, rowData){
					var $div = $("<div class='imgCheckBox'>");

					var $label = $("<label for='facilities_list_" + rowIdx + "' class='tit'>" + rowData.name + "</label>");

					$label.on("click", function(evt) {
						_self.config.onRowClick(rowIdx, evt);
					});

					$label.css("background", "none");

					$div.append($label);
					if (_self.config.reqData.cstStatCd == "03" && rowData.cstStatCd != "04") {
//						var $input = $("<input type='checkbox' name='facilities_list' id='facilities_list_" + rowIdx + "'>");
						var $a = $("<a href='#this' class='btn sml blue ab_r'>검수</a>");
						$a.on("click", function(){
							_self.updateStats({
								facilityId : rowData.facKnd,
								facNo : rowData.facNo,
								cstStatCd : "04",
							});
						});

						$div.append($a);
					}

					_self.$elem.append($div);
				});
			}
		},

		getData : function(rowIdx, key) {
			return this._jsonData.root[rowIdx][key];
		},

		updateStats : function (params) {
			var _self = this;

			if (confirm("검수완료 하시겠습니까?")) {
				$.ajax({
					type			: _self.config.type,
					url				: G.baseUrl + "fclts/updateStats.json",
					dataType	: _self.config.dataType,
					data			: params,
					cache		: _self.config.cache,
					async		: _self.config.async,
					success		: function(jsonView){
						if (jsonView.respFlag == "Y") {
							if (jsonView.cnt != 0) {
								_self.loadList();
							} else {	// update 0개
								alert("검수 중 문제가 발생하였습니다. 다시 시도하여 주십시오.");
							}
						} else {
							alert("검수 중 문제가 발생하였습니다. 다시 시도하여 주십시오.");
						}
					}
				});
			}
		},
	}

	window.MapSearchDrawingList = MapSearchDrawingList;


























	var SafetySingList = function($elem, options) {
		this.$elem = $elem;
		this.options = options;
		this._init();
	};

	SafetySingList.prototype = {
		config : null,

		_defaults : {
			url					: "",
			type				: "post",
			reqData			: {},
			cache			: false,
			dataType		: "json",
			async			: true,
			onRowClick	: function(rowIdx,$elem, evt) {
			},
		},

		_pageConfig : {
			pageCnt : 5,			//한 화면에 보여줄 페이지 갯수(1 2 3 4 5)
			rows : "10",
			page : "1",
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this.config.reqData = $.extend({}, this._pageConfig, this.config.reqData);
			if(!this.$elem.hasClass("sign_body")) this.$elem = this.$elem.find("div.sign_body");
			this._loadList();
		},

		_jsonData : null,

		_loadList : function () {
			var _self = this;
			$.ajax({
				type			: _self.config.type,
				url				: G.baseUrl + _self.config.url,
				dataType	: _self.config.dataType,
				data			: _self.config.reqData,
				cache		: _self.config.cache,
				async		: _self.config.async,
				success		: function(jsonView){
					_self._jsonData = jsonView;
					_self._setList();
				}
			});
		},

		_setList : function () {
			var _self = this;

			_self.$elem.empty();

//			_self.$elem.append("<h4>검색결과(" + _self._jsonData.records + ")</h4>");

			if(_self._jsonData.root.length != 0) {

				var $ul = $("<ul class='signList'>");

				$.each(_self._jsonData.root, function(rowIdx, rowData){

//					var str = "<il id='sign" + rowData.signNo + "'><a href='#this'>" +
// 					"<img src='"+G.baseUrl+"fclts/getFeatureImage.do?fileNm=" + rowData.signNo +"'>"+
// 					"<div>" + rowData.signNam + "</div>" +
// 					"</a></li>"
					var $li = $("<li data-knd='"+rowData.signKnd+"' data-url='"+G.baseUrl+"fclts/getFeatureImage.do?fileNm=" + rowData.signNo+"' data-value='"+rowData.signNo+"'></li>");

					var $a = $("<a href='#this'>"+rowData.signNam+"</a>");

					$a.css("background", "url('"+G.baseUrl+"fclts/getFeatureImage.do?fileNm=" + rowData.signNo+"') center top no-repeat");

					$a.css("background-size", "65px 65px");


					$li.append($a);

					$li.on("click", function(evt){
						_self.config.onRowClick(rowIdx,$li, evt);
					});

					$ul.append($li);

				});

				_self.$elem.append($ul);
			}

			this._setPaging();
		},

		_setPaging : function() {
			var $page = $("<div class='board_pager_wrap'>");

			// 전체 리스트 수
			var totalSize = this._jsonData.records;

			if(totalSize == 0) return;

			// 현재 페이지
			var currentPage = this._jsonData.page;

			// 데이터 전체의 페이지 수
			var totalPage = this._jsonData.total;

			if(totalSize % this.config.reqData.rows == 0) totalPage -= 1;

			// 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
			var totalPageList = Math.ceil(totalPage / this.config.reqData.pageCnt);

			// 페이지 리스트가 몇번째 리스트인지
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);

			// 페이지 정보 셋팅
			var pageInfoText = ""; // 페이지 정보를 담을 변수

			//////////////////////////////////////////////////////////////////////////////////////////
			var base = parseInt(this._jsonData.page, 10) - 1;

			if(base < 0) base = 0;

			base = base * parseInt(this.config.rows, 10);

			var from = base + 1;
			var to = base + this.config.rows;
			//////////////////////////////////////////////////////////////////////////////////////////

			// 페이지 리스트가 1보다 작으면 1로 초기화
			if(pageList < 1) pageList = 1;

			// 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
			if(pageList > totalPageList) pageList = totalPageList;

			// 시작 페이지
			var startPageList = ((pageList - 1) * this.config.reqData.pageCnt) + 1;

			// 끝 페이지
			var endPageList = startPageList + this.config.reqData.pageCnt - 1;

			// 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
			// 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
			if(startPageList < 1) startPageList = 1;
			if(endPageList > totalPage) endPageList = totalPage;
			if(endPageList < 1) endPageList = 1;

			// 페이징 DIV에 넣어줄 태그 생성변수
			var pageInner = "";

			pageInner += "<ul class='boardNav'>";
			// 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
			if(pageList < 2){
//				pageInner += "<li><a href='#' class='btn_first disabled'></a></li>"; //<<
				pageInner += "<li><a href='#' class='btn_prev disabled'></a></li>"; //<
			} else { // 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
//				var titleFirstPage = "첫 페이지로 이동";
				var titlePrePage = (startPageList - 10) + "페이지에서 " + (endPageList - 10) + "페이지까지 이동";

//				pageInner += "<li><a class='btn_first' href='#' title='" + titleFirstPage + "'></a></li>";
				pageInner += "<li><a class='btn_prev' href='#' title='" + titlePrePage + "'></a></li>";
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardPage'>";
			// 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
			for(var i = startPageList; i <= endPageList; i++){
				var titleGoPage = i + "페이지로 이동";

				if(i == currentPage){
					pageInner += "<li class='on'><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}else{
					pageInner += "<li><a href='#' id='" + (i) + "' title='" + titleGoPage + "'>"+(i)+"</a></li>";
				}
			}
			pageInner += "</ul>";

			pageInner += "<ul class='boardNav'>";
			// 다음 페이지 리스트가 있을 경우
			if(totalPageList > pageList){
				var titleNextPage = (startPageList + 10) + "페이지에서 " + (endPageList + 10) + "페이지까지 이동";
//				var titleLastPage = "마지막 페이지로 이동";

				pageInner += "<li><a class='btn_next' href='#' title='" + titleNextPage + "'></a></li>"; //>
//				pageInner += "<li><a class='btn_last' href='#' title='" + titleLastPage + "'></a></li>"; //>>
			}

			// 현재 페이지리스트가 마지막 페이지 리스트일 경우
			if(totalPageList == pageList){
				pageInner += "<li><a href='#' class='btn_next disabled'></a></li>"; //>
//				pageInner += "<li><a href='#' class='btn_last disabled'></a></li>"; //>>
			}
			pageInner += "</ul>";

			var html = "";
			html += "<div class='board_pager'>";
			html += pageInner;
			html += "</div>"

			$page.empty();
			$page.append(html);

			this._setPagingEvt($page);
			this.$elem.append($page);
		},

		_setPagingEvt : function($page) {
			var self = this;

			$page.find("ul>li>a").on("click", function(evt){
				evt.preventDefault();

				var className = $(this).attr("class");

				if(className != "" && className != null) {
					if(className.indexOf("disabled") != -1){
						return true;
					}
				}

				switch (className) {
					case "btn_first" :
						self._firstPage();
						break;
					case "btn_prev" :
						self._prePage();
						break;
					case "btn_next" :
						self._nextPage();
						break;
					case "btn_last" :
						self._lastPage();
						break;
					default :
						self._goPage($(this).attr("id"));
						break;
				}
			});
		},

		// 첫페이지로 이동
		_firstPage : function(){
			this.config.reqData.page = "1";
			this._loadList();
		},

		// 이전페이지 이동
		_prePage : function(){
			var currentPage = this._jsonData.page;

			currentPage -= this.config.reqData.pageCnt;
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);
			currentPage = (pageList - 1) * this.config.reqData.pageCnt + this.config.reqData.pageCnt;

			this.config.reqData.page = currentPage;
			this._loadList();
		},

		// 다음페이지 이동
		_nextPage : function(){
			var currentPage = this._jsonData.page;

			currentPage += this.config.reqData.pageCnt;
			var pageList = Math.ceil(currentPage / this.config.reqData.pageCnt);
			currentPage = (pageList - 1) * this.config.reqData.pageCnt + 1;

			this.config.reqData.page = currentPage;
			this._loadList();
		},

		// 마지막페이지 이동
		_lastPage : function(){
			var totalPage = this._jsonData.total;
			if(totalSize % this.config.reqData.rows == 0) totalPage -= 1;
			this.config.reqData.page = totalPage;
			this._loadList();
		},

		// 페이지 번호로 이동
		_goPage : function(num){
			this.config.reqData.page = num;
			this._loadList();
		},

		getData : function(rowIdx, key) {
			if(key == null || key == "" || key == "undefined") key = "key";
			return this._jsonData.root[rowIdx][key];
		},

		reset : function () {
			this.$elem.empty();
		},
	}

	window.SafetySingList = SafetySingList;



	var SearchJsonList = function(elem, options) {
		this.$elem = $(elem);
		this.options = options;
		this._init();
	};

	SearchJsonList.prototype = {
		config : null,

		_defaults : {
			reqData			: {},
			colModel		: [],
			colNames		: [],
			tpVer			: "1",
			onCellClick		: function(rowIdx, colIdx, cellContent, evt) {
			},
			onRowClick	: function(rowIdx, evt) {
			},
		},

		_init : function () {
			this.config = $.extend({}, this._defaults, this.options);
			this._setTableStrucObj();
			this._setHeader();
			this.loadList();
			this._arrJsonData = [];
		},

		_setTableStrucObj : function () {
			this.$elem.children("div.board_tp" + this.config.tpVer).append(
				"<table class='tbl_col_tp" + this.config.tpVer + "'>" +
					"<colgroup>" +
					"</colgroup>" +
					"<thead>" +
						"<tr>" +
						"</tr>" +
					"</thead>" +
					"<tbody>" +
					"</tbody>" +
				"</table>"
			);
		},

		_setHeader : function () {
			var colGroupHtml = "";
			var theadHtml = "";

			$.each(this.config.colNames, function(idx, col){
				theadHtml += "<th>" + col.name + "</th>";
				colGroupHtml += "<col width='" + col.width + "' />";
			});

			this.$elem.find("table").children("colgroup").append(colGroupHtml);
			this.$elem.find("table").children("thead").children("tr").append(theadHtml);
		},

		_arrJsonData : [],
		_idx : 0,

		addJsonData : function(feature){
			this._arrJsonData.push({
				num : ++this._idx,
				feature : feature
			});
			this._setList();
		},

		removeJsonData : function(num){
			var _self = this;
			$.each(this._arrJsonData, function(idx){
				if(this.num == num) {
					_self._arrJsonData.splice(idx, 1);
					return false;
				}
			});
			this._setList();
		},

		loadList : function () {
			this._setList();
		},

		reloadList : function (params) {
			if (!params) params = {};
			this.config.reqData = params;
			this.loadList();
		},

		_setList : function () {
			var _self = this;

			var $tbody = _self.$elem.find("table>tbody");
			$tbody.empty();

			var $page = this.$elem.find("div.board_pager_wrap");
			var $p = this.$elem.find("p.tit");
			$p.empty();

			if ($page.length > 0) $page.remove();
			$p.append(
				"총 " +
				"<span class='txt_blue fm'>" + this._arrJsonData.length + "</span>" +
				"개"
			);

			if(_self._arrJsonData.length != 0) {
				$.each(_self._arrJsonData, function(rowIdx, rowData){
					var $row = $("<tr>");

					$.each(_self.config.colModel, function(colIdx, colData){
						var $cell;
						if (colData.formatter) {
							var formtterHtml ="";

							formtterHtml = colData.formatter(rowData[colData.name], rowData);
							$cell = $("<td>").append(formtterHtml);
						} else {
							$cell = $("<td>" + rowData[colData.name] + "</td>");
						}

						$cell.off("click");
						$cell.on("click", function(evt){
							_self.config.onCellClick(rowIdx, colIdx, rowData[colData.name], evt);
						});

						$row.append($cell);
					});

					$row.off("click");
					$row.on({
						"click" : function(evt) {
							_self.config.onRowClick(rowIdx, evt);
						},
						"mouseenter" : function() {
							$(this).css("background", "#F6F6F6");
						},
						"mouseleave" : function() {
							$(this).css("background", "");
						},
					});

					$tbody.append($row);
				});

			} else {
				var $row = $("<tr>");
				var $cell = $("<td colspan='"+ _self.config.colModel.length +"'>")
				$cell.html("데이터가 존재하지 않습니다.")
				$row.append($cell);
				$tbody.append($row);
			}
		},

		getGeomFromFetures : function() {
			var arr = this._arrJsonData;

			if (arr.length == 0) return null;

			var points = "";
			var lineStrings = "";
			var polygons = "";

			var nPoint = 0;
			var nLine = 0;
			var nPolygon = 0;

			$.each(arr, function(){
				var geom = this.feature.getGeometry();

				if(geom instanceof ol.geom.Point) {
					if (nPoint != 0) points += "/";
					points += mapMaker.getWktFromGeom(geom);
					points += "-" + this.feature.get("tooltip");
					nPoint++;
				} else if (geom instanceof  ol.geom.LineString) {
					if (nLine != 0) lineStrings += "/";
					lineStrings += mapMaker.getWktFromGeom(geom);
					nLine++;
				} else {
					if (nPolygon != 0) polygons += "/";
					polygons += mapMaker.getWktFromGeom(geom);
					nPolygon++;
				}
			});

			var jsonGeom = {
				points : points,
				lineStrings : lineStrings,
				polygons : polygons
			};

			return jsonGeom;
		}
	}

	window.SearchJsonList = SearchJsonList;




















})(window, jQuery);