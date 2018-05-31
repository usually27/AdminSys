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

// input[type=file]  
function setFilePath(oObj,tObj) {
	$("#"+tObj).val($("#"+oObj).val());
}
function selUpFile(tObj) {
	$("#"+tObj).click();
}
function resetUpFile(tObj) {
	$("#"+tObj).val('');
}
	
// Open Layer	
function openDialog(obj) {
	$(".lp_dialog").removeClass("on");
	$(obj).addClass("on");
}
// Close Layer
function closeDialog(obj) {
	//$(".lp_dialog").removeClass("on"); //전체닫기
	$(obj).removeClass("on");
}

// Inline Page Layer Popup Open
function openLayer(obj) {
	$.colorbox({inline:true, href:obj});
}

// Outer Page Layer Popup Open
function lp_open(url, openCallback, closeCallback) {
	$.colorbox({
		href:url,
		scrolling:false,
		onComplete:function() {						
			if (openCallback) {			
				openCallback();
			}
		},
		onClosed:function(){
			if (closeCallback) {			
				closeCallback();
			}			
		}
	});
}

// Layer Popup Close
function lp_close() {
	$.colorbox.close();
};

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
		showMonthAfterYear:true	,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		altField: "#"+fld,
		showButtonPanel: true,
		closeText:"close",
		onSelect: function() {
			if (callback !== "" || callback !== null) {
				callback($initFld.val());
			}			
		}
	}).datepicker("show");
}
jQuery(document).ready(function(e) {
	$(".datepicker").datepicker({
		formatDate:"ATOM",
		dateFormat:"yy-mm-dd",
		changeMonth: true,
		changeYear: true,
		showMonthAfterYear:true	,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		showButtonPanel: true,
		closeText:"close"			
	});	
});

// LNB 활성화
var mainNum;
function setLnb(mn) {		
	$(".lnb li.node1").removeClass("on");
	$(".lnb li.node1").eq(mn).addClass("on");
	
	mainNum = $(".lnb li.node1.on").index(".lnb li.node1");	
}

// SNB 활성화
var subNum;
function setSnb(sm) {		
	$(".snb li.node1").removeClass("on");
	$(".snb li.node1").eq(sm).addClass("on");
	
	subNum = $(".snb li.node1.on").index(".snb li.node1");	
}

// JQuery 공통함수

// 메뉴/본문 바로가기 메뉴 열기
jQuery(document).ready(function(e) {		
	//Skip Menu
	$("#SkipMenu").focus();	
	$("#SkipMenu a").bind({
		'focus': function(e) {
			$("#SkipMenu").css("height","35px");
		},
		'click keypress': function(e) {
			$("#SkipMenu").css("height","0px");			
			
			if ($(document).width() < 768) {
				$("#Content").attr("tabindex","0");
				$("#Content a:first, #Content input:first").focus();
			} else {				
				if ($(this).hasClass("read-more")){
					$("#Header a:first").focus();
				} else {
					$("#Content").attr("tabindex","0");
					$("#Content a:first, #Content input:first").focus();
				}
			}
		},
		'blur': function(e) {
			$("#SkipMenu").css("height","0px");				
			if ($(this).hasClass("read-more")){
				
			}
		}
	});	
	
	// LNB	
	$(".lnb li.node1").on({
		'mouseenter':function(e) {
			$(".lnb li.node1").removeClass("on");			
			$(this).addClass("on");
		},
		'mouseleave':function(e) {
			$(this).removeClass("on");
		}
	});	
	$(".lnb_wrap").on({
		'focusin mouseenter':function(e) {
			$(".lnb_wrap").addClass("on");
			$(".bg_submenu").stop().slideDown('fast', function(e){				
				$(".lnb li.node1 .submenu").animate({
					'opacity':1
				},200);				
			});
		},
		'mouseleave':function(e) {			
			$(".lnb li.node1 .submenu").animate({
				'opacity':0
			},200, function(){	
				$(".lnb_wrap").removeClass("on");		
				$(".bg_submenu").stop().slideUp('fast');
			});
			if (mainNum !== -1) {
				$(".lnb li.node1").eq(mainNum).addClass("on");
			}
		}
	});	
	$("a").not(".lnb_wrap a").on('focusin',function(e){
		if ($(".lnb_wrap").hasClass("on")) {
			$(".lnb li.node1 .submenu").animate({
				'opacity':0
			},200, function(){	
				$(".lnb_wrap").removeClass("on");		
				$(".bg_submenu").stop().slideUp('fast');
			});
		}
	});
	
	$(".snb li.node1").on({
		'mouseenter':function(e) {
			$(".snb li.node1").removeClass("on");			
			$(this).addClass("on");			
		},
		'mouseleave':function(e) {
			$(this).removeClass("on");
			
			if (subNum !== -1) {
				$(".snb li.node1").eq(subNum).addClass("on");
			}			
		}
	});
	
	// Layer Close
	if ($(".lp_wrapper:visible").length > 0) {
		$(document).on("click",".lp_close a, .lp_wrapper a.close",function(e){		
			if ($(this).parents().is(".lp_wrapper")){
				$.colorbox.close();
			}
		});	
	}	
	
	//  lp_dialog 닫기
	$(".lp_dialog .lp_close a").on("click",function(e){
		$(".lp_dialog").removeClass("on");
	});
	
	//Tab 활성화
	$(document).on("click",".tabLayer li",function(e){
		var tabIndex = $(this).index(".tabLayer li");
		
		$(".tabLayer li").removeClass("on");		
		$(this).addClass("on");
		
		$(this).parent().parent().find(".tabContent .tabCont").css("display","none");
		$(this).parent().parent().find(".tabContent .tabCont").eq(tabIndex).css("display","block");
	});	
	
	//Tab - Ajax Type
	$("ul.tabAjax>li").on('click',function(e){
		var callTarget = $(this).find("a").attr("data-target");
		var targetArea = $(this).parents().next(".tabContent");
		//초기화
		$(this).parent().find("li").removeClass("on");		
		
		$(this).addClass("on");
		ajaxLoad(targetArea, '', callTarget, '');
	});	

});
