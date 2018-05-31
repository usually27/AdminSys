/* Common Function */

function ajaxCall(frmName, sendUrl, target, callback) {
	var dataString = $("#"+frmName).serialize();

	$.ajax({
		type:"POST",
		url:sendUrl,
		cache:false,
		async:false,
		dataType:"html",
		data:dataString,
		timeout:6000,
		success:function(data){
			$("#"+ target).html(data);

			if (callback !==""){
				callback;
			}
		},
		complete:function(data){

		},
		error:function(xhr, status, error){
		}
	});
}

function ajaxLoad(selector, frmName, callUrl, callback){
	var dataString = $("#"+frmName).serialize();

	$(selector).load(callUrl, dataString, callback);
}

//loading
function showLoading() {
	var $loading = $("<div id='Loading' class='loadingWrap'></div>");

	if ($("#Loading").length == 0) {
		$loading.appendTo("body").show();
	}
}
function hideLoading() {
	if ($("#Loading").length > 0) {
		$("#Loading").hide();
	}
}
jQuery(document).ready(function(e) {
	// Loading
	$(window).ajaxStart(function() {
		showLoading();
	});
	$(window).ajaxError(function() {
		alert('ajax처리중 에러가 발생하였습니다!');
		showLoading();
	});
	$(window).ajaxStop(function() {
		hideLoading();
	});
});

// 기본파일첨부
function setFilePath(oObj,tObj) {
	$('#'+tObj).val($('#'+oObj).val());
}
function resetUpFile(tObj) {
	$('#'+tObj).val('');
}
jQuery(document).ready(function(e) {
	if($('.input_file').length > 0) {
		$(".findFile").on('keypress',function(e){
			$(this).trigger('click');
		});
	}
});

// Layer popup(custom)
(function($, undefined) {
	$.fn.extend({
		modalWindow : function(url, params) {
			params = $.extend({}, {
				reqData : {}
			}, params);

			var $self = $(this);

			$self.load(url, params.reqData, function(){
				$('html, body').addClass('no_scroll');
				$self.fadeIn();
			});
		}
	});
})(jQuery);

// Layer pop
function lp_open(obj, obj_focus){
	$('html, body').addClass('no_scroll');
	$(obj).fadeIn();
	$(obj_focus).focus();
}

function lp_close(obj){
	$('html, body').removeClass('no_scroll');
	$(obj).closest('.lp_wrap').fadeOut();
}

// Window Popup
function winPop(url, name ,sWidth, sHight, sLeft, sTop, isScroll, isResize, isTool, isMenu) {
	window.open(url,name,'width='+sWidth+',height='+sHight+',left='+sLeft+',top='+sTop+',scrollbars='+isScroll+',resizable='+isResize+',toolbar='+isTool+',menubar='+isMenu+',location=no');
}

// Datepicker Popup
function openCal(fld, callback) {
	var $initFld = $("#"+fld);

	$initFld.datepicker({
		formatDate:"ATOM",
		dateFormat:"yy-mm-dd",
		defaultDate: $initFld.val(),
		changeMonth: true,
		changeYear: true,
		showOn: "",
		buttonImageOnly: true,
		showMonthAfterYear:true	,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		altField: "#"+fld,
		showButtonPanel: true,
		closeText:"close",
		onChangeMonthYear:function(e){

		},
		/*onSelect: function() {
			if (callback !== "" || callback !== null || callback !== undefined) {
				callback($initFld.val());
			}
		},*/
		onClose:function(){
			$(".btn_datepicker.mod").focus();
			$(".btn_datepicker").removeClass("mod");
		}
	}).datepicker("show");
	$("#ui-datepicker-div").focus();
}
jQuery(document).ready(function(e) {
	$(".btn_datepicker").on('click',function(){
		$("#ui-datepicker-div:visible").focus();
		$(this).addClass("mod");
		$('.ui-datepicker-close').attr('tabindex',0);
	});
});

// Datepicker 기간선택
function setSearchDate(mm, fld1, fld2) {
	var nowDate = new Date();
	var startDate;
	var endDate = $.datepicker.formatDate($.datepicker.ATOM, nowDate);

	nowDate.setMonth(nowDate.getMonth() - parseInt(mm));

	startDate = $.datepicker.formatDate($.datepicker.ATOM, nowDate);

	$("#" + fld1).val(startDate);
	$("#" + fld2).val(endDate);
}

// SNB 활성화
var subNum;
function setSnb(sm) {
	$(".snb li.node1").removeClass("on");
	$(".snb li.node1").eq(sm).addClass("on");

	subNum = $(".snb li.node1.on").index(".snb li.node1");
}

// Snb
function snb_state() {
	if ($('body').hasClass('snb_close') == false) {
		//이벤트 핸들러 삭제
		jQuery(document).off('mouseenter','.snb li.node1');
		jQuery(document).off('mouseleave','.snb li.node1');
		jQuery(document).off('focusin','.snb li.node1');

		jQuery(document).on('click','.snb li.node1 a.depth1',function(e){
			if ($(this).parent('li.node1').hasClass('sub')) {
				e.preventDefault();
				if($(this).parent('li.node1').hasClass('on')) {	// 열려 있는 경우
					$(this).next('.submenu_wrap').stop().slideUp('fast',function(e){
						$(this).parent('li.node1').removeClass('on');
					});
				} else {											// 닫혀 있는 경우
					$('.snb li.node1 .submenu_wrap').stop().slideUp('fast',function(e){	// 아코디언
						$('.snb li.node1').removeClass('on');
					});
					$(this).next('.submenu_wrap').stop().slideDown('fast',function(e){
						$(this).parent('li.node1').addClass('on');
					});
				};
			} else {
				$(this).parent('li.node1 a.depth1').off('click');	// 이벤트 핸들러 삭제
			};
		});
	} else {
		jQuery(document).off('click','.snb li.node1 a.depth1');	// 이벤트 핸들러 삭제
		jQuery(document).on('mouseenter focusin','.snb li.node1',function(e) {
			var $menu = $(this);
			$(this).siblings('li.node1').find('.submenu_wrap:visible').hide();
			$('.snb li.node1').removeClass('on');
			$(this).addClass('on');
			$(this).find('.submenu_wrap').stop().slideDown('fast');
		});
		jQuery(document).on('mouseleave','.snb li.node1',function(e) {
			$('.snb .submenu_wrap').hide();
			$(this).removeClass('on');
		});
	}
}

// JQuery 공통함수
jQuery(document).ready(function(e) {
	//메뉴 호출
	snb_state();

	//Tab
	jQuery(document).on('click','.tablayer li a',function(e){
		var $tab_li = $(this).parent(),
			tabindex = $tab_li.index();
		e.preventDefault();
		$(this).parent().addClass('on').siblings().removeClass('on');

		var tab_content = $(this).parents('.tab_wrap').siblings('.tab_container').find('.tab_content');
		if ($(tab_content).length > 0){
			$(tab_content).removeClass('on');
			$(tab_content).eq(tabindex).addClass('on');
		};
	});

	//Accordion
	jQuery(document).on('click','.accordion li.node1 a.accordion_head',function(e){
		if($(this).parent('li.node1').hasClass('on')) {	// 열려 있는 경우
			$(this).next('.accordion_body').stop().slideUp('fast',function(e){
				$(this).parent('li.node1').removeClass('on');
			});
		} else {											// 닫혀 있는 경우
			$('.snb li.node1 .accordion_body').stop().slideUp('fast',function(e){
				$('.snb li.node1').removeClass('on');
			});
			$(this).next('.accordion_body').stop().slideDown('fast',function(e){
				$(this).parent('li.node1').addClass('on');
			});
		};
	});

	//테이블 체크박스 전체선택
	jQuery(document).on('click','.all_check',function(e){
		if ($(this).prop('checked')){
			$(this).parents('table').find('td input[type=checkbox]').prop('checked',true);
			$(this).parents('table').find('tr').addClass('on');
		} else {
			$(this).parents('table').find('td input[type=checkbox]').prop('checked',false);
			$(this).parents('table').find('tr').removeClass('on');
		}
	});

	//테이블 체크박스 개별Control
	jQuery(document).on('click','.searchResult .list_check',function(e){
		if ($(this).prop('checked')){
			$(this).parents('tr').addClass('on');
		} else {
			$(this).parents('tr').removeClass('on');
		}
	});

	//테이블 라디오박스 개별Control
	jQuery(document).on('click','.list_radio',function(e){
		$(this).parents('tr').addClass('on').siblings().removeClass('on');
	});

//	$('.lp_wrap .lp_inner').draggable();

});
