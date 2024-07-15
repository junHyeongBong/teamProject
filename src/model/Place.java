package model;

public class Place {
	private int place_index;
	private String place_name;
	private String place_address;
	private String place_province;
	private String place_city;
	private Double place_laty;
	private Double place_lngx;
	private String place_type;
	private String place_purpose;
	private String place_recodate;
	private String place_recomethod;
	private String place_mainuser;
	private String place_transport;
	private int place_hits;
	private String place_regdate;
	
	public int getPlace_index() {
		return place_index;
	}
	public String getPlace_name() {
		return place_name;
	}
	public String getPlace_address() {
		return place_address;
	}
	public String getPlace_province() {
		return place_province;
	}
	public String getPlace_city() {
		return place_city;
	}
	public Double getPlace_laty() {
		return place_laty;
	}
	public Double getPlace_lngx() {
		return place_lngx;
	}
	public String getPlace_type() {
		return place_type;
	}
	public String getPlace_purpose() {
		return place_purpose;
	}
	public String getPlace_recodate() {
		return place_recodate;
	}
	public String getPlace_recomethod() {
		return place_recomethod;
	}
	public String getPlace_mainuser() {
		return place_mainuser;
	}
	public String getPlace_transport() {
		return place_transport;
	}
	public int getPlace_hits() {
		return place_hits;
	}
	public String getPlace_regdate() {
		return place_regdate;
	}
	public void setPlace_index(int place_index) {
		this.place_index = place_index;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}
	public void setPlace_province(String place_province) {
		this.place_province = place_province;
	}
	public void setPlace_city(String place_city) {
		this.place_city = place_city;
	}
	public void setPlace_laty(Double place_laty) {
		this.place_laty = place_laty;
	}
	public void setPlace_lngx(Double place_lngx) {
		this.place_lngx = place_lngx;
	}
	public void setPlace_type(String place_type) {
		this.place_type = place_type;
	}
	public void setPlace_purpose(String place_purpose) {
		this.place_purpose = place_purpose;
	}
	public void setPlace_recodate(String place_recodate) {
		this.place_recodate = place_recodate;
	}
	public void setPlace_recomethod(String place_recomethod) {
		this.place_recomethod = place_recomethod;
	}
	public void setPlace_mainuser(String place_mainuser) {
		this.place_mainuser = place_mainuser;
	}
	public void setPlace_transport(String place_transport) {
		this.place_transport = place_transport;
	}
	public void setPlace_hits(int place_hits) {
		this.place_hits = place_hits;
	}
	public void setPlace_regdate(String place_regdate) {
		this.place_regdate = place_regdate;
	}
	
	@Override
	public String toString() {
		return "Place [place_index=" + place_index + ", place_name=" + place_name + ", place_address=" + place_address
				+ ", place_province=" + place_province + ", place_city=" + place_city + ", place_laty=" + place_laty
				+ ", place_lngx=" + place_lngx + ", place_type=" + place_type + ", place_purpose=" + place_purpose
				+ ", place_recodate=" + place_recodate + ", place_recomethod=" + place_recomethod + ", place_mainuser="
				+ place_mainuser + ", place_transport=" + place_transport + ", place_hits=" + place_hits
				+ ", place_regdate=" + place_regdate + "]";
	}
}