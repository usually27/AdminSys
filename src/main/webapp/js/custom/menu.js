$(function() {
	"use strict";

	var MenuMng = function(elem, ajaxOpts){
		this.$elem = $(elem);
		this.ajaxOpts = ajaxOpts;
		this.menuData = [];
		this._init();
	};

	MenuMng.prototype = {
		config : null,
		$content : null,
		$navItem : null,

		_init : function(){

			var self = this;

			$.ajax({
				type		: "post",
				url			: this.ajaxOpts.url,
				dataType	: "json",
				cache		: false,
				success		: function(json) {
					self.menuData = json.root;
					self._buildMenu();
				},
				error		: function(response) {
					alert("오류발생, 다시 시도하여 주십시오");
				}
			});
		},

		_buildMenu : function(){

			var $elem = this.$elem;

			$.each(this.menuData, function(idx, row){
				if (row.menuId == "M000000000") {
					return true;
				}

				var html = "";

				if (row.treeLevel == 1) {
					html += "<li class='heading' data-menuid='" + row.menuId + "'>";
					html += "<h3 class='uppercase'>" + row.menuNm + "</h3>";
					html += "</li>";
					$elem.append(html);
				} else {
					var $parentMenu = $elem.find('li[data-menuid="' + row.parMenuId + '"]');

					if ($parentMenu.length != 0) {
						html += "<li class='nav-item' data-menuid='" + row.menuId + "'>";
						html += "<a href='#' data-url='" + row.progPath + "'class='nav-link'>";
						if (row.resourceId != "") html += "<i class='" + row.resourceId + "'></i>";
						html += "<span class='title'>" + row.menuNm;
						if(row.progPath == "1") html += " (X)"
						html += "</span>";
						html += "</a>";
						html += "</li>";

						var $menuLi = $(html);

						if ($parentMenu.attr("class").indexOf("nav-item") != -1) {
							var $aMenu = $parentMenu.children("a");

							if (!$aMenu.hasClass("nav-toggle")) {
								$aMenu.addClass("nav-toggle");
							}

							if ($aMenu.children("span.arrow").length == 0) {
								$aMenu.append("<span class='arrow'></span>");
							}

							var $subUl = $parentMenu.children("ul.sub-menu");

							if ($subUl.length == 0) {
								$subUl = $("<ul class='sub-menu' />");
								$parentMenu.append($subUl);
							}

							$subUl.append($menuLi);

						} else {
							var $temp = $parentMenu;

							while($temp.next().length != 0){
								$temp = $temp.next();
							}
							$temp.after($menuLi);
						}
					}
				}
			});

			this.$content = this.$elem.parents("div.page-container").find("div.page-content");
			this.$navItem = this.$elem.find(".nav-item");

			this._buildEvt();
		},

		_buildEvt : function(){

			var self = this;

			this.$elem.find("a").each(function(idx){
				self.addEvtLeftMenu($(this), idx);
			});

//			if(!this._checkCookie()){
//				this.$elem.find("a").eq(self._getCookie()).trigger("click");
//			}
		},

		addEvtLeftMenu : function($a, aIdx){
			var self = this;

			var dataUrl = $a.attr("data-url");

			if(!$.isEmpty(dataUrl)){
				$a.on("click", function(e){
					if($(this).parent().attr("data-menuid") == "M001001000") {
						$.popupWindow(G.baseUrl + dataUrl, { scrollbars : 0 });
					}else if($(this).attr("id") == "air"){

					}else{
						e.preventDefault();

						self.$content.showBlockUI({ boxed: true });

						self.$content.load(G.baseUrl + dataUrl, function(responseTxt, statusTxt, xhr){
							if(statusTxt == "error") {
								console.log("Error: " + xhr.status + ": " + xhr.statusText);
								$(this).html(responseTxt)
							} else {
								var pageBarHtml = "";

								$a.parents(".nav-item").each(function(idx){
									var html = "";
									html += "<li>";
									html += "<span>" + $(this).children().children("span.title").text() + "</span>";
									if(idx != 0) html += "<i class='fa fa-circle'></i>";
									html += "</li>";

									pageBarHtml = html + pageBarHtml;
								});

								var $li = $a.parents(".nav-item").last().prev();

								while($li.attr("class").indexOf("heading") == -1){
									if($li.attr("class").indexOf("nav-item") == -1){
										$li = null;
										break;
									}
									$li = $li.prev();
								}

								if($li != null){
									var html = "";
									html += "<li>";
									html += "<span>" + $li.children().text() + "</span>";
									html += "<i class='fa fa-circle'></i>";
									html += "</li>";
								}

								$(this).prepend(
									"<div class='page-bar'>" +
										"<ul class='page-breadcrumb'>" +
											"<li>" +
												"<a href='"+G.baseUrl+"index.do'>Home</a>" +
												"<i class='fa fa-circle'></i>" +
											"</li>" +
											pageBarHtml +
										"</ul>" +
									"</div>"
								);
							}
							self.$content.hideBlockUI();
						});

						$(".page-content").css("height", '');
					}

					self.convertMenuStyle($(this), aIdx);
//					self._setCookie(aIdx);
				});
			}
		},

		convertMenuStyle : function($a){
			this.$navItem.removeClass("active open");

			var $parents = $a.parents(".nav-item");

			$parents.addClass("active open");
		},

		pageMove : function(params){

			var self = this;

			this.$content.showBlockUI({ boxed: true });

			var $pageBar = this.$content.find("div.page-bar");

			var $pageTitle = this.$content.find("h1.page-title>span").parent();

			this.$content.load(G.baseUrl + params.url, params.reqData, function(responseTxt, statusTxt, xhr){
				if(statusTxt == "error") {
					console.log("Error: " + xhr.status + ": " + xhr.statusText);
					$(this).html(responseTxt)
				} else {

					if(params.innerFlag){
						$pageBar.children("ul.page-breadcrumb").append(
							"<li>" +
							"<i class='fa fa-circle'></i>" +
							"<span>" + params.title + "</span>" +
							"</li>"
						);

						$(this).prepend($pageBar);
						$pageTitle.children("h1.page-title>span").html(params.title);
						$pageBar.after($pageTitle);

					} else {
						$pageBar.find("li").last().remove();
						$(this).prepend($pageBar);
						$pageTitle.remove();
					}
				}

				self.$content.hideBlockUI();
			});










		},
//		_setCookie : function(aIdx){
//			Cookies.set("aIdx", aIdx);
//		},
//
//		_getCookie : function(){
//			return Cookies.get("aIdx");
//		},
//
//		removeCookie : function(){
//			Cookies.remove("aIdx");
//		},
//
//		_checkCookie : function(){
//			var aIdx = this._getCookie();
//			var chk = false;
//
//			if(aIdx == undefined || aIdx == null || aIdx == ""){
//				chk = true;
//			}
//
//			return chk;
//		}
	}

	window.MenuMng = MenuMng;

	G.menuMng = new MenuMng("div.page-sidebar-wrapper>div>ul", {
		url : G.baseUrl + "system/member/memberAuthList.json"
	});


});