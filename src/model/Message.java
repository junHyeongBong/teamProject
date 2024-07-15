package model;

import java.util.Date;

public class Message {
	private int message_num;
	private String message_title;
	private String message_send_id;
	private String message_send_nick;
	private String message_receive_id;
	private String message_receive_nick;
	private String message_content;
	private String message_isread;
	private String message_del_sender;
	private String message_del_receiver;
	private Date message_writedate;
		
	public int getMessage_num() {
		return message_num;
	}
	public void setMessage_num(int message_num) {
		this.message_num = message_num;
	}
	public String getMessage_title() {
		return message_title;
	}
	public void setMessage_title(String message_title) {
		this.message_title = message_title;
	}
	public String getMessage_send_id() {
		return message_send_id;
	}
	public void setMessage_send_id(String message_send_id) {
		this.message_send_id = message_send_id;
	}
	public String getMessage_send_nick() {
		return message_send_nick;
	}
	public void setMessage_send_nick(String message_send_nick) {
		this.message_send_nick = message_send_nick;
	}
	public String getMessage_receive_id() {
		return message_receive_id;
	}
	public void setMessage_receive_id(String message_receive_id) {
		this.message_receive_id = message_receive_id;
	}
	public String getMessage_receive_nick() {
		return message_receive_nick;
	}
	public void setMessage_receive_nick(String message_receive_nick) {
		this.message_receive_nick = message_receive_nick;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public String getMessage_isread() {
		return message_isread;
	}
	public void setMessage_isread(String message_isread) {
		this.message_isread = message_isread;
	}
	public String getMessage_del_sender() {
		return message_del_sender;
	}
	public void setMessage_del_sender(String message_del_sender) {
		this.message_del_sender = message_del_sender;
	}
	public String getMessage_del_receiver() {
		return message_del_receiver;
	}
	public void setMessage_del_receiver(String message_del_receiver) {
		this.message_del_receiver = message_del_receiver;
	}
	public Date getMessage_writedate() {
		return message_writedate;
	}
	public void setMessage_writedate(Date message_writedate) {
		this.message_writedate = message_writedate;
	}
	
	@Override
	public String toString() {
		return "Message [message_num=" + message_num + ", message_title=" + message_title + ", message_send_id="
				+ message_send_id + ", message_send_nick=" + message_send_nick + ", message_receive_id="
				+ message_receive_id + ", message_receive_nick=" + message_receive_nick + ", message_content="
				+ message_content + ", message_isread=" + message_isread + ", message_del_sender=" + message_del_sender
				+ ", message_del_receiver=" + message_del_receiver + ", message_writedate=" + message_writedate + "]";
	}
	
	
	
	
}



