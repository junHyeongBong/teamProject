<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="csrf_token" content="${_csrf.token}">
<title>마이 페이지</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>

<!-- 3개 있어야됨 -->  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>  
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- css -->
<link rel="stylesheet" href="${contextPath}/css/bootstrap-msg-0.4.0.min.css">
<script src="${contextPath}/js/bootstrap-msg-0.4.0.min.js"></script>
<link rel="stylesheet" href="${contextPath }/css/memberMyPage.css">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 나눔고딕체 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<script type="text/javascript">
	var emailValid = false;
	var pwValid = false;
	var checkPwValid = false;
	var nickValid = false;
	var nickCheckDup = false;
	var authCode;
	var authCodeSend = false;
	var pwForEmailValid = false;
	let hasShownAlert;
	
	$(function(){
		hasShownAlert = false
		$(document).on('focus', "#email_input", function(){
			if(!hasShownAlert){
				hasShownAlert = true;
				swal("이메일 주소를 바꾸려면 인증이 필요합니다.");
			}	
		})
		
		$(document).on('blur', "#email_input", function(){
			emailValid = false;
			authCodeSend = false;
			authCode = null;
			var emailReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var emailResult = emailReg.test($(this).val());
			
			if(!emailResult){
				$("#mod_email_message").text("올바른 이메일 형식이 아닙니다.")
				.css({"color":"red", "font-weight":"bold"});
				return false;
			}
			if($(this).val() == "${member.member_email}"){
				$("#mod_email_message").text("현재 사용중인 이메일입니다.")
				.css({"color":"red", "font-weight":"bold"});
				return false;
			}
		
			$.ajax({
				url:"${contextPath}/common/checkEmail",
				type:"post",	
				data : {"member_email":$(this).val(),"member_id":" ","${_csrf.parameterName}":"${_csrf.token}"},
				dataType:"json",
				success : function(data){
					var strResult;
					if(data.result){
						strResult = '사용가능 이메일';
						$("#mod_email_message").text(strResult).css({"color":"blue", "font-weight":"normal"});
						emailValid = true;
					}else{
						strResult = '이미 사용중인 이메일입니다.';
						$("#mod_email_message").text(strResult).css({"color":"red", "font-weight":"bold"});
					}
					
				}
			})
		})
		
		$(document).on('focus', "#pw_input", function(){
			$("#check_pwSpan").text("");
		})
		
		$(document).on('blur', "#pw_input", function(){
			pwValid = false;
			checkPwValid = false;
			var pwReg = /^[a-zA-Z0-9~!@#$%^&*()-_+=/?]{6,15}$/;		
			var pwResult = pwReg.test($(this).val());
			if(!pwResult){
				$("#pwSpan").text("대소문자 + 숫자 또는 특수문자 포함 6~15자")
				.css({"color":"red", "font-weight":"bold"});
			}else{
				$("#pwSpan").text("사용 가능").css({"color":"blue", "font-weight":"normal"});
				pwValid = true;
			}
		})
		
		$(document).on('blur', "#check_pw_input", function(){
			checkPwValid = false;
			if($(this).val() == $("#pw_input").val()){
				$("#check_pwSpan").text("입력하신 비밀번호가 일치합니다.").css({"color":"blue", "font-weight":"normal"});
				checkPwValid = true;
			}else{
				$("#check_pwSpan").text("입력하신 비밀번호가 일치하지 않습니다.").css({"color":"red", "font-weight":"bold"});
			}
			
		})
		
		$(document).on('focus', "#nick_input", function(){
			nickValid = false;
			$("#nickSpan").text("중복검사가 필요합니다.").css({"color":"red", "font-weight":"bold"});
		})
		
		$(document).on('click', "#messageButton", function(){
			var form = $("<form>");
			form.attr("id", "receiveMsgForm")
			form.attr("method", "post");
			form.attr("action", "${contextPath}/common/receiveMsgBox");
			form.attr("target", "receiveMsgBox");
			$(document.body).append(form);

			var input3 = $("<input>");
			input3.attr("type", "hidden");
			input3.attr("name", "${_csrf.parameterName}");
			input3.attr("value", "${_csrf.token}");
			form.append(input3);
			
			window.open("", "receiveMsgBox", "width=441 height=538");
			$("#receiveMsgForm").submit();
			$("#receiveMsgForm").remove();
		})
		
		$(document).on("keypress", "input[ type='password' ]", function(e){
// 		$( "input[ type='password' ]" ).keypress( function(e) {
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
			Msg.show('Caps Lock 키가 켜져있습니다.', 'danger', 8000);
		}
		
	}) // window onload end.
	
	function appendPfTd(){
		$("#pfModButton").remove();
		$("#pfTd").append($("<div id='mod_pf_input'>"));
		$("#mod_pf_input").append($("<label for='pf_up_image' id='pf_up_image_label' value='파일 선택'>"))
		.append($("<input id='pf_up_image'><br>"))
		.append($("<input id='mod_pf_image'>"))
 		.append($("<input id='mod_pf_cancel'><br>"))
		.append($("<input id='pfDelButton'>"));
		
		$("#pf_up_image").attr({"type":"file", "name":"pf_up_image", "title":"프로필 사진 업로드"});
 		$("#mod_pf_image").attr({"type":"button", "value":"등록", "onclick":"uploadPfImage()"});
// 		$("#mod_pf_image").attr({"type":"button", "onclick":"uploadPfImage()"});
 		$("#mod_pf_cancel").attr({"type":"button", "value":"취소", "onclick":"cancelModPf()"});
 		$("#pfDelButton").attr({"type":"button", "value":"프로필 삭제", "onclick":"deletePfImage()"});
  		$("#pfDelButton").css("display","none");
  		$.ajax({
  			url: "${contextPath}/common/checkPfImage",
  			type: "post",
  			data: {"${_csrf.parameterName}":"${_csrf.token}"},
  			dataType:"json",
  			success: function(data){
             	if(data.result){
             		$("#pfDelButton").show();
             		$("#mod_pf_image").attr("value","변경");
             	}else{
             		$("#mod_pf_image").attr("value","등록");
             	}
            }
  		})
  		
	}
	
	function cancelModPf(){
		$("#mod_pf_input").remove();
		$("#pf_image_div").after($("<input id='pfModButton'>"));
		$("#pfModButton").attr({"type":"button", "onclick":"appendPfTd()"});
// 		$("#pfModButton").attr({"type":"button", "value":"수정", "onclick":"appendPfTd()"});
		$.ajax({
  			url: "${contextPath}/common/checkPfImage",
  			type: "post",
  			data: {"${_csrf.parameterName}":"${_csrf.token}"},
  			dataType:"json",
  			success: function(data){
             	if(data.result){
             		$("#pfModButton").attr("value","수정");
             	}else{
             		$("#pfModButton").attr("value","등록");
             	}
            }
  		})
		
	}
	
	function uploadPfImage(){
		//확장자 체크
	    var arr = $("#pf_up_image").val().split(".");
	    var arrSize = arr.length;
	    var fileExt = arr[arrSize-1].toUpperCase();
	    if ((arr[arrSize-1].toUpperCase()!="JPG")&&(arr[arrSize-1].toUpperCase()!="PNG")&&(arr[arrSize-1].toUpperCase()!="GIF")){
	        swal("지원하지 않는 파일 확장자입니다.");
	        return false;
	    }
	    
	    //파일크기 체크
	    var fileSize = $("input[name='pf_up_image']")[0].files[0].size;
	    console.log("### fileSize="+fileSize);
	    if (fileSize > 786432) {//byte단위
	        $("#pf_up_image").val("");
	        swal("JPG 이미지는 768kbyte 이하여야 합니다.");
	        $("#pf_up_image").focus();
	        return false;
	    }
	    
		//프로필 사진 업로드	
		var formData = new FormData();
	    formData.append("file",$("input[name='pf_up_image']")[0].files[0]);
	        $.ajax({
				headers: {'X-CSRF-Token' : "${_csrf.token}"},
	        	url : "${contextPath}/common/uploadPfImage",
	            type: 'post',
	            processData: false,
	            contentType: false,
	            data: formData,
	            success: function(result){
	                swal("프로필 등록 성공");
	                $("#pf_image_div").empty();
	                $("#pf_image_div").append($("<img id='pf_image' src='profile?fileName=profile." + fileExt + "'>"));
	                $("#pf_up_image").val("");
	                $("#mod_pf_image").attr("value","변경");
	                $("#pfDelButton").show();
	            },
	            error: function(e){
	                swal("등록 처리중 오류가 발생하였습니다.");
	            }
	        });
	}
	
	function deletePfImage(){
		$.ajax({
        	url : "${contextPath}/common/deletePfImage",
            type: 'post',
            data : {"${_csrf.parameterName}":"${_csrf.token}"},
            dataType:"json",
            success: function(data){
             	if(data.result){
             		swal("프로필 삭제 완료");
             		$("#pf_image").remove();
             		cancelModPf();
             		$("#pfModButton").attr("value","등록");
             		$("#pf_image_div").append($("<img id='pf_image'	src='profile?fileName=profile.png&isDefault=true'>"))
             	}else{
             		swal("프로필 삭제 실패");
             	}
            }
        });		
	}
</script>

</head>
<body>

	<section class="main-container">
	<div class="container">
		<div class="row">
			<div class="main col-lg-8 order-lg-2 ml-xl-auto" id="myPageMainFrame">
				<div class="wrap">

					<div class="block clearfix">
						<h3 class="title">내정보</h3>
					</div>

					<div class="separator-2"></div>

					<table>
						<tr>
							<th>프로필 사진</th>
							<td id="pfTd">
								<div id="mod_pf_preserve">
									<div id="pf_image_div">
										<c:choose>
											<c:when test="${member.member_pf_image ne null}">
												<img id="pf_image"
													src="profile?fileName=profile.${member.member_pf_image}">
											</c:when>
											<c:otherwise>
												<img id="pf_image"
													src="profile?fileName=profile.png&isDefault=true">
											</c:otherwise>
										</c:choose>
									</div>
									<input type="button"
										<c:choose>
												<c:when test="${member.member_pf_image ne null}">
													value="수정"
												</c:when>
												<c:otherwise>
													value="등록"
												</c:otherwise>
											</c:choose>
										id="pfModButton" onclick="appendPfTd()">
								</div>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><span id="id"> <c:if
										test="${member.member_type eq 'normal'}">
										${member.member_id}
										<input type="hidden" name="member_id"
											value="${member.member_id}">
									</c:if> <c:if test="${member.member_type eq 'naver'}">Naver 회원</c:if>
									<c:if test="${member.member_type eq 'kakao'}">Kakao 회원</c:if> <c:if
										test="${member.member_type eq 'google'}">Google 회원</c:if>
							</span></td>
						</tr>
						<tr>
							<th>최초 가입일</th>
							<td><span id="regdate"><fmt:formatDate
										value="${member.member_regdate}" type="both"
										pattern="yyyy.MM.dd HH:mm:ss" /></span></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td id="pwTd"><c:if test="${member.member_type eq 'normal'}">
									<input type="button" value="수정" id="pwModButton"
										onclick="appendPwTd()">
								</c:if> <c:if test="${member.member_type eq 'naver'}">
									<span id="email">Naver 회원</span>
								</c:if> <c:if test="${member.member_type eq 'kakao'}">
									<span id="email">Kakao 회원</span>
								</c:if> <c:if test="${member.member_type eq 'google'}">
									<span id="email">Google 회원</span>
								</c:if></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td id="emailTd"><c:if
									test="${member.member_type eq 'normal'}">
									<span id="email">${member.member_email}</span>
									<input type="button" value="수정" id="emailModButton"
										onclick="appendEmailTd()">
								</c:if> <c:if test="${member.member_type eq 'naver'}">
									<span id="email">Naver 회원</span>
								</c:if> <c:if test="${member.member_type eq 'kakao'}">
									<span id="email">Kakao 회원</span>
								</c:if> <c:if test="${member.member_type eq 'google'}">
									<span id="email">Google 회원</span>
								</c:if></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td id="nickTd"><span id="nick">${member.member_nick}</span><input
								type="button" value="수정" id="nickModButton"
								onclick="appendNickTd()"></td>
						</tr>
						<tr>
							<th>성별</th>
							<td><span id="gender"> <c:choose>
										<c:when test="${member.member_gender eq 'M'}">남</c:when>
										<c:otherwise>여</c:otherwise>
									</c:choose>
							</span></td>
						</tr>
					</table>
					<br>
				</div>
			</div>

			<form name="abc" method="post" action="myBoard" id="memberNick">
				<input type="hidden" name="member_nick"
					value="${member.member_nick }"> <input type="hidden"
					name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>

			<form action="myReply" id="Reply" method="post" name="replyname">
				<input type="hidden" name="member_nick"
					value="${member.member_nick }"> <input type="hidden"
					name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>

			<aside class="col-lg-4 col-xl-3 order-lg-1">
			<div class="sidebar">
				<div class="block clearfix">
					<h3 class="title">마이페이지</h3>
				</div>
				<div class="separator-2"></div>
				<nav>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link"><span>회원정보</span></a></li>
					<%-- 							<li class="nav-item"><a class="nav-link" onclick="location.href='../common/myBoard?member_nick=${member.member_nick}'"><span>내가 쓴 글</span></a></li> --%>
					<li class="nav-item"><a class="nav-link"
						href="../common/myBoard?paging=0"><span>내가 쓴 글</span></a></li>
					<li class="nav-item"><a class="nav-link"
						href="../common/myReply?paging=0"><span>내가 쓴 리플</span></a></li>
					<!-- 							<li class="nav-item"><a class="nav-link" href=""><span>원 따봉한 글</span></a></li> -->
					<li class="nav-item"><a class="nav-link" id="messageButton"><span>쪽지/친구목록</span></a></li>
					<!-- 							<li class="nav-item"><a class="nav-link" href=""><span></span></a></li> -->
					<li class="nav-item"><a class="nav-link" id="leave"
						data-toggle="modal" data-target="#myModal" onclick="reset()"><span>회원
								탈퇴</span></a></li>
					<li class="nav-item"><a class="nav-link" id="main"
						href="${contextPath }/common/main"><span>메인으로</span></a></li>
				</ul>
				</nav>
			</div>
			</aside>
		</div>
	</div>
	</section>


	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!--         Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">탈퇴하시겠습니까?</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>


				<!--         Modal body -->
				<div class="modal-body">
					<div>
						<c:if test="${member.member_type eq 'normal'}">	
							<input type="password" placeholder="패스워드를 입력해주세요" class="w3-input"
								id="leavePwInput">
						</c:if>	
						<c:choose>
							<c:when test="${member.member_type eq 'normal'}">
								<button type="button"
									class="btn btn-danger pull-right leaveButton"
									onclick="leaveMember()" value="탈퇴">탈퇴신청</button>
							</c:when>
							<c:otherwise>
								<button type="button"
									class="btn btn-danger pull-right snsleaveButton"
									onclick="leaveSnsMember()" value="탈퇴">탈퇴신청</button>
							</c:otherwise>
						</c:choose>	
					</div>
				</div>


				<!--         Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>


			</div>
		</div>
	</div>



</body>

<script type="text/javascript">
	function appendPwTd() {
		$("#pwModButton").remove();
		$("#pwTd").append($("<div id='mod_pw_input'>"))
		$("#mod_pw_input")
				.append(
						$("<input type='password' class='w3-input' name='current_member_pw' id='current_pw_input' placeholder='현재 비밀번호'><br>"))
				.append(
						$("<input type='password' class='w3-input' name='member_pw' id='pw_input' placeholder='새로운 비밀번호'><span id='pwSpan'></span><br>"))
				.append(
						$("<input type='password' class='w3-input' name='check_member_pw' id='check_pw_input' placeholder='새 비밀번호 확인'><span id='check_pwSpan'></span><br>"))
				.append(
						$("<input type='button' id='mod_pw' value='변경하기' onclick='modPw()'><input type='button' id='mod_pw_cancel' value='취소' onclick='cancelModPw()'><br>"))
				.append($("<div id='mod_pw_message'>"));
	}

	function cancelModPw() {
		$("#mod_pw_input").remove();
		$("#pwTd")
				.append(
						$("<input type='button' value='수정' id='pwModButton' onclick='appendPwTd()'>"));
	}

	function modPw() {
		if (!pwValid) {
			swal("변경할 비밀번호를 확인하세요.");
			return false;
		}
		if (!checkPwValid) {
			swal("입력하신 비밀번호가 일치하지 않습니다.");
			return false;
		}

		$.ajax({
			url : "${contextPath}/common/checkPw",
			type : "post",
			data : {
				"member_pw" : $("#current_pw_input").val(),
				"member_id" : "${member.member_id}",
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					$.ajax({
						url : "${contextPath}/common/updatePw",
						type : "post",
						data : {
							"member_pw" : $("#pw_input").val(),
							"member_id" : "${member.member_id}",
							"${_csrf.parameterName}" : "${_csrf.token}"
						},
						dataType : "json",
						success : function(data) {
							if (data.result) {
								swal("비밀번호 업데이트 완료").then(function() {
									location.href = "${contextPath}/common/myPage";
								});
								
							} else {
								swal("업데이트 실패");
								return false;
							}
						}
					})
				} else {
					swal("현재 비밀번호가 일치하지 않습니다.");
					return false;
				}
			}
		})
	}

	function appendEmailTd() {
		$("#email").remove();
		$("#emailModButton").remove();
		$("#emailTd").append($("<div id='mod_email_input'>"))
		$("#mod_email_input")
				.append($("<span>기존 이메일 : ${member.member_email}</span><br>"))
				.append(
						$("<input type='text' class='w3-input' name='member_email' id='email_input' placeholder='새로운 이메일 주소'><input type='button' value='인증메일 보내기' id='emailAuthButton' onclick='emailAuth()'><br>"))
				.append(
						$("<input type='text' class='w3-input' name='member_email_authcode' id='email_auth_input' placeholder='인증 문자'><br>"))
				.append(
						$("<span id='mod_email_message'>이메일을 입력하세요.</span><br>"))
				.append(
						$("<input type='password' class='w3-input' name='member_pw' id='email_pw_input' placeholder='계정 비밀번호'><span id='pwM'>비밀번호를 입력해야 수정 가능합니다.</span><br>"))
				.append(
						$("<input type='button' id='modEmail' value='변경하기' onclick='modEmail()'><input type='button' id='cancelModEmail' value='취소' onclick='cancelModEmail()'>"));
	}

	function cancelModEmail() {
		$("#mod_email_input").remove();
		$("#emailTd")
				.append(
						$("<span id='email'>${member.member_email}</span><input type='button' value='수정' id='emailModButton' onclick='appendEmailTd()'>"));
	}

	function emailAuth() {
		if (emailValid) {
			$.ajax({
				url : "${contextPath}/common/sendAuthCode",
				type : "post",
				data : {
					"member_email" : $("#email_input").val(),
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				dataType : "text",
				success : function(data) {
					authCode = data;
					authCodeSend = true;
					hasShownAlert = false;
					swal("입력하신 이메일로 인증 문자가 발송되었습니다.");
					console.log("저장되는 오쓰 코드 : " + authCode);
					$("#mod_email_message").text("이메일로 발송된 인증 문자를 입력하세요.").css(
							{
								"color" : "blue",
								"font-weight" : "normal"
							});
				}
			})
		} else {
			swal("이메일 주소를 확인하세요.");
		}
	}

	function modEmail() {
		if (!emailValid) {
			swal("이메일 주소를 확인하세요.");
			return false;
		}
		if (!authCodeSend) {
			swal("이메일 주소를 바꾸려면 인증이 필요합니다.");
			return false;
		}

		if ($("#email_auth_input").val() != authCode) {
			swal("인증 문자가 일치하지 않습니다.");
			return false;
		}

		$.ajax({
			url : "${contextPath}/common/checkPw",
			type : "post",
			data : {
				"member_pw" : $("#email_pw_input").val(),
				"member_id" : "${member.member_id}",
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					$.ajax({
						url : "${contextPath}/common/updateEmail",
						type : "post",
						data : {
							"member_email" : $("#email_input").val(),
							"member_id" : "${member.member_id}",
							"${_csrf.parameterName}" : "${_csrf.token}"
						},
						dataType : "json",
						success : function(data) {
							if (data.result) {
								swal("이메일 업데이트 완료").then(function() {
									location.href = "${contextPath}/common/myPage";
								});
							} else {
								swal("업데이트 실패");
								return false;
							}
						}
					})
				} else {
					swal("비밀번호가 일치하지 않습니다.");
					return false;
				}
			}
		})
	}

	function appendNickTd() {
		$("#nick").remove();
		$("#nickModButton").remove();
		$("#nickTd").append($("<div id='mod_nick_input'>"))
		$("#mod_nick_input")
				.append(
						$("<input type='text' class='w3-input' name='member_nick' id='nick_input' value='${member.member_nick}'><input type='button' value='중복 확인' id='nickCheckButton' onclick='checkNickDup()'><span id='nickSpan'></span><br>"))
				.append(
						$("<input type='button' id='mod_nick' value='변경하기' onclick='modNick()'><input type='button' id='mod_nick_cancel' value='취소' onclick='cancelModNick()'>"))
	}

	function cancelModNick() {
		$("#mod_nick_input").remove();
		$("#nickTd")
				.append(
						$("<span id='nick'>${member.member_nick}</span><input type='button' value='수정' id='nickModButton' onclick='appendNickTd()'>"));
	}

	function checkNickDup() {
		nickValid = false;
		var nickReg = /^[가-힣a-zA-Z0-9]{2,10}$/;
		var nickResult = nickReg.test($("#nick_input").val());

		if (!nickResult) {
			$("#nickSpan").text("닉네임은 공백없이 2~10자").css({
				"color" : "red",
				"font-weight" : "bold"
			});
			return false;
		}
		if ($("#nick_input").val() == "${member.member_nick}") {
			$("#nickSpan").text("현재 사용중인 닉네임입니다.").css({
				"color" : "red",
				"font-weight" : "bold"
			});
			return false;
		}
		nickValid = true;

		$.ajax({
			url : "${contextPath}/common/checkNick",
			type : "post",
			data : {
				"member_nick" : $("#nick_input").val(),
				"member_id" : " ",
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			dataType : "json",
			success : function(data) {
				var strResult;
				if (data.result) {
					strResult = '사용가능 닉네임';
					//					$("#nickSpan").text("");
					$("#nickSpan").text(strResult).css({
						"color" : "blue",
						"font-weight" : "normal"
					});
					nickCheckDup = true;
				} else {
					strResult = '이미 사용중인 닉네임입니다.';
					//					$("#nickSpan").text("");
					$("#nickSpan").text(strResult).css({
						"color" : "red",
						"font-weight" : "bold"
					});
				}
			}
		})
	}

	function modNick() {
		if (nickValid && nickCheckDup) {
			$.ajax({
				url : "${contextPath}/common/updateNick",
				type : "post",
				data : {
					"member_nick" : $("#nick_input").val(),
					"member_id" : "${member.member_id}",
					"${_csrf.parameterName}" : "${_csrf.token}"
				},
				dataType : "json",
				success : function(data) {
					if (data.result) {
// 						location.href = "${contextPath}/common/myPage";
						swal("닉네임 업데이트 완료").then(function() {
							location.href = "${contextPath}/common/myPage";
						});
					} else {
						swal("업데이트 실패");
						return false;
					}
				}
			})

		} else {
			swal("닉네임을 중복 검사해야 합니다.");
			return false;
		}
	}

	function reset() {
		$("#leavePwInput").val("");
	}

	function leaveMember() {

		$.ajax({
			url : "${contextPath}/common/checkPw",
			type : "post",
			data : {
				"member_id" : "${member.member_id}",
				"${_csrf.parameterName}" : "${_csrf.token}",
				"member_pw" : $("#leavePwInput").val()
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					$.ajax({
						url : "${contextPath}/common/myPage/leave",
						type : "post",
						data : {
							"member_id" : "${member.member_id}",
							"${_csrf.parameterName}" : "${_csrf.token}"
						},
						success : function(data) {
							swal("탈퇴되었습니다").then(function() {
								location.href = "${contextPath}/common/opening";
							});
						}
					});
				} else {
					swal("비밀번호가 틀렸습니다.");
				}
			}
		});
	}
	
	function leaveSnsMember() {
		$.ajax({
			url : "${contextPath}/common/myPage/leave",
			type : "post",
			data : {
				"member_id" : "${member.member_id}",
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			success : function(data) {
				swal("탈퇴되었습니다").then(function() {
					location.href = "${contextPath}/common/opening";
				});
			}
		});
	}
</script>

</html>