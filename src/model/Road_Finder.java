package model;

import java.util.Date;
import java.util.List;

public class Road_Finder {
	private int road_finder_index;
	private int daily_trip_index;
	private String road_finder_transport_type;
	private int road_finder_routesindex;
	private String road_finder_filename;
	private Date road_finder_regdate;
	private List<Road_Finder> road_finderList;
	
	public int getRoad_finder_index() {
		return road_finder_index;
	}
	public int getDaily_trip_index() {
		return daily_trip_index;
	}
	public String getRoad_finder_transport_type() {
		return road_finder_transport_type;
	}
	public String getRoad_finder_filename() {
		return road_finder_filename;
	}
	public Date getRoad_finder_regdate() {
		return road_finder_regdate;
	}
	public List<Road_Finder> getRoad_finderList() {
		return road_finderList;
	}
	public void setRoad_finder_index(int road_finder_index) {
		this.road_finder_index = road_finder_index;
	}
	public void setDaily_trip_index(int daily_trip_index) {
		this.daily_trip_index = daily_trip_index;
	}
	public void setRoad_finder_transport_type(String road_finder_transport_type) {
		this.road_finder_transport_type = road_finder_transport_type;
	}
	public void setRoad_finder_filename(String road_finder_filename) {
		this.road_finder_filename = road_finder_filename;
	}
	public void setRoad_finder_regdate(Date road_finder_regdate) {
		this.road_finder_regdate = road_finder_regdate;
	}
	public void setRoad_finderList(List<Road_Finder> road_finderList) {
		this.road_finderList = road_finderList;
	}
	
	public int getRoad_finder_routesindex() {
		return road_finder_routesindex;
	}
	public void setRoad_finder_routesindex(int road_finder_routesindex) {
		this.road_finder_routesindex = road_finder_routesindex;
	}
	@Override
	public String toString() {
		return "Road_Finder [road_finder_index=" + road_finder_index + ", daily_trip_index=" + daily_trip_index
				+ ", road_finder_transport_type=" + road_finder_transport_type + ", road_finder_routesindex="
				+ road_finder_routesindex + ", road_finder_filename=" + road_finder_filename + ", road_finder_regdate="
				+ road_finder_regdate + ", road_finderList=" + road_finderList + "]";
	}
}
