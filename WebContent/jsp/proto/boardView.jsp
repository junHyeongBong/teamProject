<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<% request.setAttribute("contextPath", request.getContextPath()); %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="csrf_token" content="${_csrf.token}">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="styleSheet" href="${contextPath }/css/boardView.css">

<script type="text/javascript">
	$(function(){
		$("#list").click(function(){
			alert("게시판 리스트로 이동");
			location.href = "../board/List";
		});
		
		//댓글 저장
		$("#reply_save").click(function(){
			if($("#reply_password").val().trim() == ""){
				alert("패스워드를 입력하세요");
				$("#reply_password").focus();
				return false;
			}
			
			if($("#reply_content").val().trim()==""){
				alert("내용을 입력하세요");
				$("#reply_content").focus();
				return false;
			}
			
			var reply_content = $("#reply_content").val().replace("\n", "<br>"); //개행처리
			
			//값 세팅
			var objParams = {
				trip_board_num	:	"31",
				parent_id		:	"0",
				depth			:	"0",
				member_id		:	"tester",
				member_nick		:	"testman",
				reply_password	:	$("#reply_password").val(),
				reply_content	:	reply_content
			};
			
			console.log(objParams);
			
			var reply_num;
			
			$.ajaxSetup({
			    headers: {
			      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
			    }
			});
			$.ajax({
				url 	 	: "../common/replySave",
// 				dataType 	: "json",
				type		: "post",
// 				async		: false, //동기 : false, 비동기 : true
				data		: objParams,
				success		: function(retVal){
					if(retVal.code != "OK"){
						alert(retVal.message);
					}else{
						reply_num = retVal.reply_num;
					}
					callReplyList();
// 					location.href = location.href
				},
				error		:	function(request, status, error){
					console.log("AJAX_ERROR");
					alert("댓글등록에 실패했습니다.");
				}
			});
		});
	
			//댓글 삭제
			$(document).on("click","button[name='reply_del']",function(){
				
				var check = false;
				var reply_num = $(this).attr("reply_num");
				var reply_password = "reply_password_"+reply_num;
				var reply_type = $(this).attr("reply_type")
				
				if($("#"+reply_password).val().trim() == ""){
					alert("패스워드를 입력하세요");
					$("#"+reply_password).focus();
					return false;
				}
				
				//패스워드와 아디를 넘겨 삭제를 한다.
				//값 세팅
				var objParams = {
						reply_password	:	$("#"+reply_password).val(),
						reply_num		:	reply_num,
						reply_type		: 	reply_type
				};
				
				//ajax
				$.ajaxSetup({
				    headers: {
				      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
				    }
				});
				$.ajax({
					url			:	"${contextPath}/common/replyDelete",
					dataType	:	"json",
					type		:	"post",
					async		:	false, //동기 : false, 비동기 : true
					data		:	objParams,
					success		:	function(retVal){
						if(retVal.code != "OK"){
							alert(retVal.message);
						}else{
							check = true;
							alert("삭제되었습니다.");
						}
						callReplyList();
					},
					error		:	function(request, status, error){
						console.log("AJAX_ERROR");
					}
				});
			});
			
			//대댓글 입력창
			$(document).on("click", "button[name='reply_reply']", function(){	//동적 이벤트
				
				$("#reply_add").remove();
			
				var reply_num = $(this).attr("reply_num");
				var last_check = false; //마지막 tr체크
				
				//입력받는 창 
				var replyEditor = 
					'<tr id="reply_add" class="reply_reply">'+
					'	<td width="400">'+
					'		<textarea name="reply_reply_content" rows="1" cols="50" placeholder="댓글을 남겨주세요"></textarea>'+
					'	</td>'+
					'	<td width="100px">'+
// 					'		<input type="text" name="reply_reply_writer" style="width:100%;" maxlength="10" placeholder="작성자">'+
							'${member.member_nick}'+
					'	</td>'+
					'	<td width="100px">'+
					'		<input type="password" name="reply_reply_password" style="width:100%;" maxlength="10" placeholder="패스워드">'+
					'	</td>'+
					'	<td>' +
					'		<button name="reply_reply_save" reply_num="'+reply_num+'">등록</button>'+
					'		<button name="reply_reply_cancel">취소</button>'+
					'	</td>'+
					'</tr>';
					
				var prevTr = $(this).parent().parent().next();
				
				//부모의 부모 다음이 sub이면 마지막 sub 뒤에 붙인다.
				//마지막 리플 처리
				if(prevTr.attr("reply_type") == undefined){
					prevTr = $(this).parent().parent();
				}else{
					while(prevTr.attr("reply_type") == "sub"){ //댓글의 다음이 sub면 계속 넘어감
						prevTr = prevTr.next();
					}
					if(prevTr.attr("reply_type") == undefined){ //next뒤에 tr이 없다면 마지막이라는 표시를 해주자
						last_check = true;
					}else{
						prevTr = prevTr.prev();
					}
				}
				
				if(last_check){		//마지막이라면 제일 마지막 tr 뒤에 댓글 입력을 붙인다.
					$('#reply_area tr:last').after(replyEditor);
				}else{
					prevTr.after(replyEditor);
				}
				
			});
			
			//대댓글 등록
			$(document).on("click", "button[name='reply_reply_save']", function(){
				
				var reply_reply_writer = $("input[name='reply_reply_writer']");
				var reply_reply_password = $("input[name='reply_reply_password']");
				var reply_reply_content = $("textarea[name='reply_reply_content']");
				var reply_reply_content_val = reply_reply_content.val().replace("\n", "<br>"); //개행처리
				
				
				if(reply_reply_password.val().trim() == ""){
					alert("패스워드를 입력하세요");
					reply_reply_password.focus();
					return false;
				}
				
				if(reply_reply_content.val().trim() == ""){
					alert("내용을 입력하세요");
					reply_reply_content.focus();
					return false;
				}
				
				//값 세팅
				var objParams = {
						trip_board_num 		:		$("#trip_board_num").val(),
						parent_id			:		$(this).attr("reply_num"),
						depth				:		"1",
						member_id			:		"tester",
						member_nick			:		"testman",
						reply_password		:		reply_reply_password.val(),
						reply_content		:		reply_reply_content_val
				};
				
				var reply_num;
				$.ajaxSetup({
				    headers: {
				      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
				    }
				});
				$.ajax({
					url			:		"${contextPath}/common/replySave",
					dataType	:		"json",
					type		:		"post",
					async		:		false, //동기 : false, 비동기 : true
					data		:		objParams,
					success		:		function(retVal){
						if(retVal.code != "OK"){
							alert(retVal.message);
						}else{
							reply_num = retVal.reply_num;
						}
// 						location.href = location.href
					},
					error		:	function(request, status, error){
						console.log("AJAX_ERROR");
					}
				});
				callReplyList();
// 				$("#reply.add").remove();
			});
	
			//대댓글 입력창 취소
			$(document).on("click", "button[name='reply_reply_cancel']", function(){
				$("#reply_add").remove();
			});
			
			
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<input type="hidden" id="trip_board_num" name="trip_board_num" value="31">
		<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>게시글 상세보기</h1>
				<div class="form-group">
					작성자&nbsp;&nbsp;<input type="text" name="name" value="${board.member_nick }" readonly="readonly" class="form-control">
				</div>
				<div class="form-group">
					제목&nbsp;&nbsp;<input type="text" name="title" value="${board.trip_board_title }" class="form-control" readonly="readonly">
				</div>		
				<div class="form-group">
					작성일&nbsp;&nbsp;<input type="text" name="title" value="${board.trip_board_writedate }" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">	
					내용&nbsp;&nbsp;<textarea rows="16" cols="70" name="content" class="form-control" readonly="readonly">${board.trip_board_content }</textarea>
				</div>
				<br><br><br>
<%-- 				<input type="button" value="수정" onclick="open_win('board_check_pass&num=${board.num}','update')" class="btn btn-primary primary"> --%>
<%-- 				<input type="button" value="삭제" onclick="open_win('board_check_pass&num=${board.num}','delete')" class="btn btn-primary primary"> --%>
				<a href="List" class="btn btn-primary primary">목록보기</a>
				<a href="write" class="btn btn-primary primary">새 글쓰기</a>
				<a href="${contextPath }/member/login" class="btn btn-primary primary">로그인</a>
				<a href="${contextPath }/member/logout" class="btn btn-primary primary">로그아웃</a><br><br><br>
<!-- 				<input type="button" onclick="replyDelte('메롱')" value="테스트"> -->
<%-- 				<p align="center"><font size="2">Copyright <img src="${contextPath}/images/copyright.png" style="width: 0 auto; height: 10px;"> BBongs Corp. All Right Reserved.</font></p> --%>
			<div class="reply">	
				<table border="1" width="1000" style="border-style: hidden;"> <!-- bordercolor="#46AA46" -->
					<tr style="border-style: hidden;">
						<td width="500px" style="border-style: hidden;">
<!-- 							이름 : <input type="text" id="member_nick" name="member_nick" style="width:170px;" maxlength="10" placeholder="작성자"> -->
							닉네임: testman 
							<span style="margin-left: 100px;">패스워드: <input type="password" id="reply_password" name="reply_password" style="width:170px;" maxlength="10" placeholder="패스워드"></span>
							<button id="reply_save" name="reply_save">댓글 등록</button>
<!-- 							<input onclick="empty()" type="button" value="test"> -->
						</td>
					</tr>
					<tr>
						<td>
							<textarea rows="1" cols="70" placeholder="댓글을 입력해주세요" id="reply_content" name="reply_content"></textarea>
						</td>
					</tr>
				</table>
				
				<table border="1" width="1000" id="reply_area">
<!-- 					<tr reply_type="all">뒤에 댓글 붙이기 쉽게 선언 -->
<!-- 						<td colspan="4"></td> -->
<!-- 					</tr> -->
					<!-- 댓글이 들어갈 공간 -->
<%-- 					<c:forEach var="replyList" items="${replyList }" varStatus="status"> --%>
<%-- 						<tr reply_type="<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>"><!-- 댓글의 depth 표시 --> --%>
<!-- 							<td width="870px"> -->
<%-- 								<c:if test="${replyList.depth == '1' }">┖</c:if>${replyList.reply_content } --%>
<!-- 							</td> -->
<!-- 							<td width="100px"> -->
<%-- 								${replyList.member_nick } --%>
<!-- 							</td> -->
<!-- 							<td width="100px"> -->
<%-- 								<input type="password" id="reply_password_${replyList.reply_num}" style="width: 100px;" maxlength="10" placeholder="패스워드"> --%>
<!-- 							</td> -->
<!-- 							<td> -->
<%-- 								<button name="reply_del" reply_num = "${replyList.reply_num }" id="reply_del">삭제</button> --%>
<%-- 								<c:if test="${replyList.depth != '1' }"> --%>
<%-- 									<button name="reply_reply" reply_num = "${replyList.reply_num }">댓글</button><!-- 첫 댓글에만 댓글이 추가 대댓글 불가 --> --%>
<%-- 								</c:if> --%>
<!-- 							</td> -->
<!-- 						</tr> -->
<%-- 					</c:forEach> --%>
					
				</table>
				</div>
			</div>
		</div>
	</div>		
</body>
<script type="text/javascript">
$(function(){
	callReplyList();
	
});


function callReplyList(){
	$("#reply_area").empty();
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type		: "post",
		url			: "../common/repliesList",
		data		: {
			trip_board_num : $("#trip_board_num").val()
		},
		success		:	function(data){
			console.log(data);
			
			for(var i=0; i<data.length; i++){
				if(data[i].parent_id == 0){
					$("#reply_area").append(
							"<tr reply_type='main' id="+data[i].reply_num+">"+
								"<td width='300px'>"+
									data[i].reply_content+
								"</td>"+
								"<td width='150px'>"+
									data[i].reply_regdate + 
								"</td>"+
								"<td width='100px'>"+
									data[i].member_nick +
								"</td>"+
								"<td width='100px'>"+
									"<input type='password' id='reply_password_"+data[i].reply_num+"' style='width: 100px;' maxlength='10' placeholder='패스워드'>"+
								"</td>"+
								"<td width='100'>"+
									'<button name="reply_reply" reply_num = "'+data[i].reply_num+'">댓글</button>'+
									'<button reply_type="main"  name="reply_del" reply_num = "'+data[i].reply_num+'" id="reply_del">삭제</button>'+
								"</td>"+	
							"</tr>"
					);
				}
			}
// 			for(var i=0; i<data.length; i++){
			
			for(var i=data.length-1; i>=0; i--){
			
				if(data[i].parent_id != 0){
					console.log("있냐");
					console.log(data[i].parent_id);
					 $("#"+data[i].parent_id).after(
							"<tr reply_type='sub' id="+data[i].reply_num+">"+
								"<td width='300px'>"+
									"┗"+
										data[i].reply_content+
								"</td>"+
								"<td width='150px'>"+
									data[i].reply_regdate + 
								"</td>"+
								"<td width='150px'>"+
										data[i].member_nick+
								"</td>"+
								"<td width='100px'>"+
									"<input type='password' id='reply_password_"+data[i].reply_num+"' style='width: 100px;' maxlength='10' placeholder='패스워드'>"+
								"</td>"+
								"<td width='50'>"+
									"<button reply_type='sub' name='reply_del' reply_num="+data[i].reply_num+" id='reply_del'>"+"삭제"+"</button>"+
								"</td>"+
							"</tr>"
					);
					
					
				}
			}
		},error:function(data){
			alert("에러욤ㅋ");
		}
});
	
}
</script>
</html>