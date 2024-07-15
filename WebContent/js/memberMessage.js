/**
 * 
 */
$(function() {
	$.ajaxSetup({
	    headers: {
	    	'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
});


function sendMessage(message_send_id,message_send_nick,message_receive_id,message_receive_nick){
	$.ajax({
		url: getContextPath()+"/common/sendMessage",
		type:"post",
		data : {"message_send_id":message_send_id, "message_send_nick":message_send_nick,
			    "message_receive_id":message_receive_id, "message_receive_nick":message_receive_nick,
				"message_title":$("#message_title_input").val(), "message_content":$("#message_content_input").val(),
				},
		dataType:"json",
		success : function(data){
			stompClient.send("/client/message/" + message_send_id + "/" + message_receive_id,{},"msgNotifyReq");
			swal(data.msg).then(function() {
				if(data.result){
					location.href = getContextPath()+"/common/sendMsgBox";
				}else{
					location.href = getContextPath()+"/common/newMessage";
				}
			});
		}
	})
}

function delMessage(which,num,id){
	$.ajax({
		url: getContextPath()+"/common/deleteMessage",
		type:"post",
		data : {"which_message":which, "message_num":num, "message_id":id},
		dataType:"json",
		success : function(data){
			if(data.result){
				swal("쪽지 삭제 완료").then(function() {
					if(which=="receive"){
						location.href = getContextPath()+"/common/receiveMsgBox";
					}else{
						location.href = getContextPath()+"/common/sendMsgBox";
					}
				});
				
				
			}else{
				swal("쪽지 삭제 실패");
			}
		}
	})			
}

function delCheckedMessage(which){
	var checkBoxValues = [];
	$("input[name='msgNo']:checked").each(function(i){
		checkBoxValues.push($(this).val());
	})
	var data = {"checkArray":checkBoxValues, "which_message":which};
	$.ajax({
		url:getContextPath()+"/common/deleteCheckedMessage",
		type:"post",
		data: data,
		dataType: "json",
		success : function(data){
			if(data.result){
				swal("쪽지 삭제 완료").then(function() {
					if(which=="receive"){
						location.href = getContextPath()+"/common/receiveMsgBox";
					}else{
						location.href = getContextPath()+"/common/sendMsgBox";
					}
				});
			}else{
				swal("쪽지 삭제 실패").then(function() {
					if(which=="receive"){
						location.href = getContextPath()+"/common/receiveMsgBox";
					}else{
						location.href = getContextPath()+"/common/sendMsgBox";
					}
				});
			}
		}
	})
}

function delCheckedRelation(member_id){
	var checkBoxValues = [];
	$("input[name='memNo']:checked").each(function(i){
		checkBoxValues.push($(this).val());
	})
	var data = {"checkArray":checkBoxValues, "member_id":member_id};
	$.ajax({
		url:getContextPath()+"/common/removeCheckedRelation",
		type:"post",
		data: data,
//		dataType: "json",
		success : function(data){
			if(data){
				swal("삭제 완료").then(function() {
					location.reload();
				});
			}else{
				swal("삭제 실패");
			}
		}
	})
}

function reverseChecked() {
	if($("input:checkbox[name='msgNo']") != null){
		$("input:checkbox[name='msgNo']").each(function(i){
			if($(this).is(":checked")==true){
				$(this).prop("checked", false);
			}else{
				$(this).prop("checked", true);
			}
		})
	}
	if($("input:checkbox[name='memNo']") != null){
		$("input:checkbox[name='memNo']").each(function(i){
			if($(this).is(":checked")==true){
				$(this).prop("checked", false);
			}else{
				$(this).prop("checked", true);
			}
		})
	}
}

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};