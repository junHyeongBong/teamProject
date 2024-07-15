<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script -->
<!--   src="https://code.jquery.com/jquery-3.3.1.min.js" -->
<!--   integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" -->
<!--   crossorigin="anonymous"></script> -->
  
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>   -->

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


<link rel="styleSheet" href="${contextPath }/css/memberReceiveMsgList.css">
<!-- 나눔고딕체 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>


<title>쪽지함</title>
</head>
<body>
	<c:set var="contextPath" value="${param.contextPath}"></c:set>
		<div id="messageBoxListDiv">
			<div id="messageBoxtab">
				<ul class="tabs">
<!-- 					<li class="tabMenu1"> -->
<%-- 						<a href="${contextPath}/common/receiveMsgBox"><span>받은 쪽지</span></a> --%>
<!-- 					</li> -->
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
				    
<!-- 					<li class="tabMenu2"> -->
<%-- 						<a href="${contextPath}/common/sendMsgBox"><span>보낸 쪽지</span></a> --%>
<!-- 					</li>	 -->
<!-- 					<li class="tabMenu3"> -->
<%-- 						<a href="${contextPath}/common/msgFriend"><span>친구 목록</span></a> --%>
<!-- 					</li>	 -->
<!-- 					<li class="tabMenu4"> -->
<%-- 						<a href="${contextPath}/common/msgIgnored"><span>차단 목록</span></a> --%>
<!-- 					</li>	 -->
				</ul>
			</div>
			<div id="messageBoxList">
				<div class="messageBoxListBlock">
					<div class="row">
						<div class="messageBoxListTH" style="float: left; width: 22%;">
							<label class="container">
								<input type="checkbox" onclick="reverseChecked()"><span class="checkmark" style="margin-left: 15px; margin-top: 6px;"></span>
							</label>
						</div>
<!-- 						<div class="messageBoxListTH" style="margin-left: 87px;"><b>제목</b></div>	 -->
<!-- 						<div class="messageBoxListTH" style="margin-left: 81px;"><b>보낸 사람</b></div> -->
<!-- 						<div class="messageBoxListTH" style="margin-left: 48px;"><b>날짜</b></div> -->
							<div class="messageBoxListTH" style="float: left; width: 37%;"><b>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></div>	
							<div class="messageBoxListTH" style="float: left; width: 24%;"><b>보낸 사람</b></div>
							<div class="messageBoxListTH" style="float: left; width: 11%; text-align: center;"><b>날짜</b></div>
					</div>	
				</div>
				<c:forEach items="${viewDataReceive.receiveMsgList}" var="message">
					<div class="messageBoxListBlock">
<%-- 						<div class="messageBoxListTD"><input type="checkbox" name="msgNo" value="${message.message_num}"></div> --%>
						<div class="messageBoxListTD" style="width: 15%; float: left; margin-top: 6px;">
							<label class="container">
								<input type="checkbox" name='msgNo' value="${message.message_num}">
								<span class="checkmark"></span>
							</label>
						</div>
						<c:choose>
							<c:when test="${message.message_isread eq 'N'}">
								<div class="messageBoxListTD title" style="float: left; width: 37%; text-align: center;">
									<a href="${contextPath}/common/viewMessage?num=${message.message_num}&page=${viewDataReceive.currentPage}" data-toggle="tooltip" data-placement="right" title="안 읽음">
									<b style="color: red;">${message.message_title}</b></a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="messageBoxListTD title" style="float: left; width: 37%; text-align: center;">
									<a href="${contextPath}/common/viewMessage?num=${message.message_num}&page=${viewDataReceive.currentPage}">
									${message.message_title}</a>
								</div>
							</c:otherwise>	
						</c:choose>
						<div class="messageBoxListTD send_nick" style="float: left; width: 30%; text-align: center;">${message.message_send_nick}</div>
						<div class="messageBoxListTD write_date" style="float: left; text-align: center; width: 18%;"><fmt:formatDate value="${message.message_writedate}" type="both" pattern="MM/dd"/></div>
					</div>
				</c:forEach>
				<div class="messageBoxListBlock">
					<input type="button" value="삭제" class="deleteMessage" onclick="delCheckedMessage('${param.delChkedMsgParam}')"> 
				</div>
				<div class="messageBoxListBlock pageNum">
					<c:if test="${viewDataReceive.startPage !=1 }">
						<a href = "${contextPath}/common/receiveMsgBox?page=1
							<c:if test="${viewDataReceive.msg_search_type !=null}">&msg_search_type=${viewDataReceive.msg_search_type}</c:if>
							<c:if test="${viewDataReceive.msg_search_keyword !=null}">&msg_search_keyword=${viewDataReceive.msg_search_keyword}</c:if>
						">[처음]</a>
						<a href = "${contextPath}/common/receiveMsgBox?page=${viewDataReceive.startPage-1}
							<c:if test="${viewDataReceive.msg_search_type !=null}">&msg_search_type=${viewDataReceive.msg_search_type}</c:if>
							<c:if test="${viewDataReceive.msg_search_keyword !=null}">&msg_search_keyword=${viewDataReceive.msg_search_keyword}</c:if>
						">[이전]</a>
					</c:if>
				<c:forEach var="pageNum" begin="${viewDataReceive.startPage}" 
					end="${viewDataReceive.endPage < viewDataReceive.pageTotalCount ? viewDataReceive.endPage : viewDataReceive.pageTotalCount}">
					<c:choose>
						<c:when test="${pageNum == viewDataReceive.currentPage}">
							<b>[${pageNum}]</b>
						</c:when>
						<c:otherwise>
							<a href="${contextPath}/common/receiveMsgBox?page=${pageNum}
								<c:if test="${viewDataReceive.msg_search_type !=null}">&msg_search_type=${viewDataReceive.msg_search_type}</c:if>
								<c:if test="${viewDataReceive.msg_search_keyword !=null}">&msg_search_keyword=${viewDataReceive.msg_search_keyword}</c:if>
							">[${pageNum}]</a>	
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test = "${viewDataReceive.endPage < viewDataReceive.pageTotalCount}">
					<a href = "${contextPath}/common/receiveMsgBox?page=${viewDataReceive.endPage+1}
						<c:if test="${viewDataReceive.msg_search_type !=null}">&msg_search_type=${viewDataReceive.msg_search_type}</c:if>
						<c:if test="${viewDataReceive.msg_search_keyword !=null}">&msg_search_keyword=${viewDataReceive.msg_search_keyword}</c:if>
					">[다음]</a>
					<a href = "${contextPath}/common/receiveMsgBox?page=${viewDataReceive.pageTotalCount}
						<c:if test="${viewDataReceive.msg_search_type !=null}">&msg_search_type=${viewDataReceive.msg_search_type}</c:if>
						<c:if test="${viewDataReceive.msg_search_keyword !=null}">&msg_search_keyword=${viewDataReceive.msg_search_keyword}</c:if>
					">[마지막]</a>
				</c:if>	
				</div>
				<div class="messageBoxListBlock">
					<form name="search" action="${contextPath}/common/receiveMsgBox" class="searchBar">
						<select name="msg_search_type" class="searchSelect">
							<option value="titleCont" 
								<c:if test="${viewDataReceive.msg_search_type eq null || viewDataReceive.msg_search_type eq 'titleCont'}">
									selected="selected"
								</c:if>
							>제목+내용</option>	
							<option value="title"
								<c:if test="${viewDataReceive.msg_search_type eq 'title'}">
									selected="selected"
								</c:if>
							>제목만</option>
							<option value="content"
								<c:if test="${viewDataReceive.msg_search_type eq 'content'}">
									selected="selected"
								</c:if>
							>내용만</option>
							<option value="nick"
								<c:if test="${viewDataReceive.msg_search_type eq 'nick'}">
									selected="selected"
								</c:if>
							>닉네임으로</option>
						</select>
						<input type="text" name="msg_search_keyword" style="width:130px;" value="${viewDataReceive.msg_search_keyword}">
						<input type="submit" value="검색" class="search">
					</form>
				</div>
			</div>	
		</div>
</body>
</html>