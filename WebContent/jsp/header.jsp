<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${contextPath}/js/sockjs.js"></script>
<script src="${contextPath}/js/stomp.js"></script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member_id" property="principal.username"/>
	<sec:authentication var="member_nick" property="principal.member_nick"/>
	<sec:authentication var="member_type" property="principal.member_type"/>
</sec:authorize>

<div class="headerDiv">
	<div class="headerLogo">
		<p>Travel is Fate</p>
	</div>
	<div class="headerNavi">
		<a href="main">홈</a>
		<a href="tripBoardWriteForm">여행 계획</a>
		<a href="tripBoardRecruitList">함께가요!</a>
		<a href="tripBoardBoolList">구경해요!</a>
		<c:if test="${!empty member_id}">
			<a onclick="myInfoShowHide()">${member_nick}</a>
			<input type="hidden" name="member_id" value="${member_id}">
		</c:if>
		<c:if test="${empty member_id}">
			<a href="loginForm">Login</a>
		</c:if>
	</div>
	<br>
	<div class="myInfo">
		<div class="alarmForm">
			<div id="msg_notify_div">
				쪽지 개수를 넣자
			</div>
			<div class="alarmImg">
				<img alt="알림" title="알림" onclick="" src="../img2/alarm.png">
			</div>
		</div>
		<div class="otherDiv">
			<img alt="쪽지" title="쪽지" onclick="openMessageBox('${member_id}')" src="../img2/message.png">
		</div>
		<div class="otherDiv">
			<img alt="개인정보" title="개인정보" onclick="location.href='./myPage'" src="../img2/user.png">
		</div>
		<div class="otherDiv">
			<img alt="로그아웃" title="로그아웃" onclick="location.href='./logout'" src="../img2/logout.png">
		</div>
	</div>
</div>