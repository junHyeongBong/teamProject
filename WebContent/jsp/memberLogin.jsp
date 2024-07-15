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
<title>로그인</title>
<link rel="stylesheet" href="${contextPath}/css/memberLogin.css">
<link rel="stylesheet" href="${contextPath}/css/bootstrap-msg-0.4.0.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/memberLogin.js"></script>
<script src="${contextPath}/js/bootstrap-msg-0.4.0.min.js"></script>
</head>
<body>

	<div class="background-wrap">
		<video id="video-bg-elem" preload="auto" autoplay="true" loop="loop" muted="muted">
			<source src="${contextPath}/video/Sunset - 12591.mp4" type="video/mp4">
<%-- 			<source src="${contextPath }/video/Beetle-Nut-Trees.mp4" type="video/mp4"> --%>
		</video>
	</div>

  <div class="login-wrap">
	<div class="login-html">	
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked="checked"><label for="tab-1" class="tab">로그인</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
				
	<div class="login-form">
	<c:url value="common/login" var="loginUrl"/>
		<form action="${contextPath}/${loginUrl}" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<!-- 로그인폼 -->
			<input type="hidden" name="what" value="login">
			<div class="sign-in-htm">
				<div class="group">
					<label for="login_id_input" class="label">아이디</label>
					<input type="text" class="input" name="member_id" id="login_id_input">
				</div>
				<div class="group">
					<label for="pass" class="label">비밀번호</label>
					<input id="login_pw_input" type="password" class="input" data-type="password" name="member_pw" id="login_pw_input">
				</div>
				<div class="group">
					<input id="check" type="checkbox" class="check" checked>
					<label for="check"><span class="icon"></span> 로그인 정보 저장</label>
				</div>
				<div class="group">
					<input type="submit" class="button" value="로그인" id="loginButton">
				</div>
				<div class="hr"></div>
				<div class="group text-center">
						<c:if test="${param.error != null }">
							<div>
								<p style="color: red">아이디 또는 비밀번호를 확인하세요.</p>
							</div>
						</c:if>
						<c:if test="${param.logout != null }">
							<div>
								<p style="color: red">로그아웃 되었습니다.</p>
							</div>
						</c:if>
						<c:if test="${param.join != null }">
							<div>
								<p style="color: blue">회원가입 성공</p>
								<p>${msg}</p>
							</div>
						</c:if>
						<c:if test="${param.confirm eq 'true' }">
							<div>
								<p style="color: blue">이메일 인증 성공</p>
								<p>${msg}</p>
							</div>
						</c:if>
						<c:if test="${param.confirm eq 'false' }">
							<div>
								<p style="color: red">이메일 인증 실패</p>
								<p>${msg}</p>
							</div>
						</c:if>
						<c:if test="${param.regError eq 'true' }">
							<div>
								<p style="color: red">회원 가입 실패, 가입을 다시 진행하세요.</p>
								<p>${msg}</p>
							</div>
						</c:if>
					</div>
				<div class="foot-lnk">
					<a href="${contextPath}/common/findAccount">아이디 / 비밀번호 찾기</a>
					<br><br><br><br>
					<a href="../common/main">메인</a>
				</div>
				<div class="group social">
					<div class="btn btn-lg btn-google btn-block text-uppercase" type="submit" onclick="location.href='${contextPath}/common/google'">
						<div class="google_small_icon"><img class="google_small_icon_img" src="${contextPath}/img/google_small_icon.jpg"></div><div class="googleL">구글 아이디로 로그인</div>
					</div>
<!--               		<button class="btn btn-lg btn-facebook btn-block text-uppercase" type="submit"><i class="fab fa-facebook-f mr-2"></i> 페이스북으로 로그인</button> -->	
					<div class="btn btn-lg btn-block naver" onclick="location.href='${contextPath}/common/naver'"><span class="naverFont"><img class="naverlogin" src="${contextPath }/img/naver.png">네이버 아이디로 로그인</span></div>
              		<div class="btn btn-lg btn-block kakao" onclick="location.href='${contextPath}/common/kakao'"></div>
				</div>
			</div>
		</form>

	

					
			<!-- 조인폼 -->
			<div class="sign-up-htm">
			<form action="join" name="frm" method="post" id="joinForm">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<input type="hidden" name="member_type" value="normal">
			<input type="hidden" name="captchaKey" id="captchaKey" value="${captchaKey}">	
				<div class="group">
					<label for="join_id_input" class="label">아이디</label>
					<input id="join_id_input" type="text" class="input" name="member_id" value="<c:if test='${memberInput ne null}'>${memberInput.member_id}</c:if>"><span id="idSpan"></span>
				</div>
				<div class="group">
					<label for="join_pw_input" class="label">비밀번호</label>
					<input id="join_pw_input" type="password" class="input" data-type="password" name="member_pw"><span id="pwSpan"></span>
				</div>
				<div class="group">
					<label for="join_pw_check" class="label">비밀번호 확인</label>
					<input id="join_pw_check" type="password" class="input" data-type="password" name="member_pw_check"><span id="pwCheckSpan"></span>
				</div>
				<div class="group">
					<label for="join_email_input" class="label">이메일 주소</label>
					<input id="join_email_input" type="text" class="input" name="member_email" value="<c:if test='${memberInput ne null}'>${memberInput.member_email}</c:if>"><span id="emailSpan"></span>
				</div>
				<div class="group">
					<label for="join_nick_input" class="label">닉네임</label>
					<input id="join_nick_input" type="text" class="input" name="member_nick" value="<c:if test='${memberInput ne null}'>${memberInput.member_nick}</c:if>"><span id="nickSpan"></span>
				</div>
				<div class="group">
					<span id="join_error_msg" style="color:red">${msg}</span>
				</div>
				<div class="group btn-group btn-toggle member_gender_div">
					<label for="member_gender_div" class="label">성별</label>
					<input type="hidden" name="member_gender" id="member_gender_input">
					<input type="button" name="M" class="btn btn-primary active gm" value="남자" id="member_gender_male">
					<input type="button" name="F" class="btn btn-default gf" value="여자" id="member_gender_female">
				</div>
				<div class="group">
					<div id="captchaImageArea" class="text-center"><img src="${captchaImageUrl}" id="captchaImage"></div><div class="text-center"><input class="btn btn-danger" type="button" id="refCaptButton" value="이미지 새로고침" onclick="refreshCaptcha()"></div><br>
				</div>
				<div class="group">	
					<label class="label">자동가입문자</label>
					<div class="text-center"><input type="text" name="captchaInput" id="captcha_input" placeholder="이미지에 보이는 글자를 입력하세요." class="input"></div>
				</div>
				<div class="group text-center">
					<input type="submit" class="button" value="회원가입" id="submitButton">
				</div>
				
				<div class="foot-lnk">
					<label for="tab-1">이미 회원이신가요?</label>
				</div>
				</form>
			</div>
		</div>	
	</div>		
</div>
	

</body>
</html>