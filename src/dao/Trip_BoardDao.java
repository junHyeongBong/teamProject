package dao;

import java.util.List;
import java.util.Map;

import model.Reply;
import model.Trip_Board;

public interface Trip_BoardDao {
	public int insertTripBoard(Trip_Board trip_board);
	public int updateTripBoard(Trip_Board trip_board);
	public int deleteTripBoard(int trip_board_num);
	
	public Trip_Board selectOneTripBoard(int trip_board_num);
	public Trip_Board selectBestRecoTripBoard();
	
	public int viewCountUpTripBoard(int trip_board_num);
	public int recommendUpDownTripBoard(Map<String, Object> params);
	
	public int totalPaging(Map<String, Object> params);
	public List<Trip_Board> totalTripBoardList(Map<String, Object> params);
	
	public int searchTripBoardPaging(Map<String, Object> params);
	public List<Trip_Board> searchTripBoardByOption(Map<String, Object> params);
	
	public List<Trip_Board> searchMyTripBoard(Map<String,Object> params);
	
	public int recruitCountUp(int trip_board_num);
}
