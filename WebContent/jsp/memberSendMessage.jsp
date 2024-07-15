<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<sec:authentication var="member_id" property="principal.username"/>
<sec:authentication var="member_nick" property="principal.member_nick"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="csrf_token" content="${_csrf.token}">
<title>쪽지함</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>  
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/memberMessage.js"></script>

<link rel="styleSheet" href="${contextPath }/css/memberSendMessage.css">

<!-- 나눔고딕체 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<style type="text/css">
	.tabs{padding-left: 0px;}
	.tabs li{
		display: inline-block;
	}
/* 	.messageBoxListBlock{display: inline-block;} */
 	.messageBoxListTH{display: inline-block;} 
 	.messageBoxListTD{display: inline-block;}
</style>
</head>
<body>
<div id="messageBoxWrapper">
	<div id="messageBoxSection">
		<div id="messageBoxTitleDiv">
			<span class="messageBoxTitle sendBox">보낸 쪽지함&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="messageBoxTitle" style="float: right;">안읽은 쪽지 ${viewDataSend.noReadCount} / 전체  ${viewDataSend.totalCount}</span>
		</div>
		<div class="separator-2"></div>
		<jsp:include page="memberSendMsgList.jsp">
			<jsp:param value="${contextPath}" name="contextPath"/>
			<jsp:param value="send" name="delChkedMsgParam"/>
		</jsp:include>
	</div>
</div>
</body>
</html>