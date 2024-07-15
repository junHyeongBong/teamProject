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
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/memberMessage.js"></script>

<!-- css -->
<link rel="stylesheet" href="${contextPath }/css/memberMsgFriend.css">

<style type="text/css">
	.tabs{padding-left: 0px;}
	.tabs li{
		display: inline-block;
	}
/* 	.messageBoxListBlock{display: inline-block;} */
 	.messageBoxListTH{display: inline-block;} 
 	.messageBoxListTD{display: inline-block;}
</style>
<script type="text/javascript">
</script>
<link rel="styleSheet" href="${contextPath }/css/memberMsgFriend.css">
</head>
<body>
<div id="messageBoxWrapper">
	<div id="messageBoxSection">
		<div id="messageBoxTitleDiv">
			<span class="messageBoxTitle frindTitle">친구 목록&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="messageBoxTitle" style="float: right;">등록된 친구 ${viewData.totalCount}</span>
		</div>
		<div class="separator-2"></div>
		<div id="messageBoxListDiv">
			<div id="messageBoxtab">
				<ul class="tabs">
					<div class="svg-wrapper">
				      <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
				        <rect id="shape" height="40" width="150" />
				        <div id="text">
				          <a href="${contextPath}/common/receiveMsgBox"><span class="spot"></span>받은 쪽지</a>
				        </div>
				      </svg>
				    </div>
				    <div class="svg-wrapper">
				      <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
				        <rect id="shape" height="40" width="150" />
				        <div id="text">
				          <a href="${contextPath}/common/sendMsgBox"><span>보낸 쪽지</span></a>
				        </div>
				      </svg>
				    </div>
				    <div class="svg-wrapper">
				      <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
				        <rect id="shape" height="40" width="150" />
				        <div id="text">
				          <a href="${contextPath}/common/msgFriend"><span>친구 목록</span></a>
				        </div>
				      </svg>
				    </div>	
				    <div class="svg-wrapper">
				      <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
				        <rect id="shape" height="40" width="150" />
				        <div id="text">
				          <a href="${contextPath}/common/msgIgnored"><span>차단 목록</span></a>
				        </div>
				      </svg>
				    </div>			
				</ul>
			</div>
			<div id="messageBoxList">
				<div class="messageBoxListBlock">
<!-- 					<div class="messageBoxListTH"><input type="checkbox" onclick="reverseChecked()"></div> -->
						<label class="container">
							<input type="checkbox" onclick="reverseChecked()"><span class="checkmark" style="margin-top: 6px;"></span>
						</label>
						
					<div class="messageBoxListTH" style="margin-left: 32px;">닉네임</div>	
				</div>
				<c:forEach items="${viewData.msgFriendList}" var="member">
					<div class="messageBoxListBlock">
						<div class="messageBoxListTD"><input type="checkbox" name="memNo" value="${member.member_id}"></div>
<%-- 						<div class="messageBoxListTD"><a href="${contextPath}/common/viewMessage?num=${message.message_num}&page=${viewData.currentPage}">${message.message_title}</a></div> --%>
						<div class="messageBoxListTD">${member.member_nick}</div>
<%-- 						<div class="messageBoxListTD"><fmt:formatDate value="${message.message_writedate}" type="both" pattern="MM/dd"/></div> --%>
					</div>
				</c:forEach>
				<div class="messageBoxListBlock">
					<input type="button" class="delete" value="삭제" onclick="delCheckedRelation('${member_id}')"> 
				</div>
				<div class="messageBoxListBlock">
					<c:if test="${viewData.startPage !=1 }">
						<a href = "${contextPath}/common/receiveMsgBox?page=1">[처음]</a>
						<a href = "${contextPath}/common/receiveMsgBox?page=${viewData.startPage-1}">[이전]</a>
					</c:if>
				<c:forEach var="pageNum" begin="${viewData.startPage}" 
					end="${viewData.endPage < viewData.pageTotalCount ? viewData.endPage : viewData.pageTotalCount}">
					<c:choose>
						<c:when test="${pageNum == viewData.currentPage}">
							<b>[${pageNum}]</b>
						</c:when>
						<c:otherwise>
							<a href="${contextPath}/common/receiveMsgBox?page=${pageNum}">[${pageNum}]</a>	
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test = "${viewData.endPage < viewData.pageTotalCount}">
					<a href = "${contextPath}/common/receiveMsgBox?page=${viewData.endPage+1}">[다음]</a>
					<a href = "${contextPath}/common/receiveMsgBox?page=${viewData.pageTotalCount}">[마지막]</a>
				</c:if>	
				</div>
			</div>	
		
		</div>














	</div>
</div>
</body>
</html>