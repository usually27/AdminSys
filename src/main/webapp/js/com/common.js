//Automatically cancel unfinished ajax requests
//when the user navigates elsewhere.
(function(window, $) {
	$.xhrPool = [];
	$.xhrAbort = function() {
		$.each($.xhrPool, function(idx, jqXHR) {
			jqXHR.abort();
		});
	};

	var oldbeforeunload = window.onbeforeunload;
	window.onbeforeunload = function() {
		var r = oldbeforeunload ? oldbeforeunload() : undefined;
		if (r == undefined) {
			$.xhrAbort();
		}
		return r;
	}

	$(document).ajaxSend(function(e, jqXHR, options) {
		$.xhrPool.push(jqXHR);
	});
	$(document).ajaxComplete(function(e, jqXHR, options) {
		$.xhrPool = $.grep($.xhrPool, function(x) {
			return x != jqXHR
		});
	});


	$.xhrCheckData = function(data) {
		if (typeof data == "undefined") return false;

		if (data.hasOwnProperty("error")) {
			var errorCode = data["error"];

			switch (errorCode) {
				case "401":
					$.xhrAbort();
//					alert("로그인후 다시 시도하세요. / Ajax 요청 실패");
//					top.location.href = G.baseUrl + "user/auth/login.do";
				break;
				default:
					alert("Ajax 요청 실패 / [" + errorCode + "] " + data["message"]);

				break;
			}

			return false;

		} else {
			return true;

		}
	}

})(window, jQuery);

(function(window, $) {
	/* Combobox 실행대기 후 실행 */
	$.waitForLazyRunners = function(callback) {
		var run = function() {
			if (!$.runner || $.runner <= 0) {
				clearInterval(interval);
				if(typeof callback === 'function') {
					callback();
				}
			} else {
				//console.log("wait...");
			}
		};
		var interval = setInterval(run, 30);
	}

})(window, jQuery);

(function($, undefined) {
	$.fn.extend({

		popupWindow : function(href, options, method) {

			if($(this).get(0).tagName != "FORM")  {
				alert("form 태그가 아닙니다.");
				return;
			}

			var options = $.extend({}, {
				id		: "_popup",
				width	: screen.availWidth,
				height	: screen.availHeight
			}, options);

			var winparam = 'resizable=1,status=1,dependent=1';
			$.each(options, function(key, val) {
				if (key != "id") winparam += ", " + key + "=" + val;
			});

			var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
			var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

			var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
			var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

			var left = ((width / 2) - (options.width / 2)) + dualScreenLeft;
			var top = ((height / 2) - (options.height / 2)) + dualScreenTop;

			if (!options.hasOwnProperty("top")) winparam += ', top=' + top;
			if (!options.hasOwnProperty("left")) winparam += ', left=' + left;

			$(this).attr("target", options.id) ;

			if(!method) method = "post";

			$(this).attr({action : href, method : method});

			var popUp = window.open('',options.id,winparam);

			$(this).submit();

//			return popUp;

		},

		modalWindow : function(url, params) {
			params = $.extend({}, {
				reqData : {},
				options : {
					width : ""
				}
			}, params);

			var $self = $(this);

			$self.load(url, params.reqData, function(){
				$(this).css("width", params.options.width);
				$(this).find(".modal-header").css("background", "#0CA1D9");

				$self.modal();
			});
		}
	});

	$.extend({
		popupWindow : function(href, options) {
			var options = $.extend({}, {
				id		: "_popup",
				width	: screen.availWidth,
				height	: screen.availHeight
			}, options);

			var winparam = 'resizable=1,status=1,dependent=1';
			$.each(options, function(key, val) {
				if (key != "id") winparam += ", " + key + "=" + val;
			});

			var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
			var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

			var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
			var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

			var left = ((width / 2) - (options.width / 2)) + dualScreenLeft;
			var top = ((height / 2) - (options.height / 2)) + dualScreenTop;

			if (!options.hasOwnProperty("top")) winparam += ', top=' + top;
			if (!options.hasOwnProperty("left")) winparam += ', left=' + left;

			window.open(href, options.id, winparam);
		}
	});

})(jQuery);


/**
 *
 * @param $
 * @param undefined
 */
(function($, undefined) {
	$.fn.extend({
		getFormToJsonData : function() {

			var params = {};

			var arr = $(this).serializeArray();

			$.each(arr, function(){
				var name;
				$.each(this, function(key, value){
					if (key == "name") {
						name = value;
					} else if(key == "value") {
						if(!$.isEmpty(value)) {
							params[name] = $.trim(value);
						}else{
							params[name] = "";
						}
					}
				});
			});

			return params;
		}
	});
})(jQuery);


/**
 * @param $
 * @param undefined
 *
 * isEmpty : 비어있는지 확인 return bool
 * is$Empty : jquery 객체가 비어있는지 확인 return bool
 * isEmptyAlert : jquery 객체가 비어있는지 확인 후 메시지창 return bool
 * isLengthBetween : 최소/최대 글자 return bool
 * isByteBetween : 최소/최대 바이트 return bool
 * deleteSpace : 공백(space)제거 return string
 * trimSpace : 맨 앞/뒤 공백제거 return string
 * lpad : 왼쪽으로 글자 채우기 return string
 * rpad : 오른쪽으로 글자 채우기 return string
 * byteSize : 바이트 크기 return string
 *
 */
(function($, undefined) {
	$.fn.extend({
		isEmpty : function() {
			if($(this).val() == "" || $(this).val() == null) {
				return true;
			} else {
				return false;
			}
		},
		isEmptyAlert : function(names, gbn) {
			if($(this).is$Empty()){
				alert("존재하지 않은 객체:"+names);
				return true;
			}
			if($(this).prop("type") == "text" || $(this).prop("type") == "textarea") {
				if($(this).val() == null || $(this).val().replace(/ /gi,"") == "" || $(this).val() == gbn){
					alert(names + "을(를) 입력하십시오.");
					$(this).focus();
					return true;
				}
			} else if ($(this).prop("type") == "select" || $(this).prop("type") == "select-one" || $(this).prop("type") == "select-multiple"){
				if($(this).val() == null || $(this).val().replace(/ /gi,"") == "" || $(this).val() == gbn){
					alert(names + "을(를) 선택하십시오.");
					$(this).focus();
					return true;
				}
			} else if ( $(this).prop("type") == "file") {
				if($(this).val() == null || $(this).val().replace(/ /gi,"") == "" || $(this).val() == gbn) {
					alert(names + "을(를) 선택하십시오.");
					$(this).focus();
					return true;
				}
			}
			return false;
		},
		is$Empty : function() {
			if($(this).length == 0) {
				return true;
			} else {
				return false;
			}
		},
		isLengthBetween : function(min, max) {
			var length = $(this).val().length;

			if(min <= length && length <= max) {
				return true;
			} else {
				return false;
			}
		},
		isByteBetween : function(min, max) {
			var byteSize = $(this).byteSize();

			if(min <= byteSize && byteSize <= max) {
				return true;
			} else {
				return false;
			}
		},
		deleteSpace : function() {
			var val = $(this).val();
			val = val.replace(/ /g, "");	//space
			val = val.replace(/	/g, "");	//tab
			$(this).val(val);
		},
		trimSpace : function() {
			var val = $(this).val();
			val = $.trim(val);
			$(this).val(val);
		},
		lpad : function(totalLen, strRepl) {
			var strAdd = "";
			var diffLen = totalLen - $(this).val().length;

			for(var i = 0; i < diffLen; i++) {
				strAdd += strRepl;
			}

			var val = strAdd + $(this).val();

			$(this).val(val);
		},
		rpad : function(totalLen, strRepl) {
			var strAdd = "";
			var diffLen = totalLen - $(this).val().length;

			for(var i = 0; i < diffLen; i++) {
				strAdd += strRepl;
			}

			var val = $(this).val() + strAdd;

			$(this).val(val);
		},
		byteSize : function() {
			var val = $(this).val();
			var byteSize = 0;

			for(var i = 0; i < val.length; i++) {
				if(val.charCodeAt(i) > 255) {
					byteSize += 2;
				} else {
					byteSize += 1;
				}
			}
			return byteSize;
		},
		toUnderscore : function() {
			var val = $(this).val();
			return val.replace(/([A-Z])/g, function($1){return "_"+$1.toLowerCase();});
		}
	});

	$.extend({
		isEmpty : function(str) {
			if(str == "" || str == null) {
				return true;
			} else {
				return false;
			}
		},
		is$Empty : function($elem) {
			if($elem.length == 0) {
				return true;
			} else {
				return false;
			}
		},
		isLengthBetween : function(str, min, max) {
			var length = str.length;

			if(min <= length && length <= max) {
				return true;
			} else {
				return false;
			}
		},
		isByteBetween : function(str, min, max) {
			var byteSize = $.byteSize(str);

			if(min <= byteSize && byteSize <= max) {
				return true;
			} else {
				return false;
			}
		},
		deleteSpace : function(str) {
			var val = str.replace(/ /g, "");	//space
			val = val.replace(/	/g, "");	//tab

			return val;
		},
		trimSpace : function(str) {
			var val = $.trim(str);

			return val;
		},
		lpad : function(str, totalLen, strRepl) {
			var strAdd = "";
			var diffLen = totalLen - str.length;

			for(var i = 0; i < diffLen; i++) {
				strAdd += strRepl;
			}

			return strAdd + str;
		},
		rpad : function(str, totalLen, strRepl) {
			var strAdd = "";
			var diffLen = totalLen - str.length;

			for(var i = 0; i < diffLen; i++) {
				strAdd += strRepl;
			}

			return str + strAdd;
		},
		byteSize : function(str) {
			var val = str;
			var byteSize = 0;

			for(var i = 0; i < val.length; i++) {
				if(val.charCodeAt(i) > 255) {
					byteSize += 2;
				} else {
					byteSize += 1;
				}
			}

			return byteSize;
		},
		toUnderscore : function(str) {
			return str.replace(/([A-Z])/g, function($1){return "_"+$1.toLowerCase();});
		}
	});
})(jQuery);

// 엑셀 업로드
(function($) {
	$.fn.getExcelData = function(id, url) {

		if($(this).get(0).tagName != "FORM")  {
			alert("form 태그가 아닙니다.");
			return;
		}

		if ($("#"+id).val() == "") {
			alert("파일을 업로드해주세요.");
			return;
		}

		var value = null;

		var options = {
				url			: url,
				type		: "post",
				dataType 	: "json",
				async		: false,
				success		: function(json){
					value = json;
				},
				error	: function( response ){
					alert("엑셀 업로드 중 오류가 발생하였습니다.");
				}
		};

		$(this).ajaxSubmit( options );

		return value;
	};
})(jQuery);
