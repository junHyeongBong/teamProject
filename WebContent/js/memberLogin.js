/**
 * 
 */
	var idValid;
	var pwValid;
	var checkPwValid;
	var emailValid;
	var nickValid;
//	var idCheckList = new Array();
$(function(){
	
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	
	$.urlParam = function(name){
	    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	    if (results==null){
	       return null;
	    }
	    else{
	       return results[1] || 0;
	    }
	}
	
	if($.urlParam('joinError')=="true"){
		$("#tab-2").attr("checked", "checked");
	}
	
//	if("${param.joinError}" == "true"){
//		$("#tab-2").attr("checked", "checked");
//  }
	
	$('.member_gender_div').on('click', function(){
		$(this).find('.btn').toggleClass('active');
		if($(this).find('.btn-default').length>0){
			$(this).find('.btn').toggleClass('btn-default');
		}
		$(this).find('.btn').toggleClass('btn-primary');
	});
	$('#member_gender_input').val('M');
	
	$('#member_gender_male').on('click',function(){
		$('#member_gender_input').val('M');
	});
	$('#member_gender_female').on('click',function(){
		$('#member_gender_input').val('F');
	});
	
	if($("#join_id_input").val() != ""){
		idCheck();
	}
	if($("#join_email_input").val() != ""){
		emailCheck();
	}
	if($("#join_nick_input").val() != ""){
		nickCheck();
	}
	
	$(document).on('click', "#tab-1", function(){
		$("#join_pw_input").val("");
		$("#join_pw_check").val("");
		$("#join_error_msg").text("");
		$("#idSpan").text("");
		$("#pwSpan").text("");
		$("#pwCheckSpan").text("");
		$("#emailSpan").text("");
		$("#nickSpan").text("");
	})
	
	$(document).on('click', "#tab-2", function(){
		if($("#join_id_input").val() != ""){
			idCheck();
		}
		if($("#join_email_input").val() != ""){
			emailCheck();
		}
		if($("#join_nick_input").val() != ""){
			nickCheck();
		}
	})
	
	$(document).on('blur', "#join_id_input", function(){
		idCheck();
	})
	
	$(document).on('blur', "#join_pw_input", function(){
		pwCheck();
	})
	
	$(document).on('blur', "#join_pw_check", function(){
		pwDupCheck();
	})
	
	$(document).on('blur', "#join_email_input", function(){
		emailCheck();
	})
	
	$(document).on('blur', "#join_nick_input", function(){
		nickCheck();
	})
	
	$(document).on('click', "#submitButton", function(){
//		joinSubmit();
		var alertMsg;
		if(!idValid){
			alertMsg = "아이디를 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_id_input").focus();
			return false;
		}if(!pwValid){
			alertMsg = "비밀번호를 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_pw_input").focus();
			return false;
		}if(!checkPwValid){
			alertMsg = "비밀번호 일치 여부를 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_pw_check").focus();
			return false;
		}if(!emailValid){
			alertMsg = "이메일을 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_email_input").focus();
			return false;
		}if(!nickValid){
			alertMsg = "닉네임을 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_nick_input").focus();
			return false;
		}
	})
	
	$(document).on('click', "#snsSubmitButton", function(){
		var alertMsg;
		if(!nickValid){
			alertMsg = "닉네임을 확인하세요."
			swal(alertMsg);
			$("#join_error_msg").text(alertMsg);
			$("#join_nick_input").focus();
			return false;
		}
	})
	
	$( "input[ type='password' ]" ).keypress( function(e) {
		  var key_check = e.which;
		  var isUp = ( key_check >= 65 && key_check <= 90 ) ? true : false;
		  var isLow = ( key_check >= 97 && key_check <= 122 ) ? true : false;
		  var isShift = ( e.shiftKey ) ? e.shiftKey : ( ( key_check == 16 ) ? true : false );
		  if ( ( isUp && !isShift ) || ( isLow && isShift ) ) {
			  capLock();
		  }else{
			  $("#msg").remove();
		  }
	});
	function capLock(){
		Msg.show('Caps Lock 키가 켜져있습니다.', 'danger', 5000);
	}

	
	
}); // window onload end.

function refreshCaptcha(){
	$.ajax({
//		url:"../common/refreshCaptcha",
		url: getContextPath()+"/common/refreshCaptcha",
		type:"post",
//		data : {"${_csrf.parameterName}":"${_csrf.token}"},
		dataType:"json",
		success : function(data){
// 		 		$("#captchaImage").remove();
// 		 		$("#captchaImageArea").append($("<img src='"+data.captchaImageUrl+"' id='captchaImage'>"));
		 		$("#captchaImage").attr("src", data.captchaImageUrl);
		 		$("#captchaKey").val(data.captchaKey);
		}
	})			
}

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

function idCheck(){
	idValid = false;
	var idReg = /^[a-z0-9]{4,12}$/;
	var idResult = idReg.test($("#join_id_input").val());
	if(!idResult){
		$("#idSpan").text("아이디는 소문자, 숫자 조합 공백 없이 4~12자")
		.css({"color":"#ACFA58", "font-weight":"bold"});
		return false;
	}
	$.ajax({
//		url:"../common/checkID",
		url: getContextPath()+"/common/checkID",
		type:"post",	
		data : {"member_id":$("#join_id_input").val()},
		dataType:"json",
		success : function(data){
			var strResult;
			if(data.result){
				strResult = '사용가능 아이디';
				idValid = true;
//				addArray($("#join_id_input").val(),idCheckList);
//				for(var i=0;i<idCheckList.length;i++){
//					console.log(idCheckList[i]);
//				}
			}else{
				strResult = '이미 사용중인 아이디입니다.';
			}
			$("#idSpan").text(strResult).css({"color":"#ACFA58", "font-weight":"bold"});
		}
	})
}

function addArray(val,array){
	for(var i=0;i<array.length;i++){
		if(array[i]==val){
			return false;
		}
	}
	array.push(val);
}

function pwCheck(){
	pwValid = false;
	checkPwValid = false;
	var pwReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
	var pwResult = pwReg.test($("#join_pw_input").val());
	if(!pwResult){
		$("#pwSpan").text("대소문자 + 숫자 또는 특수문자 포함 6~15자")
		.css({"color":"#ACFA58", "font-weight":"bold"});
		return false;
	}else{
		$("#pwSpan").text("사용 가능").css({"color":"#ACFA58", "font-weight":"bold"});
		pwValid = true;
	}
}

function pwDupCheck(){
	checkPwValid = false;
	if($("#join_pw_check").val() == $("#join_pw_input").val()){
		$("#pwCheckSpan").text("비밀번호가 일치합니다.").css({"color":"#ACFA58", "font-weight":"bold"});
		checkPwValid = true;
	}else{
		$("#pwCheckSpan").text("비밀번호가 일치하지 않습니다.").css({"color":"#ACFA58", "font-weight":"bold"});
	}
}

function emailCheck(){
	emailValid = false;
	var emailReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var emailResult = emailReg.test($("#join_email_input").val());
	
	if(!emailResult){
		$("#emailSpan").text("올바른 이메일 형식이 아닙니다.")
		.css({"color":"#ACFA58", "font-weight":"bold"});
		return false;
	}
	
	$.ajax({
		url: getContextPath()+"/common/checkEmail",
		type:"post",	
		data : {"member_email":$("#join_email_input").val(),"member_id":" "},
		dataType:"json",
		success : function(data){
			var strResult;
			if(data.result){
				strResult = '사용가능 이메일';
				emailValid = true;
			}else{
				strResult = '이미 사용중인 이메일입니다.';
			}
			$("#emailSpan").text(strResult).css({"color":"#ACFA58", "font-weight":"bold"});
		}
	})
}

function nickCheck(){
	nickValid = false;
	var nickReg = /^[가-힣a-zA-Z0-9]{2,10}$/;
	var nickResult = nickReg.test($("#join_nick_input").val());
	
	if(!nickResult){
		$("#nickSpan").text("닉네임은 공백없이 2~10자").css({"color":"#ACFA58", "font-weight":"bold"});
		return false;
	}

	$.ajax({
		url: getContextPath()+"/common/checkNick",
		type:"post",
		data : {"member_nick":$("#join_nick_input").val(),"member_id":" "},
		dataType:"json",
		success : function(data){
			var strResult;
			if(data.result){
				strResult = '사용가능 닉네임';
//					$("#nickSpan").text("");
				nickValid = true;
			}else{
				strResult = '이미 사용중인 닉네임입니다.';
//					$("#nickSpan").text("");
			}
			$("#nickSpan").text(strResult).css({"color":"#ACFA58", "font-weight":"bold"});
		}
	})			
}

function joinSubmit(){
	if(!idValid){
		swal("아이디를 확인하세요.")
		$("#join_id_input").focus();
		return false;
	}if(!pwValid){
		swal("비밀번호를 확인하세요.")
		$("#join_pw_input").focus();
		return false;
	}if(!checkPwValid){
		swal("비밀번호 일치 여부를 확인하세요.")
		$("#join_pw_check").focus();
		return false;
	}if(!emailValid){
		swal("이메일을 확인하세요.")
		$("#join_email_input").focus();
		return false;
	}if(!nickValid){
		swal("닉네임을 확인하세요.")
		$("#join_nick_input").focus();
		return false;
	}
}