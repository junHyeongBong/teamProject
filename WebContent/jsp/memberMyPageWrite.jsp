<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내가 쓴 글 목록 페이지입니다.</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
 <!-- 3개 있어야됨 --> 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- css -->
<link rel="stylesheet" href="${contextPath }/css/memberMyPageWrite.css">

<!-- 나눔고딕체 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">


$(function(){
	$(document).on('click', "#messageButton", function(){
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
	})
});

function myTripReply(){
	$("#Reply").submit();	
}

function myTripPage(){
	$("form[name='abc']").submit();
}


function reset(){
	$("#leavePwInput").val("");
}


function leaveMember(){
	
	$.ajax({
		url		: "${contextPath}/common/checkPw",
		type	: "post",
		data 	: {"member_id":"${member.member_id}","${_csrf.parameterName}":"${_csrf.token}","member_pw":$("#leavePwInput").val()},
		dataType : "json",
		success : function(data){
			if(data.result){
				$.ajax({
					url		:	"${contextPath}/common/myPage/leave",
					type	:	"post",
					data	:	{"member_id":"${member.member_id}","${_csrf.parameterName}":"${_csrf.token}"},
					success	:	function(data){
						swal("탈퇴되었습니다.").then(function() {
							location.href = "${contextPath}/common/opening";
						});
					}
				});
			}else{
				swal("비밀번호가 틀렸습니다.");
			}
		}
	});
}
</script>
</head>
<body>

<section class="main-container">
		<div class="container">
			<div class="row">
				<div class="main col-lg-8 order-lg-2 ml-xl-auto" id="myPageMainFrame">
					<div class="wrap">
	
						<div class="block clearfix">
							
								
							<h3 class="title">내가 쓴 글</h3>
						</div>
						
						<div class="separator-2"></div>
						
						
						
						<table class="table table-striped text-center" style="text-alind:center; boarder: 1px solid #ff0000">
							<thead>
								<tr>
									<th style="background-color: lightpink; text-align: center;">게시물번호</th>
									<th style="background-color: #58D3F7; text-align: center;">제목</th>
									<th style="background-color: #58D3F7; text-align: center;">작성자</th>
									<th style="background-color: #58D3F7; text-align: center;">조회수</th>
									<th style="background-color: #58D3F7; text-align: center;">추천수</th>
									<th style="background-color: #58D3F7; text-align: center;">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${viewData }" var="board" varStatus="count">
									<tr>
										<td>${board.trip_board_num }</td>
										<td>
											<a href="../common/readOneTripBoard?pageType=bool&trip_board_num=${board.trip_board_num}">${board.trip_board_title}</a>
										</td>
										<td>${board.member_nick }</td>
										<td>${board.trip_board_hits }</td>
										<td>${board.trip_board_recommend }</td>
										<td><fmt:formatDate value="${board.trip_board_writedate}" type="both" pattern="yyyy.MM.dd HH:mm:ss"/></td>
									</tr>
								</c:forEach>
							</tbody>	
						</table>
					</div>	
				</div>
				
				
				<form name="abc" method="post" action="myBoard" id="memberNick">
					<input type="hidden" name="member_nick" value="${member.member_nick }">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
				
				<form action="myReply" id="Reply" method="post" name="replyname">
					<input type="hidden" name="member_nick" value="${member.member_nick }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="member_id" value="${member.member_id }">
				</form>
				
			<aside class="col-lg-4 col-xl-3 order-lg-1">
				<div class="sidebar">
					<div class="block clearfix">
						<h3 class="title">마이페이지</h3>
					</div>
					<div class="separator-2"></div>
					<nav>
						<ul class="nav flex-column">
							<li class="nav-item"><a class="nav-link" href="${contextPath }/common/myPage"><span>회원정보</span></a></li>
							<li class="nav-item"><a class="nav-link" href="../common/myBoard?paging=0"><span>내가 쓴 글</span></a></li>
							<li class="nav-item"><a class="nav-link" href="../common/myReply?paging=0"><span>내가 쓴 리플</span></a></li>
<!-- 							<li class="nav-item"><a class="nav-link" href=""><span>원 따봉한 글</span></a></li> -->
							<li class="nav-item"><a class="nav-link" id="messageButton"><span>쪽지/친구목록</span></a></li>
<!-- 							<li class="nav-item"><a class="nav-link" href=""><span></span></a></li> -->
							<li class="nav-item"><a class="nav-link" id="leave" data-toggle="modal" data-target="#myModal" onclick="reset()"><span>회원 탈퇴</span></a></li>
							<li class="nav-item"><a class="nav-link" id="main" href="${contextPath }/common/main"><span>메인으로</span></a></li>
						</ul>
					</nav>
				</div>
			</aside>	
			</div>
		</div>
	</section>
	
	
	 <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
<!--         Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">탈퇴하시겠습니까?</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        
<!--         Modal body -->
        <div class="modal-body">
          	<div>
          		<input type="password" placeholder="패스워드를 입력해주세요" class="w3-input" id="leavePwInput">
          		<button type="button" class="btn btn-danger pull-right leaveButton" onclick="leaveMember()" value="탈퇴">탈퇴</button>
          	</div>
        </div>
        
        
<!--         Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
        
      </div>
    </div>
  </div>
  
</body>
</html>