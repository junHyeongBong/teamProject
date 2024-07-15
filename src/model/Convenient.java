package model;

public class Convenient {
	private int convenient_index;
	private String convenient_name;
	private String convenient_type;
	private String convenient_address;
	private Double convenient_laty;
	private Double convenient_lngx;
	
	public int getConvenient_index() {
		return convenient_index;
	}
	public String getConvenient_name() {
		return convenient_name;
	}
	public String getConvenient_type() {
		return convenient_type;
	}
	public String getConvenient_address() {
		return convenient_address;
	}
	public Double getConvenient_laty() {
		return convenient_laty;
	}
	public Double getConvenient_lngx() {
		return convenient_lngx;
	}
	public void setConvenient_index(int convenient_index) {
		this.convenient_index = convenient_index;
	}
	public void setConvenient_name(String convenient_name) {
		this.convenient_name = convenient_name;
	}
	public void setConvenient_type(String convenient_type) {
		this.convenient_type = convenient_type;
	}
	public void setConvenient_address(String convenient_address) {
		this.convenient_address = convenient_address;
	}
	public void setConvenient_laty(Double convenient_laty) {
		this.convenient_laty = convenient_laty;
	}
	public void setConvenient_lngx(Double convenient_lngx) {
		this.convenient_lngx = convenient_lngx;
	}
	
	@Override
	public String toString() {
		return "Convenient [convenient_index=" + convenient_index + ", convenient_name=" + convenient_name
				+ ", convenient_type=" + convenient_type + ", convenient_address=" + convenient_address
				+ ", convenient_laty=" + convenient_laty + ", convenient_lngx=" + convenient_lngx + "]";
	}
}
