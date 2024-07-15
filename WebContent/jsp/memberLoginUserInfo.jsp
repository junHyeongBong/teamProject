<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인</title>
	<sec:authentication var="user" property="principal.username"/>
	<sec:authentication var="nick" property="principal.member_nick"/>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body>
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${empty userid}"> --%>
<%-- 			<c:redirect url="loginForm"></c:redirect>	 --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 			${userid}<br> --%>
<!-- 			<input type="button" value="회원목록 보기" onclick="location.href='memberList'"> -->
<!-- 			<input type="button" value="회원정보 수정" onclick="location.href='updateForm'"> -->
<!-- 			<br> -->
<!-- 			<input type="button" value="로그아웃" onclick="location.href='logout'"> -->
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>


	${user}<br>
	${nick}<br>
<%-- 	<p>principal : <sec:authentication property="principal"/></p> --%>
<%-- 	<p>principal.username : <sec:authentication property="principal.username"/></p> --%>
<%-- 	<p>principal.password : <sec:authentication property="principal.password"/></p> --%>
<%-- 	<p>principal.nick : <sec:authentication property="principal.member_nick"/></p> --%>
<%-- 	<p>principal.enabled : <sec:authentication property="principal.enabled"/></p> --%>
<%-- 	<p>principal.accountNonExpired : <sec:authentication property="principal.accountNonExpired"/></p> --%>
	
	
	
	<input type="button" value="회원목록 보기" onclick="location.href='memberList'">
	<input type="button" value="마이페이지" onclick="location.href='myPage'">
	<input type="button" value="테스트보드" onclick="location.href='testBoard'">
	<br>
<!-- 	<input type="button" value="로그아웃" onclick="location.href='logout'"> -->
	<form id="logoutForm" action="logout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<input type="submit" value="로그아웃"> 
	</form>	
</body>
</html>