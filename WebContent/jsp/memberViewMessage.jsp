<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<sec:authentication var="member_id" property="principal.username"/>
<sec:authentication var="member_nick" property="principal.member_nick"/>
<c:choose>
	<c:when test="${param.eqm eq 'eqm'}">
		<c:set var="isReceiver" value = "false"></c:set>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${member_id eq message.message_receive_id}">
				<c:set var="isReceiver" value = "true"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="isReceiver" value = "false"></c:set>
			</c:otherwise>
		</c:choose>	
	</c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="csrf_token" content="${_csrf.token}">
<title>쪽지함</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>  
<script src="${contextPath}/js/memberMessage.js"></script>
<link rel="styleSheet" href="${contextPath }/css/memberViewMessage.css">

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
 	.messageViewMsg{display: inline-block;}
 	.messageViewBtmButton{display: inline-block;}
</style>
</head>
<body>
<div id="messageBoxWrapper">
	<div id="messageBoxSection">
		<div id="messageBoxHeaderDiv">
			<span class="messageBoxHeader" style="color: cornflowerblue;">
				<c:choose>
					<c:when test="${isReceiver}">
						받은 쪽지함
					</c:when>
					<c:otherwise>
						보낸 쪽지함
					</c:otherwise>
				</c:choose>
			</span>
			<span class="messageBoxHeader" style="float: right;">
				<c:choose>
					<c:when test="${isReceiver}">
						안읽은 쪽지 ${viewDataReceive.noReadCount} / 전체 ${viewDataReceive.totalCount}
					</c:when>
					<c:otherwise>
						안읽은 쪽지 ${viewDataSend.noReadCount} / 전체 ${viewDataSend.totalCount}
					</c:otherwise>
				</c:choose>
			</span>
		</div>
		<div class="separator-2"></div>
		
		<div id="messageBoxViewMsgDiv">
			<div class="messageBoxViewMsgBlock">
				<c:choose>
					<c:when test="${isReceiver}">
						<div class="messageViewMsg human">보낸사람</div>
						<div class="messageViewMsg sender">${message.message_send_nick}</div>
					</c:when>
					<c:otherwise>
						<div class="messageViewMsg human">받는사람</div>
						<div class="messageViewMsg sender">${message.message_receive_nick}</div>
					</c:otherwise>
				</c:choose>
			
				
			</div>
			<div class="messageBoxViewMsgBlock">
				<div class="messageViewMsg human">제목</div>
				<div class="messageViewMsg title">${message.message_title}</div>
			</div>
			<div class="messageBoxViewMsgBlock">
				<div class="messageViewMsg human">날짜</div>
				<div class="messageViewMsg date"><fmt:formatDate value="${message.message_writedate}" type="both" pattern="yyyy년 MM월 dd일 HH시 mm분"/></div>
			</div>
			<div class="messageBoxViewMsgBlock">
				<div class="messageViewMsg human">내용</div>
				<div class="messageViewMsg content">${message.message_content}</div>
			</div>
			<div align="center">
				<c:if test="${isReceiver}">
					<form class="messageViewBtmButton" method="post" action="${contextPath}/common/newMessage">
						<input type="hidden" name="message_receive_id" value="${message.message_send_id}">
						<input type="hidden" name="message_receive_nick" value="${message.message_send_nick}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<input type="submit" value="답장" class="reply">
					</form>
				</c:if>
				<c:choose>
					<c:when test="${isReceiver}">	
						<input type="button" class="messageViewBtmButton deleteButton" value="삭제" onclick="delMessage('receive','${message.message_num}','${message.message_receive_id}')">
					</c:when>
					<c:otherwise>
						<input type="button" class="messageViewBtmButton senddeleteButton deleteButton" value="삭제" onclick="delMessage('send','${message.message_num}','${message.message_send_id}')">
					</c:otherwise>
				</c:choose>
				<input type="button" class="messageViewBtmButton list" value="목록">
			</div>
		</div>
		
		<c:choose>
			<c:when test="${isReceiver}">
				<jsp:include page="memberReceiveMsgList.jsp">
					<jsp:param value="${contextPath}" name="contextPath"/>
					<jsp:param value="receive" name="delChkedMsgParam"/>
				</jsp:include>
			</c:when>
			<c:otherwise>
				<jsp:include page="memberSendMsgList.jsp">
					<jsp:param value="${contextPath}" name="contextPath"/>
					<jsp:param value="send" name="delChkedMsgParam"/>
				</jsp:include>
			</c:otherwise>
		</c:choose>

	</div>
</div>
</body>
</html>