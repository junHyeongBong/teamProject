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
<meta name="csrf_token" content="${_csrf.token}">
<title>SNS 회원 가입</title>
<link rel="stylesheet" href="${contextPath}/css/memberJoinSns.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/memberLogin.js"></script>
<script type="text/javascript">
	$(function(){
		if("${apiMemberInfo.member_gender}" == "F"){
			$("#member_gender_input").val("F");
		}		
	})
</script>
</head>
<body>

	<div class="background-wrap">
		<video id="video-bg-elem" preload="auto" autoplay="true" loop="loop" muted="muted">
			<source src="${contextPath}/video/Sunset - 12591.mp4" type="video/mp4">
		</video>
	</div>

	<div class="login-wrap">
					
		<div class="sign-up-htm">
			<label id="join_sns_title" class="tab">SNS 회원 가입</label>
			<form action="${contextPath}/common/join" name="frm" method="post" id="sns_joinForm">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="member_id" value="${apiMemberInfo.member_id}">
				<input type="hidden" name="member_type" value="${apiMemberInfo.member_type}">	
				<input type="hidden" name="member_email" value="${apiMemberInfo.member_email}">
				<input type="hidden" name="captchaKey" id="captchaKey" value="${captchaKey}">	
				<div class="group">
					<label for="join_nick_input" class="label">닉네임</label>
					<input id="join_nick_input" type="text" class="input" name="member_nick" value="<c:if test='${apiMemberInfo ne null}'>${apiMemberInfo.member_nick}</c:if>"><span id="nickSpan"></span>
				</div>
				<div class="group">
					<span id="join_error_msg" style="color:red">${msg}</span>
				</div>
				<div class="group btn-group btn-toggle member_gender_div">
					<label for="member_gender_div" class="label">성별</label>
					<input type="hidden" name="member_gender" id="member_gender_input">
					<c:choose>
						<c:when test="${apiMemberInfo.member_gender ne null}">
							<c:choose>
								<c:when test="${apiMemberInfo.member_gender eq 'F'}">
									<input type="button" name="M" class="btn btn-default gm" value="남자" id="member_gender_male">
									<input type="button" name="F" class="btn btn-primary active gf" value="여자" id="member_gender_female">
									<script>switch2Female();</script>
								</c:when>
								<c:otherwise>
									<input type="button" name="M" class="btn btn-primary active gm" value="남자" id="member_gender_male">
									<input type="button" name="F" class="btn btn-default gf" value="여자" id="member_gender_female">	
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<input type="button" name="M" class="btn btn-primary active gm" value="남자" id="member_gender_male">
							<input type="button" name="F" class="btn btn-default gf" value="여자" id="member_gender_female">	
						</c:otherwise>
					</c:choose>
				</div>
				<div class="group">
					<div id="captchaImageArea" class="text-center"><img src="${captchaImageUrl}" id="captchaImage"></div><div class="text-center"><input class="btn btn-danger" type="button" id="refCaptButton" value="이미지 새로고침" onclick="refreshCaptcha()"></div><br>
				</div>
				<div class="group">	
					<label class="label">자동가입문자</label>
					<div class="text-center"><input type="text" name="captchaInput" id="captcha_input" placeholder="이미지에 보이는 글자를 입력하세요." class="input"></div>
				</div>
				<div class="group text-center">
					<input type="submit" class="button" value="회원가입" id="snsSubmitButton">
				</div>
				
				<div class="foot-lnk">
					<label for="tab-1" onclick="location.href='${contextPath}/common/loginForm'">이미 회원이신가요?</label>
				</div>
				<div class="hr"></div>
			</form>
		</div>
		
		
		
		
	</div>
	

</body>
</html>