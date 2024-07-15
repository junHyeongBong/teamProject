<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${contextPath}/css/memberFindAccount.css">
<link rel="stylesheet" href="${contextPath}/css/bootstrap-msg-0.4.0.min.css">
<script src="${contextPath}/js/bootstrap-msg-0.4.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
	function findUserid(){
		var emailReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var emailResult = emailReg.test($("#fc_email_input").val());
		if(!emailResult){
			$("#find_idSpan").text("올바른 이메일 형식이 아닙니다.").css({"color":"#DC3545", "font-weight":"bold"});
			return false;
		}
		
		$.ajax({
			url:"${contextPath}/common/findAccount/userid",
			type:"post",
			data : {"member_email":$("#fc_email_input").val(), "${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success : function(data){
				var strResult;
				if(data.isExist){
 					strResult = "회원님의 아이디는 " + data.member_id + " 입니다.";
					$("#find_idSpan").text(strResult).css({"color":"indigo", "font-weight":"bold"});
				}else{
					strResult = "해당 이메일 주소가 존재하지 않습니다.";
					$("#find_idSpan").text(strResult).css({"color":"#DC3545", "font-weight":"bold"});
				}
			}
		})
	}

	function findPw(){
		$.ajax({
			url:"${contextPath}/common/checkID",
			type:"post",
			data: {"member_id":$("#fc_id_input").val(), "${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success : function(data){
				if(!data.result){
					$.ajax({
						url:"${contextPath}/common/findAccount/userPw",
						type:"post",
						data : {"member_id":$("#fc_id_input").val(), "${_csrf.parameterName}":"${_csrf.token}"},
						dataType:"json",
						success : function(data){
							if(data.result){
								swal("임시 비밀번호가 발송되었습니다.");
							}else{
								swal("임시 비밀번호 발송 실패\n실패가 반복될 경우 관리자에 문의하세요.");
							}
						}				
					})
				}else{
					swal("아이디가 존재하지 않습니다.");
				}
				
			}
		})
	}
	
</script>
<title>아이디/비밀번호 찾기</title>
</head>
<body>
<div class="background-wrap">
		<video id="video-bg-elem" preload="auto" autoplay="true" loop="loop" muted="muted">
			<source src="${contextPath}/video/Sunset - 12591.mp4" type="video/mp4">
		</video>
</div>		
<div class="main-wrap">
	<div class="main-html">
		<span class="main-title">아이디/비밀번호 찾기</span>
		<div class = "findId-html">
			<div class="sub-title">아이디 찾기</div>
			<div>가입하실 때 등록한 이메일 주소를 입력하세요.</div><br><br>
			<div class="group">
				<label class="label">이메일 주소</label>
				<input type="text" class="input" id="fc_email_input">
			</div>
			<span id = "find_idSpan"></span><br><br>
			<div class="text-center">
				<input class="btn btn-primary" type="button" id="fc_id_button" value="아이디 찾기" onclick="findUserid()">
			</div><br><br>
		</div>	
	
		<div class = "findPw-html">
			<div class="sub-title">비밀번호 찾기</div>
			<div>회원 아이디를 입력하세요.<br><br>회원 정보의 이메일 주소로 임시 비밀번호가 발송됩니다.</div><br>
			<div class="group">
				<label class="label">아이디</label>
				<input type="text" class="input" id="fc_id_input">
			</div>
			<span id = "find_pwSpan"></span><br><br>
			<div class="text-center">
				<input class="btn btn-primary" type="button" id="fc_pw_button" value="비밀번호 찾기" onclick="findPw()">
			</div>
			<br><br>
		</div>
		<div class = "fc_bottom_buttons">
			<div class="text-center fc_bottom_button">
				<input class="btn btn-info" type="button" value="메인" onclick="location.href='main'">
			</div>
			<div class="text-center fc_bottom_button">
				<input class="btn btn-info" type="button" value="로그인" onclick="location.href='loginForm'">
			</div>
		</div>
	</div>
</div>	
</body>
</html>