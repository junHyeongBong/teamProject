<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<sec:authentication var="member_id" property="principal.username"/>
<sec:authentication var="member_nick" property="principal.member_nick"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"> -->
<style type="text/css">
.dropdown-menu .divider {margin: 1px 0;}
.dropdown-menu {padding: 0px 0;}
#mainButton {text-align: center;}
 #msg_notify_div{ 
 	top: 80%; 
 	left: 80%;		 
  	display: none;
 	width: 180px;  
 	height: 110px; 
 	background-color: #f5e28c; 
 	position: absolute; 
 	border:1px solid #8c8c8c; 
 	text-align: center; 
 	z-index: 500; 
 } 

 #msg_notify_div:hover{ 
 	box-shadow:0 0 0 3px rgba(30,144,255,0.5) inset; 
 } 


</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>  
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<script src="${contextPath}/js/sockjs.js"></script>
<script src="${contextPath}/js/stomp.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	$(function(){
		connect();
		
		$(document).on('click', "#mainButton", mainBtnClick());
		
	}) // window onload end.
	
	var sock;
	var stompClient = null;
	
	function connect(){
		sock = new SockJS("http://localhost:8081/Project_TF/msgConnect");
		stompClient = Stomp.over(sock);
		stompClient.connect({},function(){
			stompClient.subscribe("/topic/message/${member_id}",function(msg){
				if(msg.body == "msgNotifyReq"){
					$(".alarmForm").show("slow");
					var msgNotifySound = new Audio("${contextPath}/audio/msg_tempAudio.mp3");
					msgNotifySound.play();
				}
			});
		})
	}
	
	function mainBtnClick(){
		return function(){
			openMsgBox();
		}
	}
	
	function checkNotify(){
		$("#msg_notify_div").hide("slow");
		openMsgBox();
	}
	
	function openMsgBox(){
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
	}
	
	function addRelation(id,relation){
		if(id=="${member.member_id}"){
			swal("본인 아이디를 친구추가나 차단할 수 없습니다.");
			return false;
		}
		$.ajax({
			url:"${contextPath}/common/addRelation",
			type:"post",
			data : {"member_id":"${member_id}", "relation_id":id, "member_relation":relation, "${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success : function(data){
				if(data.result){
					if(relation == "friend"){
						swal("친구 등록 성공");
					}else{
						swal("차단 등록 완료");
					}
				}else{
					if(data.checkRela == null){
						swal("등록 실패");	
					}else{
						if(data.checkRela == "friend"){
							if(relation=="friend"){
								swal("이미 친구로 등록되어 있습니다.");
							}else{
								swal("차단하려면 먼저 친구 삭제를 해야합니다.");
							}
						}else{
							if(relation=="friend"){
								swal("친구로 등록하려면 차단을 먼저 해제하세요.")	
							}else{
								swal("이미 차단되어 있습니다.");
							}
						}
					}
				}
			}
		})		
	}
	
	function newMessage(receive_id, receive_nick){
		var form = $("<form>");
		form.attr("id", "newMessageForm")
		form.attr("method", "post");
		form.attr("action", "${contextPath}/common/newMessage");
		form.attr("target", "newMessage");
		$(document.body).append(form);
		
		var input1 = $("<input>");
		input1.attr("type", "hidden");
		input1.attr("name", "message_receive_id");
		input1.attr("value", receive_id);
		form.append(input1);
		
		var input2 = $("<input>");
		input2.attr("type", "hidden");
		input2.attr("name", "message_receive_nick");
		input2.attr("value", receive_nick);
		form.append(input2);
		
		var input3 = $("<input>");
		input3.attr("type", "hidden");
		input3.attr("name", "${_csrf.parameterName}");
		input3.attr("value", "${_csrf.token}");
		form.append(input3);
		
		window.open("", "newMessage", "width=441 height=538");
		$("#newMessageForm").submit();
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 테스트</title>
</head>
<body>
<div class="container">
	<h2>회원정보 테스트 임시 페이지</h2>
<!-- 	<p>css는 정말 토할것 같군요.</p> -->
	<div id="mainButton" class="dropdown">
		<button class="btn btn-default" type="button">${member_id}<br>${member_nick}
		</button>
	</div><br>
	
	<div class="dropdown">
		<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">testman</button>
<!-- 		<span class="caret"></span> -->

		<ul class="dropdown-menu">
			<li><a href="">ID: tester</a></li>
			<li class="divider"></li>
			<li id="testLi"><a href="" onclick="newMessage('tester','testman')">쪽지 보내기</a></li>
			<li class="divider"></li>
			<li><a href="">작성글 검색</a></li>
			<li class="divider"></li>
			<li><a href="" onclick="addRelation('tester','friend')">친구 추가</a></li>
			<li class="divider"></li>
			<li><a href="" onclick="addRelation('tester','ignored')">차단</a></li>
		</ul>
	</div><br><br><br><br><br><br><br><br>
	
	<div class="dropdown">
	<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">임꺽정
	</button>
	<ul class="dropdown-menu">
		<li><a href="">ID: lim1</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="newMessage('lim1','임꺽정')">쪽지 보내기</a></li>
		<li class="divider"></li>
		<li><a href="">작성글 검색</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('lim1','friend')">친구 추가</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('lim1','ignored')">차단</a></li>
	</ul>
	</div><br><br><br><br><br><br><br><br>
	
	<div class="dropdown">
	<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">홍길동
	</button>
	<ul class="dropdown-menu">
		<li><a href="">ID: hong1</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="newMessage('hong1','홍길동')">쪽지 보내기</a></li>
		<li class="divider"></li>
		<li><a href="">작성글 검색</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('hong1','friend')">친구 추가</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('hong1','ignored')">차단</a></li>
	</ul>
	</div><br><br><br><br><br><br><br><br>
	
	<div class="dropdown">
	<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">카카오회원
	</button>
	<ul class="dropdown-menu">
		<li><a href="">ID: Kakao 회원</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="newMessage('903844717@kakao','01036699205')">쪽지 보내기</a></li>
		<li class="divider"></li>
		<li><a href="">작성글 검색</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('903844717@kakao','friend')">친구 추가</a></li>
		<li class="divider"></li>
		<li><a href="" onclick="addRelation('903844717@kakao','ignored')">차단</a></li>
	</ul>
	</div>
	    
	<div id="msg_notify_div" onclick="checkNotify()">
		<br>
		<span class="ab"><b>${member_nick} 님</b><br><br>
			  쪽지가 도착했습니다.
		</span>
	</div>
</div>
</body>
</html>