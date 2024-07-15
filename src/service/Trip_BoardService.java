package service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.executor.ReuseExecutor;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.Daily_TripDao;
import dao.Road_FinderDao;
import dao.Trip_BoardDao;
import model.Coordinate;
import model.Daily_Trip;
import model.Reply;
import model.Road_Finder;
import model.Trip_Board;

@Service
public class Trip_BoardService {

	@Autowired
	private Trip_BoardDao trip_boardDao;
	@Autowired
	private Daily_TripDao daily_tripDao;
	@Autowired
	private Road_FinderDao road_finderDao;

	final String jsonSavePath = "C:\\Project_TF\\json\\";

	public boolean WriteTripBoard(String member_id, String member_nick, String trip_board_title, String trip_board_startdate,
			String trip_board_enddate, int trip_board_nowcount, int trip_board_finalcount, String trip_board_recruit,
			String trip_board_bool, String trip_board_memo, String tmp) {
		boolean result = false;
		
		Trip_Board tb = new Trip_Board();
		tb.setMember_id(member_id);
		tb.setMember_nick(member_nick);
		tb.setTrip_board_title(trip_board_title);
		tb.setTrip_board_startdate(trip_board_startdate);
		tb.setTrip_board_enddate(trip_board_enddate);
		tb.setTrip_board_nowcount(trip_board_nowcount);
		tb.setTrip_board_finalcount(trip_board_finalcount);
		tb.setTrip_board_recruit(trip_board_recruit);
		tb.setTrip_board_bool(trip_board_bool);
		tb.setTrip_board_memo(trip_board_memo);
		System.out.println("트립보드 : " + tb);
		
//		if(trip_boardDao.insertTripBoard(tb) > 0) {
//			System.out.println("트립보드 등록 성공");
//			JSONObject jobject = new JSONObject(tmp);
//			JSONArray fullData = jobject.getJSONArray("fullData");
//			for(int i =0;i< fullData.length();i++) {
//				JSONObject obj = fullData.getJSONObject(i);
//				JSONArray timeTable = obj.getJSONArray("timeTable");
//				JSONArray transportList = obj.getJSONArray("transportList");
//				JSONArray jsonList = obj.getJSONArray("jsonList");
//				Daily_Trip dt = writeDailyTrip(tb.getTrip_board_num(), timeTable);
//				if(daily_tripDao.insertDailyTrip(dt)>0) {
//					System.out.println("데일리트립 등록 성공");
//					List<Road_Finder> rfList = writeRoadFinder(member_nick, tb.getTrip_board_num(), dt.getDaily_trip_index(), transportList, jsonList);
//					for(Road_Finder rf : rfList) {
//						if(road_finderDao.insertRoadFinder(rf)>0) {
//							System.out.println("로드파인더 등록 성공");
//							result = true;
//						}else {
//							result = false;
//						}
//					}
//				}
//			}
//		}
		trip_boardDao.insertTripBoard(tb);
		System.out.println(tb.getTrip_board_num());
		return result;
	}
	
	
	
	public String sipal(String allData) {
//		System.out.println(allData);
//		String fuckyou = URLDecoder.decode(allData, "UTF-8");
//		System.out.println(fuckyou);
		String result = "";
		JSONObject tripBoardAllData = new JSONObject(allData);
//		JSONArray tripBoardAllData = new JSONArray(allData);
		JSONObject tripBoardData = tripBoardAllData.getJSONObject("tripBoardData");
//		JSONObject tripBoardData = tripBoardAllData.getJSONObject(0);
		
		System.out.println(tripBoardData);
		Trip_Board tb = new Trip_Board();
		tb.setMember_id(tripBoardData.getString("member_id"));
		tb.setMember_nick(tripBoardData.getString("member_nick"));
		tb.setTrip_board_title(tripBoardData.getString("trip_board_title"));
		tb.setTrip_board_startdate(tripBoardData.getString("trip_board_startdate"));
		tb.setTrip_board_enddate(tripBoardData.getString("trip_board_enddate"));
		tb.setTrip_board_nowcount(Integer.parseInt(tripBoardData.getString("trip_board_nowcount")));
		tb.setTrip_board_finalcount(Integer.parseInt(tripBoardData.getString("trip_board_finalcount")));
		if(tripBoardData.getBoolean("trip_board_recruit")) {
			tb.setTrip_board_recruit("true");
		}else {
			tb.setTrip_board_recruit("false");
		}
		if(tripBoardData.getBoolean("trip_board_bool")) {
			tb.setTrip_board_bool("true");
		}else {
			tb.setTrip_board_bool("false");
		}
		tb.setTrip_board_memo(tripBoardData.getString("trip_board_memo"));
		
		if(trip_boardDao.insertTripBoard(tb)>0) {
			JSONArray dailyDataList = tripBoardAllData.getJSONArray("dailyData");
			for(int i =0;i< dailyDataList.length();i++) {
				JSONObject dailyData = dailyDataList.getJSONObject(i);
				JSONArray timeTable = dailyData.getJSONArray("timeTable");
				JSONArray transportList = dailyData.getJSONArray("transportList");
				JSONArray jsonList = dailyData.getJSONArray("jsonList");
				Daily_Trip dt = writeDailyTrip(tb.getTrip_board_num(), timeTable);
				if(daily_tripDao.insertDailyTrip(dt)>0) {
					System.out.println(i+"일째 데일리트립 등록 성공");
					List<Road_Finder> rfList = writeRoadFinder(tb.getMember_nick(), tb.getTrip_board_num(), dt.getDaily_trip_index(), transportList, jsonList);
					for(Road_Finder rf : rfList) {
						if(road_finderDao.insertRoadFinder(rf)>0) {
							System.out.println("로드파인더 등록 성공");
							if(tb.getTrip_board_recruit().equals("true")) {
								result = "tripBoardRecruitList";
							}else {
								result = "tripBoardBoolList";
							}
						}else {
							result = "rf_fail";
						}
					}
				}else {
					result = "dt_fail";
				}
			}
		}else {
			result = "tb_fail";
		}
		return result;
	}

	public Daily_Trip writeDailyTrip(int trip_board_num, JSONArray timeTable) {
		Daily_Trip dt = new Daily_Trip();
		
		for(int i=0; i<timeTable.length(); i++) {
			if(timeTable.get(i).toString().equals("")) {
				timeTable.put(i, 0);
			}
		}
		dt.setTrip_board_num(trip_board_num);
		dt.setReserve_stay_index(0);
		dt.setDaily_trip_time09_memo(timeTable.get(0).toString());
		dt.setDaily_trip_time09_address(timeTable.get(1).toString());
		dt.setDaily_trip_time09_laty(Double.parseDouble(timeTable.get(2).toString()));
		dt.setDaily_trip_time09_lngx(Double.parseDouble(timeTable.get(3).toString()));
		dt.setDaily_trip_time11_memo(timeTable.get(5).toString());
		dt.setDaily_trip_time11_address(timeTable.get(6).toString());
		dt.setDaily_trip_time11_laty(Double.parseDouble(timeTable.get(7).toString()));
		dt.setDaily_trip_time11_lngx(Double.parseDouble(timeTable.get(8).toString()));
		dt.setDaily_trip_time13_memo(timeTable.get(10).toString());
		dt.setDaily_trip_time13_address(timeTable.get(11).toString());
		dt.setDaily_trip_time13_laty(Double.parseDouble(timeTable.get(12).toString()));
		dt.setDaily_trip_time13_lngx(Double.parseDouble(timeTable.get(13).toString()));
		dt.setDaily_trip_time15_memo(timeTable.get(15).toString());
		dt.setDaily_trip_time15_address(timeTable.get(16).toString());
		dt.setDaily_trip_time15_laty(Double.parseDouble(timeTable.get(17).toString()));
		dt.setDaily_trip_time15_lngx(Double.parseDouble(timeTable.get(18).toString()));
		dt.setDaily_trip_time17_memo(timeTable.get(20).toString());
		dt.setDaily_trip_time17_address(timeTable.get(21).toString());
		dt.setDaily_trip_time17_laty(Double.parseDouble(timeTable.get(22).toString()));
		dt.setDaily_trip_time17_lngx(Double.parseDouble(timeTable.get(23).toString()));
		dt.setDaily_trip_time19_memo(timeTable.get(25).toString());
		dt.setDaily_trip_time19_address(timeTable.get(26).toString());
		dt.setDaily_trip_time19_laty(Double.parseDouble(timeTable.get(27).toString()));
		dt.setDaily_trip_time19_lngx(Double.parseDouble(timeTable.get(28).toString()));
		dt.setDaily_trip_time21_memo(timeTable.get(30).toString());
		dt.setDaily_trip_time21_address(timeTable.get(31).toString());
		dt.setDaily_trip_time21_laty(Double.parseDouble(timeTable.get(32).toString()));
		dt.setDaily_trip_time21_lngx(Double.parseDouble(timeTable.get(33).toString()));
//		System.out.println("데일리트립 : " + dt);

		return dt;
	}

	public List<Road_Finder> writeRoadFinder(String member_nick, int trip_board_num, int daily_trip_index,
			JSONArray transportList, JSONArray jsonList) {
		
		List<Road_Finder> resultList = new ArrayList<Road_Finder>();
		
		for(int i=0; i<jsonList.length(); i++) {
			Road_Finder rf = new Road_Finder();
			String saveJsonName = member_nick + "_" + trip_board_num + "_" + daily_trip_index + "_road"+i+".json";
//			System.out.println(jsonSavePath + saveJsonName);
			try {
				FileUtils.writeStringToFile(new File(jsonSavePath + saveJsonName), jsonList.get(i).toString(), "UTF-8");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			rf.setDaily_trip_index(daily_trip_index);
			rf.setRoad_finder_transport_type(transportList.get(i).toString());
			rf.setRoad_finder_routesindex(0);
			rf.setRoad_finder_filename(saveJsonName);
//			System.out.println("로드파인더" + rf);
			resultList.add(rf);
		}
		return resultList;
	}

	public List<Object> totalBoardListAndPaging(Map<String, Object> params) {
		List<Object> resultList = new ArrayList<Object>();

		List<Trip_Board> tmpTBList = trip_boardDao.totalTripBoardList(params);
		for (Trip_Board tb : tmpTBList) {
			tb.setTrip_board_startdate(tb.getTrip_board_startdate().split(" ")[0]);
			tb.setTrip_board_enddate(tb.getTrip_board_enddate().split(" ")[0]);
		}
		resultList.add(tmpTBList);

		List<Integer> paging = new ArrayList<Integer>();
		int totalTripBoardCount = trip_boardDao.totalPaging(params);
		if (totalTripBoardCount % 6 == 0) {
			for (int i = 1; i <= totalTripBoardCount / 6; i++) {
				paging.add(i);
			}
		} else {
			for (int i = 1; i <= (totalTripBoardCount / 6) + 1; i++) {
				paging.add(i);
			}
		}
		resultList.add(paging);

		return resultList;
	}

	public List<Object> searchTripBoardByOptionAndPaging(Map<String, Object> params) {
		List<Object> resultList = new ArrayList<Object>();

		List<Trip_Board> tmpTBList = trip_boardDao.searchTripBoardByOption(params);
		for (Trip_Board tb : tmpTBList) {
			tb.setTrip_board_startdate(tb.getTrip_board_startdate().split(" ")[0]);
			tb.setTrip_board_enddate(tb.getTrip_board_enddate().split(" ")[0]);
		}
		resultList.add(tmpTBList);

		List<Integer> paging = new ArrayList<Integer>();
		int totalTripBoardCount = trip_boardDao.searchTripBoardPaging(params);
		if (totalTripBoardCount % 6 == 0) {
			for (int i = 1; i <= totalTripBoardCount / 6; i++) {
				paging.add(i);
			}
		} else {
			for (int i = 1; i <= (totalTripBoardCount / 6) + 1; i++) {
				paging.add(i);
			}
		}
		resultList.add(paging);

		return resultList;
	}

	public Trip_Board selectBestRecoTripBoard() {
		Trip_Board tb = trip_boardDao.selectBestRecoTripBoard();
		tb.setTrip_board_startdate(tb.getTrip_board_startdate().split(" ")[0]);
		tb.setTrip_board_enddate(tb.getTrip_board_enddate().split(" ")[0]);
		return tb;
	}


	public Trip_Board selectOneTripBoard(int trip_board_num) {
		Trip_Board tb = trip_boardDao.selectOneTripBoard(trip_board_num);
		tb.setTrip_board_startdate(tb.getTrip_board_startdate().split(" ")[0]);
		tb.setTrip_board_enddate(tb.getTrip_board_enddate().split(" ")[0]);
		if(tb != null) {
			trip_boardDao.viewCountUpTripBoard(trip_board_num);
		}
		return tb;
	}

	public List<Daily_Trip> selectAllDailyTripByTripBoard(int trip_board_num) {
		List<Daily_Trip> resultList = daily_tripDao.selectAllDailyTripByBoardNum(trip_board_num);
		
		for(Daily_Trip dt : resultList) {
			if(dt.getDaily_trip_time09_memo().equals("0")) {
				dt.setDaily_trip_time09_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time11_memo().equals("0")) {
				dt.setDaily_trip_time11_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time13_memo().equals("0")) {
				dt.setDaily_trip_time13_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time15_memo().equals("0")) {
				dt.setDaily_trip_time15_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time17_memo().equals("0")) {
				dt.setDaily_trip_time17_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time19_memo().equals("0")) {
				dt.setDaily_trip_time19_memo("일정이 없습니다.");
			}
			if(dt.getDaily_trip_time21_memo().equals("0")) {
				dt.setDaily_trip_time21_memo("일정이 없습니다.");
			}
		}
		return resultList;
	}

	public List<String> loadingRoadJson(int daily_trip_index) {
		List<String> jsonList = new ArrayList<String>();

		List<Road_Finder> rfList = road_finderDao.selectAllRoadFinderByDailyIndex(daily_trip_index);
		
		for (Road_Finder rf : rfList) {
//			System.out.println(rf);
			String road_finder_transport_type = rf.getRoad_finder_transport_type();
			int road_finder_routesindex = rf.getRoad_finder_routesindex();
			String road_finder_filename = rf.getRoad_finder_filename();

			String jsonText = road_finder_transport_type + "^" + road_finder_routesindex + "^";
			try {
				String tmpLine;
				BufferedReader bfReader = new BufferedReader(
						new FileReader(new File(jsonSavePath, road_finder_filename)));
				while ((tmpLine = bfReader.readLine()) != null) {
					jsonText += tmpLine;
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			jsonList.add(jsonText);
		}
//		for(String s : jsonList) {
//			System.out.println(s);
//		}
		return jsonList;
	}

	public Boolean deleteTripBoard(int trip_board_num) {
		System.out.println(trip_board_num);
		List<Daily_Trip> dailyTripList = daily_tripDao.selectAllDailyTripByBoardNum(trip_board_num);
		int resultTmp = 0;
		for(Daily_Trip dt : dailyTripList) {
			road_finderDao.deleteAllRoadFinderByDailyIndex(dt.getDaily_trip_index());
			System.out.println("로드파인더 삭제완료");
			if(daily_tripDao.deleteOneDailyTrip(dt.getDaily_trip_index()) > 0) {
				resultTmp = 1;
			}else {
				return false;
			}
		}
		System.out.println("데일리트립 삭제완료");
		if (resultTmp == 1) {
			if (trip_boardDao.deleteTripBoard(trip_board_num) > 0) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public Boolean tripBoardRecruitUpDown(int trip_board_num) {
		if(trip_boardDao.recruitCountUp(trip_board_num)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	public Boolean tripBoardRecommendUpDown(String upDown, int trip_board_num) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("upDown", upDown);
		params.put("trip_board_num", trip_board_num);
//		System.out.println(upDown);
//		System.out.println(trip_board_num);
		if(trip_boardDao.recommendUpDownTripBoard(params)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	
}
