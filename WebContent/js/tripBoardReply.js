$(function() {
	callReplyList();
	$("#list").click(function() {
//		swal("게시판 리스트로 이동");
		location.href = "../board/List";
	});

	// 댓글 저장
	$("#reply_save").click(function() {
		if ($("#reply_content").val().trim() == "") {
			swal("내용을 입력하세요");
			$("#reply_content").focus();
			return false;
		}

		var reply_content = $("#reply_content").val().replace("\n", "<br>"); // 개행처리

		// 값 세팅
		var objParams = {
			trip_board_num : $("#trip_board_num").val(),
			parent_id : "0",
			depth : "0",
			member_id : $("#member_id").val(),
			member_nick : $("#member_nick").val(),
			reply_content : reply_content
		};

//		console.log(objParams);

		$.ajaxSetup({
			headers : {
				'X-CSRF-Token' : $('meta[name="csrf_token"]').attr('content')
			}
		});
		$.ajax({
			url : "../common/replySave",
			// dataType : "json",
			type : "post",
			// async : false, //동기 : false, 비동기 : true
			data : objParams,
			success : function(retVal) {
				if (retVal.code != "OK") {
					swal(retVal.message);
				} else {
					reply_num = retVal.reply_num;
				}
				callReplyList();
				$("#reply_content").val("");
				$("#reply_password").val("");
				
			},
			error : function(request, status, error) {
//				console.log("AJAX_ERROR");
				swal("댓글등록에 실패했습니다.");
			}
		});
	});

	// 댓글 삭제
	$(document).on("click", "button[name='reply_del']", function() {

		var check = false;
		var reply_num = $(this).attr("reply_num");
		var reply_type = $(this).attr("reply_type")

		var objParams = {
			reply_num : reply_num,
			reply_type : reply_type
		};

		// ajax
		$.ajaxSetup({
			headers : {
				'X-CSRF-Token' : $('meta[name="csrf_token"]').attr('content')
			}
		});
		$.ajax({
			url : "../common/replyDelete",
			dataType : "json",
			type : "post",
			async : false, // 동기 : false, 비동기 : true
			data : objParams,
			success : function(retVal) {
				if (retVal.code != "OK") {
					swal(retVal.message);
				} else {
					check = true;
					swal("삭제되었습니다.");
				}
				callReplyList();
			},
			error : function(request, status, error) {
//				console.log("AJAX_ERROR");
			}
		});
	});

	// 대댓글 입력창
	$(document)
			.on(
					"click",
					"button[name='reply_reply']",
					function() { // 동적
						// 이벤트

						$("#reply_add").remove();

						var reply_num = $(this).attr("reply_num");
						var last_check = false; // 마지막 tr체크

						// 입력받는 창
						var replyEditor = '<tr id="reply_add" class="reply_reply">'
								+ '	<td width="400">'
								+ '		<textarea name="reply_reply_content" rows="1" cols="50" placeholder="댓글을 남겨주세요"></textarea>'
								+ '	</td>'
								+ '	<td>'
								+ '	</td>'
								+ '	<td width="100px">'
								+ $("#member_nick").val()
								+ '	</td>'
//								+ '	<td width="100px">'
//								+ '		<input type="password" name="reply_reply_password" style="width:100%;" maxlength="10" placeholder="패스워드">'
//								+ '	</td>'
								+ '	<td>'
								+ '		<button name="reply_reply_save" reply_num="'
								+ reply_num
								+ '">등록</button>'
								+ '		<button name="reply_reply_cancel">취소</button>'
								+ '	</td>' + '</tr>';

						var prevTr = $(this).parent().parent().next();

						// 부모의 부모 다음이 sub이면 마지막 sub 뒤에 붙인다.
						// 마지막 리플 처리
						if (prevTr.attr("reply_type") == undefined) {
							prevTr = $(this).parent().parent();
						} else {
							while (prevTr.attr("reply_type") == "sub") { // 댓글의
																			// 다음이
																			// sub면
								// 계속 넘어감
								prevTr = prevTr.next();
							}
							if (prevTr.attr("reply_type") == undefined) { // next뒤에
																			// tr이
								// 없다면 마지막이라는
								// 표시를 해주자
								last_check = true;
							} else {
								prevTr = prevTr.prev();
							}
						}

						if (last_check) { // 마지막이라면 제일 마지막 tr 뒤에 댓글 입력을 붙인다.
							$('#reply_area tr:last').after(replyEditor);
						} else {
							prevTr.after(replyEditor);
						}

					});

	// 대댓글 등록
	$(document)
			.on(
					"click",
					"button[name='reply_reply_save']",
					function() {

						var reply_reply_writer = $("input[name='reply_reply_writer']");
						var reply_reply_content = $("textarea[name='reply_reply_content']");
						var reply_reply_content_val = reply_reply_content.val()
								.replace("\n", "<br>"); // 개행처리

						if (reply_reply_content.val().trim() == "") {
							swal("내용을 입력하세요");
							reply_reply_content.focus();
							return false;
						}

						// 값 세팅
						var objParams = {
							trip_board_num : $("#trip_board_num").val(),
							parent_id : $(this).attr("reply_num"),
							depth : "1",
							member_id : $("#member_id").val(),
							member_nick : $("#member_nick").val(),
							reply_content : reply_reply_content_val
						};

//						var reply_num;
						$.ajaxSetup({
							headers : {
								'X-CSRF-Token' : $('meta[name="csrf_token"]')
										.attr('content')
							}
						});
						$.ajax({
							url : "../common/replySave",
							dataType : "json",
							type : "post",
							async : false, // 동기 : false, 비동기 : true
							data : objParams,
							success : function(retVal) {
								if (retVal.code != "OK") {
									swal(retVal.message);
								} else {
									reply_num = retVal.reply_num;
								}
								// location.href = location.href
							},
							error : function(request, status, error) {
//								console.log("AJAX_ERROR");
							}
						});
						callReplyList();
						// $("#reply.add").remove();
					});

	// 대댓글 입력창 취소
	$(document).on("click", "button[name='reply_reply_cancel']", function() {
		$("#reply_add").remove();
	});

});

function callReplyList() {
	$("#reply_area").empty();
	$.ajaxSetup({
		headers : {
			'X-CSRF-Token' : $('meta[name="csrf_token"]').attr('content')
		}
	});
	$
			.ajax({
				type : "post",
				url : "../common/repliesList",
				data : {
					trip_board_num : $("#trip_board_num").val()
				},
				success : function(data) {
//					console.log(data);

					for (var i = 0; i < data.length; i++) {
						
						var deleteButton = "";
						
						if($("#member_nick").val() == data[i].member_nick){
							deleteButton = "<button reply_type='sub' name='reply_del' reply_num="+data[i].reply_num+" id='reply_del'>삭제</button>"
						}
						
						if (data[i].parent_id == 0) {
							$("#reply_area").append(
											"<tr reply_type='main' id='reply_"+data[i].reply_num+"'>"
												+ "<td width='300px' class='reply_content'>"
												+ data[i].reply_content
												+ "</td>"
												+ "<td width='150px'>"
												+ data[i].reply_regdate
												+ "</td>"
												+ "<td width='150px' class='subMenuTd' id='subMenuId"+data[i].reply_num+"'>"
												+	"<input type='button' class='replyWriterButton' value='"+data[i].member_nick+"' onclick='replySubMenu(\""+data[i].reply_num+"\", \""+data[i].member_id+"\", \""+data[i].member_nick+"\")'>"
												+ "</td>"
												+ "<td width='100'>"
												+ '<button name="reply_reply" reply_num = "'
												+ data[i].reply_num
												+ '">댓글</button>'
												+ deleteButton
												+ "</td>" + "</tr>");
						}
					}
					for (var i = data.length - 1; i >= 0; i--) {

						if (data[i].parent_id != 0) {
//							console.log("있냐");
//							console.log(data[i].parent_id);
							
							var deleteButton = "";
							
							if($("#member_nick").val() == data[i].member_nick){
								deleteButton = "<button reply_type='sub' name='reply_del' reply_num="+data[i].reply_num+" id='reply_del'>삭제</button>"
							}
//							console.log(deleteButton);
//							console.log(data[i]);
							
							$("#reply_"+data[i].parent_id).after(
								"<tr reply_type='sub' id="
									+ data[i].reply_num
									+ ">"
									+ "<td width='300px' class='reply_content_sub'>"
									+ "<b>⤷</b> &nbsp;"
									+ data[i].reply_content
									+ "</td>"
									+ "<td width='150px'>"
									+ data[i].reply_regdate
									+ "</td>"
									+ "<td width='150px' class='subMenuTd' id='subMenuId"+data[i].reply_num+"'>"
									+	"<input type='button' class='replyWriterButton' value='"+data[i].member_nick+"' onclick='replySubMenu(\""+data[i].reply_num+"\", \""+data[i].member_id+"\", \""+data[i].member_nick+"\")'>"
									+ "</td>"
									+ "<td width='50'>"
									+ deleteButton
									+ "</td>"
								+ "</tr>");
						}
					}
				},
				error : function(data) {
					swal("댓글이 없습니다.");
				}
			});
}
function fuckyou(){
	$(".reply_subMenu").remove();
}
function replySubMenu(replyNum, member_id, member_nick){
	$(".reply_subMenu").remove();
		
	$("#subMenuId"+replyNum).append(
		'<div class="reply_subMenu">'
		+'	<table class="reply_subMenu_table">'
		+'		<tr>'
		+'			<td class="reply_subMenu_button" onclick="newMessage(\''+member_id+'\',\''+member_nick+'\')">쪽지 보내기</td>'
//		+'			<td class="reply_subMenu_button"><input type="button" value="쪽지 보내기" onclick="newMessage(\''+member_id+'\',\''+member_nick+'\')"></td>'
		+'		</tr>'
		+'		<tr>'
		+'			<td class="reply_subMenu_button" onclick="searching()">작성글 검색</td>'
		+'		</tr>'
		+'		<tr>'
		+'			<td class="reply_subMenu_button" onclick="addRelation(\''+member_id+'\',\'friend\')">친구 추가</td>'
		+'		</tr>'
		+'		<tr>'
		+'			<td class="reply_subMenu_button" onclick="addRelation(\''+member_id+'\',\'ignored\')">차단</td>'
		+'		</tr>'
		+'		<tr>'
		+'			<td class="reply_subMenu_button" onclick="fuckyou()">X</td>'
		+'		</tr>'
		+'	</table>'
		+'</div>'
	);
}

