<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<sec:authentication var="member_id" property="principal.username"/>
<sec:authentication var="member_nick" property="principal.member_nick"/>
<sec:authentication var="member_type" property="principal.member_type"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="csrf_token" content="${_csrf.token}">
<title>쪽지 보내기</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<style type="text/css">
	.mess_send_inline1{display: inline;}
	#message_title_input{width:404px;}
</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/memberMessage.js"></script>
<script src="${contextPath}/js/sockjs.js"></script>
<script src="${contextPath}/js/stomp.js"></script>
<!-- css -->
<link rel="stylesheet" href="${contextPath }/css/memberNewMessage.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript">
	$(function(){
		connect();	
	})
	
	var sock;
	var stompClient = null;
	
	function connect(){
		sock = new SockJS("http://localhost:8081/Project_TF/msgConnect");
// 		sock = new SockJS("http://192.168.0.68:8081/Project_TF/msgConnect");
		stompClient = Stomp.over(sock);
		stompClient.connect({},function(){
			stompClient.subscribe("/topic/message/${member_id}",function(msg){
				if(msg.body == "msgNotifyReq"){
					$("#msg_notify_div").show("slow");
					var msgNotifySound = new Audio("${contextPath}/audio/msg_tempAudio.mp3");
					msgNotifySound.play();
				}
			});
		})
	}
</script>
</head>
<body>
	<h3 align="center">쪽지 보내기</h3>
	<div class="mess_send_inline1 title">받는 사람</div> : <div class="mess_send_inline1">${message_receive_nick}</div>
	<br>
	<br>
	<div>
		<div><input type="text" class="w3-input" id="message_title_input" placeholder="제목을 입력하세요."></div><br>
		<div><textarea class="w3-input" cols="40" rows="15" id="message_content_input" placeholder="내용을 입력하세요."></textarea></div>
		<input type="button" class="back" value="뒤로가기" onclick="location.href='${contextPath}/common/receiveMsgBox'">
		<input type="button" class="submit" value="보내기" onclick="sendMessage('${member_id}','${member_nick}','${message_receive_id}','${message_receive_nick}')">			
	</div>
</body>
</html>