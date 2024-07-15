package model;

import java.util.Date;

public class Member {
	
	private static final String NAVER = "naver";
	private static final String GOOGLE = "google";
	private static final String KAKAO = "kakao";
	
	private String member_id;
	private String member_type;
	private String member_pw;
	private String member_email;
	private String member_nick;
	private String member_gender;
	private Date member_regdate;
	private String member_email_authcode;
	private String member_bool;
	private String member_bool_memo;
	private String member_pf_image;
	
	public Member() {
		
	}
	
	public Member(NaverUser naverUser) {
		this.member_id = naverUser.getId() + "@" + NAVER;
		this.member_type = NAVER;
		this.member_email = naverUser.getId() + "@" + NAVER + ".tf";
		this.member_gender = naverUser.getGender();
	}
	
	public Member(GoogleUser googleUser) {
		this.member_id = googleUser.getId() + "@" + GOOGLE;
		this.member_type = GOOGLE;
		this.member_email = googleUser.getId() + "@" + GOOGLE + ".tf";
	}
	
	public Member(KakaoUser kakaoUser) {
		this.member_id = kakaoUser.getId() + "@" + KAKAO;
		this.member_type = KAKAO;
		this.member_email = kakaoUser.getId() + "@" + KAKAO + ".tf";
	}
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public Date getMember_regdate() {
		return member_regdate;
	}
	public void setMember_regdate(Date member_regdate) {
		this.member_regdate = member_regdate;
	}
	public String getMember_bool() {
		return member_bool;
	}
	public void setMember_bool(String member_bool) {
		this.member_bool = member_bool;
	}
	public String getMember_email_authcode() {
		return member_email_authcode;
	}
	public void setMember_email_authcode(String member_email_authcode) {
		this.member_email_authcode = member_email_authcode;
	}
	public String getMember_bool_memo() {
		return member_bool_memo;
	}
	public void setMember_bool_memo(String member_bool_memo) {
		this.member_bool_memo = member_bool_memo;
	}
	

	public String getMember_pf_image() {
		return member_pf_image;
	}

	public void setMember_pf_image(String member_pf_image) {
		this.member_pf_image = member_pf_image;
	}

	@Override
	public String toString() {
		return "Member [member_id=" + member_id + ", member_type=" + member_type + ", member_pw=" + member_pw
				+ ", member_email=" + member_email + ", member_nick=" + member_nick + ", member_gender=" + member_gender
				+ ", member_regdate=" + member_regdate + ", member_email_authcode=" + member_email_authcode
				+ ", member_bool=" + member_bool + ", member_bool_memo=" + member_bool_memo + ", member_pf_image="
				+ member_pf_image + "]";
	}

	
}

	