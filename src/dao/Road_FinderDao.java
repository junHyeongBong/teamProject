package dao;

import java.util.List;

import model.Road_Finder;

public interface Road_FinderDao {
	public int insertRoadFinder(Road_Finder road_finder);
	public int updateRoadFinder(Road_Finder road_finder);
	public int deleteOneRoadFinder(int road_finder_index);
	public int deleteAllRoadFinderByDailyIndex(int daily_trip_index);
	public Road_Finder selectOneRoadFinder(int road_finder_index);
	public List<Road_Finder> selectAllRoadFinderByDailyIndex(int daily_trip_index);
	public List<Road_Finder> selectAllRoadFinder();
}
