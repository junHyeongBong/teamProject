package model;

public class KakaoUser {
	private String id;
	
	public KakaoUser() {}
	public KakaoUser(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "KakaoUser [id=" + id + "]";
	}
	
	
	
}
