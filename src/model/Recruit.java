package model;

public class Recruit {
	private int recruit_index;
	private int trip_board_num;
	private String trip_board_member_id;
	private String trip_board_member_nick;
	private String trip_board_recruit_id;
	private String trip_board_recruit_nick;
	private int recruit_accept;
	private String recruit_regdate;
	
	public int getRecruit_index() {
		return recruit_index;
	}
	public int getTrip_board_num() {
		return trip_board_num;
	}
	public String getTrip_board_member_id() {
		return trip_board_member_id;
	}
	public String getTrip_board_member_nick() {
		return trip_board_member_nick;
	}
	public String getTrip_board_recruit_id() {
		return trip_board_recruit_id;
	}
	public String getTrip_board_recruit_nick() {
		return trip_board_recruit_nick;
	}
	public int getRecruit_accept() {
		return recruit_accept;
	}
	public String getRecruit_regdate() {
		return recruit_regdate;
	}
	public void setRecruit_index(int recruit_index) {
		this.recruit_index = recruit_index;
	}
	public void setTrip_board_num(int trip_board_num) {
		this.trip_board_num = trip_board_num;
	}
	public void setTrip_board_member_id(String trip_board_member_id) {
		this.trip_board_member_id = trip_board_member_id;
	}
	public void setTrip_board_member_nick(String trip_board_member_nick) {
		this.trip_board_member_nick = trip_board_member_nick;
	}
	public void setTrip_board_recruit_id(String trip_board_recruit_id) {
		this.trip_board_recruit_id = trip_board_recruit_id;
	}
	public void setTrip_board_recruit_nick(String trip_board_recruit_nick) {
		this.trip_board_recruit_nick = trip_board_recruit_nick;
	}
	public void setRecruit_accept(int recruit_accept) {
		this.recruit_accept = recruit_accept;
	}
	public void setRecruit_regdate(String recruit_regdate) {
		this.recruit_regdate = recruit_regdate;
	}
	@Override
	public String toString() {
		return "Recruit [recruit_index=" + recruit_index + ", trip_board_num=" + trip_board_num
				+ ", trip_board_member_id=" + trip_board_member_id + ", trip_board_member_nick="
				+ trip_board_member_nick + ", trip_board_recruit_id=" + trip_board_recruit_id
				+ ", trip_board_recruit_nick=" + trip_board_recruit_nick + ", recruit_accept=" + recruit_accept
				+ ", recruit_regdate=" + recruit_regdate + "]";
	}
}
