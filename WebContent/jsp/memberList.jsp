<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>아이디</th>
			<th>타입</th>
			<th>이메일</th>
			<th>닉네임</th>
			<th>성별</th>
			<th>가입일</th>
		</tr>
		<c:forEach items="${memberList}" var="member">
			<tr>
			<td>${member.member_id}</td>
			<td>${member.member_type}</td>
			<td>${member.member_email}</td>
			<td>${member.member_nick}</td>
			<td>${member.member_gender}</td>
			<td>${member.member_regdate}</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>