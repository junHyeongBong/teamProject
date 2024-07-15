package dao;

import java.util.List;

import model.Daily_Trip;

public interface Daily_TripDao {
	public int insertDailyTrip(Daily_Trip daily_trip);
	public int updateDailyTrip(Daily_Trip daily_trip);
	public int deleteOneDailyTrip(int daily_trip_index);
	public int deleteAllDailyTripByBoardNum(int trip_board_num);
	public Daily_Trip selectOneDailyTrip(int daily_trip_index);
	public List<Daily_Trip> selectAllDailyTripByBoardNum(int trip_board_num);
	public List<Daily_Trip> selectAllDailyTrip();
}
