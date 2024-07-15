var sock;
var stompClient = null;

$(document).ready(function(){
	$(".myInfo").hide();
	connect();
})

function myInfoShowHide(){
	if($(".myInfo").css("display") == "none") {
		$(".myInfo").show();
		$(".otherDiv").show();
	}else{
		$(".myInfo").hide();
	}
}

function checkNotify(){
	$(".myInfo").hide("slow");
	var alarmBox = document.getElementById("msg_notify_div");
	alarmBox.style.display = "none";
	openMessageBox();
}

function openMessageBox(){
	window.open("../common/receiveMsgBox", "", "width=441 height=538");
}

function connect(){
	sock = new SockJS("http://localhost:8081/Project_TF/msgConnect");
//	sock = new SockJS("http://192.168.0.68:8081/Project_TF/msgConnect");
	stompClient = Stomp.over(sock);
	stompClient.connect({},function(){
		stompClient.subscribe("/topic/message/"+$("input[name='member_id']").val(),function(msg){
			if(msg.body == "msgNotifyReq"){
				$(".myInfo").show("slow");
				$(".otherDiv").hide("slow");
				var alarmBox = document.getElementById("msg_notify_div");
				alarmBox.style.display = "inline-block";
				$("#msg_notify_div").empty();
				$("#msg_notify_div").append('<br>'
				+'<span class="ab" onclick="openMessageBox()"><b>'+$("input[name='member_id']").val()+' 님</b><br><br>'
					  +'쪽지가 도착했습니다.'
				+'</span>')
				
				var msgNotifySound = new Audio("../audio/msg_tempAudio.mp3");
				msgNotifySound.play();
			}else{
				$(".myInfo").show("slow");
				$(".otherDiv").hide("slow");
				var alarmBox = document.getElementById("msg_notify_div");
				alarmBox.style.display = "inline-block";
				$("#msg_notify_div").empty();
				var tmpAlarm = msg.body;
				console.log(tmpAlarm);
				$("#msg_notify_div").append(
				'<span class="ab" onclick="location.href=\'../common/readOneTripBoard?pageType=recruit&trip_board_num='+tmpAlarm.split("/")[0]+'\'"><b>'+$("input[name='member_id']").val()+' 님</b><br>'
					  +tmpAlarm.split("/")[1]
				+'</span>')
			}
		});
	})
}