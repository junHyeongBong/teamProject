package model;

public class Reply {
	private String reply_num;
	private String trip_board_num;
	private String parent_id;
	private String depth;
	private String member_id;
	private String member_nick;
	private String reply_content;
	private String reply_regdate;
	private String reply_password;
	public String getReply_num() {
		return reply_num;
	}
	public String getTrip_board_num() {
		return trip_board_num;
	}
	public String getParent_id() {
		return parent_id;
	}
	public String getDepth() {
		return depth;
	}
	public String getMember_id() {
		return member_id;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public String getReply_content() {
		return reply_content;
	}
	public String getReply_regdate() {
		return reply_regdate;
	}
	public String getReply_password() {
		return reply_password;
	}
	public void setReply_num(String reply_num) {
		this.reply_num = reply_num;
	}
	public void setTrip_board_num(String trip_board_num) {
		this.trip_board_num = trip_board_num;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public void setReply_regdate(String reply_regdate) {
		this.reply_regdate = reply_regdate;
	}
	public void setReply_password(String reply_password) {
		this.reply_password = reply_password;
	}
	@Override
	public String toString() {
		return "Reply [reply_num=" + reply_num + ", trip_board_num=" + trip_board_num + ", parent_id=" + parent_id
				+ ", depth=" + depth + ", member_id=" + member_id + ", member_nick=" + member_nick + ", reply_content="
				+ reply_content + ", reply_regdate=" + reply_regdate + ", reply_password=" + reply_password + "]";
	}
	
		
}
