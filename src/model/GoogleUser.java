package model;

public class GoogleUser {
	private String id;
	
	public GoogleUser() {}
	public GoogleUser(String id) {
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
		return "GoogleUser [id=" + id + "]";
	}
	
	
}


