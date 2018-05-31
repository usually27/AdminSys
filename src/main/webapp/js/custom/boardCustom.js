(function(window, $) {
	"use strict";

	var JqGrid = function(listElem, bCustom, options){
		this.$listElem = $(listElem);
		this.bCustom = bCustom;
		this.options = options;
		this._init();
	};

	JqGrid.prototype = {
		config : null,

		defaults : {
			url: "",
			mtype: "post",
			datatype: "json",
			postData : {
			},
			jsonReader: {
				page: "page",
				total: "total",
				records: "records",
				root: "root"
			},
			colNames: [
			],
			colModel: [
			],
			/* 기본 row 갯수 */
			rowNum: 20,
			/* row 옵션 */
//			rowList: [10, 20, 30],
			/* rownumber */
//	 		rownumbers: true,
			/* rownumber 너비*/
//			rownumWidth: 25,
			/* gride 높이 */
			height: 500,
			/* 너비 자동으로 설정 */
			autowidth: true,
			/* 스크롤바 공간 */
			shrinkToFit: true,
			/* 기본 정렬 컬럼 */
//			sortname: "gid",
			/* 기본 정렬 옵션 */
//			sortorder: "desc",
			/* grid title 설정
			caption: "caption", */
			gridview: true,
			/* records 수 표시설정
			viewrecords: true,  */
			/* 체크박스 설정
			multiselect: true */
			/* 로딩시 메세지 설정
			loadui: false */
			/* 로딩시 메시지
			loadtext: "<img src='/images/plugins/jqueryui/img_loading.gif'/>", */
			gridComplete: function(){
			},
			loadError: function(xhr, status, error){
			},
			onSelectRow: function(rowId){
			},
			ondblClickRow: function(rowid, irow, icol){
			},
			onCellSelect: function(rowid,iCol,cellcontent,e){
			},
			loadComplete: function(){
			}
		},

		$small : null,
		$paginate : null,

		_init : function(){
			this.config = $.extend({}, this.defaults, this.options);
			this._setGrid();
		},

		_setGrid : function(){
			this.$listElem.jqGrid(this.config);
		},

		reloadGrid : function(params){
			if(!params) params = {postData : {}};
			this.$listElem.jqGrid("setGridParam", {
				postData : params.postData
			}).trigger("reloadGrid");
		},

		getData : function(rowIdx, key){
			var row = this.$listElem.jqGrid("getRowData", rowIdx);
			return row[key];
		},

		customPageInfo : "",		// 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
		customPageInfoType : "", 	// 페이지 정보의 종류
		pageCount : 10,				// 한 페이지에 보여줄 페이지 수 (ex:1 2 3 4 5)
	}

	window.JqGrid = JqGrid;

})(window, jQuery);