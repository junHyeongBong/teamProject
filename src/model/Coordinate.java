package model;

public class Coordinate {
	private Double daumCoordY;
	private Double daumCoordX;
	private Double latY;
	private Double lngX;
	private String address;
	
	public Coordinate(Double latY, Double lngX, String address) {
		this.latY = latY;
		this.lngX = lngX;
		this.address = address;
	}
	
	
	
	public Coordinate(Double daumCoordY, Double daumCoordX, Double latY, Double lngX, String address) {
		super();
		this.daumCoordY = daumCoordY;
		this.daumCoordX = daumCoordX;
		this.latY = latY;
		this.lngX = lngX;
		this.address = address;
	}
	
	public Double getDaumCoordY() {
		return daumCoordY;
	}
	public Double getDaumCoordX() {
		return daumCoordX;
	}
	public Double getLatY() {
		return latY;
	}
	public Double getLngX() {
		return lngX;
	}
	public String getAddress() {
		return address;
	}
	public void setDaumCoordY(Double daumCoordY) {
		this.daumCoordY = daumCoordY;
	}
	public void setDaumCoordX(Double daumCoordX) {
		this.daumCoordX = daumCoordX;
	}
	public void setLatY(Double latY) {
		this.latY = latY;
	}
	public void setLngX(Double lngX) {
		this.lngX = lngX;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "Coordinate [daumCoordY=" + daumCoordY + ", daumCoordX=" + daumCoordX + ", latY=" + latY + ", lngX="
				+ lngX + ", address=" + address + "]";
	}
	
	
}
