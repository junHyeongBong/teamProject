package model;

import java.util.Date;

public class Trip_Board {
	private int trip_board_num;
	private String member_id;
	private String member_nick;
	private String trip_board_title;
	private String trip_board_startdate;
	private String trip_board_enddate;
	private int trip_board_nowcount;
	private int trip_board_finalcount;
	private String trip_board_recruit;
	private String trip_board_bool;
	private String trip_board_memo;
	private int trip_board_hits;
	private int trip_board_recommend;
	private int trip_board_reply_count;
	private Date trip_board_writedate;
	
	public int getTrip_board_num() {
		return trip_board_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public String getTrip_board_title() {
		return trip_board_title;
	}
	public String getTrip_board_startdate() {
		return trip_board_startdate;
	}
	public String getTrip_board_enddate() {
		return trip_board_enddate;
	}
	public int getTrip_board_nowcount() {
		return trip_board_nowcount;
	}
	public int getTrip_board_finalcount() {
		return trip_board_finalcount;
	}
	public String getTrip_board_recruit() {
		return trip_board_recruit;
	}
	public String getTrip_board_bool() {
		return trip_board_bool;
	}
	public String getTrip_board_memo() {
		return trip_board_memo;
	}
	public int getTrip_board_hits() {
		return trip_board_hits;
	}
	public int getTrip_board_recommend() {
		return trip_board_recommend;
	}
	public Date getTrip_board_writedate() {
		return trip_board_writedate;
	}
	public void setTrip_board_num(int trip_board_num) {
		this.trip_board_num = trip_board_num;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public void setTrip_board_title(String trip_board_title) {
		this.trip_board_title = trip_board_title;
	}
	public void setTrip_board_startdate(String trip_board_startdate) {
		this.trip_board_startdate = trip_board_startdate;
	}
	public void setTrip_board_enddate(String trip_board_enddate) {
		this.trip_board_enddate = trip_board_enddate;
	}
	public void setTrip_board_nowcount(int trip_board_nowcount) {
		this.trip_board_nowcount = trip_board_nowcount;
	}
	public void setTrip_board_finalcount(int trip_board_finalcount) {
		this.trip_board_finalcount = trip_board_finalcount;
	}
	public void setTrip_board_recruit(String trip_board_recruit) {
		this.trip_board_recruit = trip_board_recruit;
	}
	public void setTrip_board_bool(String trip_board_bool) {
		this.trip_board_bool = trip_board_bool;
	}
	public void setTrip_board_memo(String trip_board_memo) {
		this.trip_board_memo = trip_board_memo;
	}
	public void setTrip_board_hits(int trip_board_hits) {
		this.trip_board_hits = trip_board_hits;
	}
	public void setTrip_board_recommend(int trip_board_recommend) {
		this.trip_board_recommend = trip_board_recommend;
	}
	public void setTrip_board_writedate(Date trip_board_writedate) {
		this.trip_board_writedate = trip_board_writedate;
	}
	public int getTrip_board_reply_count() {
		return trip_board_reply_count;
	}
	public void setTrip_board_reply_count(int trip_board_reply_count) {
		this.trip_board_reply_count = trip_board_reply_count;
	}
	
	
	@Override
	public String toString() {
		return "Trip_Board [trip_board_num=" + trip_board_num + ", member_id=" + member_id + ", member_nick="
				+ member_nick + ", trip_board_title=" + trip_board_title + ", trip_board_startdate="
				+ trip_board_startdate + ", trip_board_enddate=" + trip_board_enddate + ", trip_board_nowcount="
				+ trip_board_nowcount + ", trip_board_finalcount=" + trip_board_finalcount + ", trip_board_recruit="
				+ trip_board_recruit + ", trip_board_bool=" + trip_board_bool + ", trip_board_memo=" + trip_board_memo
				+ ", trip_board_hits=" + trip_board_hits + ", trip_board_recommend=" + trip_board_recommend
				+ ", trip_board_reply_count=" + trip_board_reply_count + ", trip_board_writedate="
				+ trip_board_writedate + "]";
	}
}
