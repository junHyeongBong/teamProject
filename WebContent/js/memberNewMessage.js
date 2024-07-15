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


function sendMessage(){

		$.ajax({
//			url:"${contextPath}/member/sendMessage",
			url:"../common/sendMessage",
			type:"post",
			data : {"message_send_id":"hong1", "message_send_nick":"호부호형",
				    "message_receive_id":"lim1", "message_receive_nick":"의적",
					"message_title":$("#message_title_input").val(), "message_content":$("#message_content_input").val(),
					},
			dataType:"json",
			success : function(data){
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