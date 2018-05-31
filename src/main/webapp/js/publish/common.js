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

// input[type=file]  
function setFilePath(oObj,tObj) {
	$("#"+tObj).val($("#"+oObj).val());
}
function resetUpFile(tObj) {
	$("#"+tObj).val('');
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

// LNB 활성화
var mainNum;
function setLnb(mn) {		
	$(".lnb li.node1").removeClass("on");
	$(".lnb li.node1").eq(mn).addClass("on");
	
	mainNum = $(".lnb li.node1.on").index(".lnb li.node1");	
	console.log(mainNum);
}

// SNB 활성화
var subNum;
function setSnb(sm) {		
	$(".snb li.node1").removeClass("on");
	$(".snb li.node1").eq(sm).addClass("on");
	
	subNum = $(".snb li.node1.on").index(".snb li.node1");	
}

// JQuery 공통함수
jQuery(document).ready(function(e) {	
	

});
