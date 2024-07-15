package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import common.ExceptionPrint;
import common.MediaSelector;
import model.Daily_Trip;
import model.Member;
import model.Road_Finder;
import model.Trip_Board;
import service.MemberService;
import service.ReplyService;
import service.Trip_BoardService;

@Controller
@RequestMapping("/common")
public class BoardController {
	
	@Autowired
	private Trip_BoardService trip_boardService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/tripBoardWriteForm")
	public String tripBoardWriteForm() {
		return "tripBoardWriteForm";
	}
	
	@RequestMapping(value="/tripBoardWrite", produces="application/json; charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String writingBoard(@RequestBody String allData) {
//	public String writingBoard(String allData) {
//		System.out.println("??"+allData);
//		System.out.println("??뭐야");
		String result = "";
		String answer = trip_boardService.sipal(allData);
		System.out.println(answer);
		if(answer.equals("tripBoardRecruitList")) {
			result = "{\"result\" : \"tripBoardRecruitList\" }";
		}else if(answer.equals("tripBoardBoolList")) {
			result = "{\"result\" : \"tripBoardBoolList\" }";
		}else if(answer.equals("rf_fail")) {
			result = "{\"result\" : \"경로등록에 실패하였습니다.\" }";
		}else if(answer.equals("tripBoardRecruitList")) {
			result = "{\"result\" : \"일일 여행 정보등록에 실패하였습니다.\" }";
		}
		return result;
		
	}
	
//	@RequestMapping(value="/fucking", produces="application/text; charset=UTF-8", method=RequestMethod.POST)
//	@ResponseBody
//	public String writingDaily(String tmp) {
////		if(trip_boardService.sipal(member_nick, trip_board_num, tmp)) {
////			return "{\"result\" : success }";
////		}else {
//			return "{\"result\" : fail }";
////		}
//	}
	
	@RequestMapping("/tripBoardBoolList")
	public String tripBoardBool() {
		return "tripBoardBoolList";
	}
	@RequestMapping("/tripBoardRecruitList")
	public String tripBoardRecruit() {
		return "tripBoardRecruitList";
	}
	
	@RequestMapping("/totalTripBoardListAndPaging")
	@ResponseBody
	public List<Object> totalTripBoardListAndPaging(String pageType, String sortType, int selectpage){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageType", pageType);
		params.put("sortType", sortType);
		params.put("paging", (selectpage-1)*6);
		
		List<Object> resultList = trip_boardService.totalBoardListAndPaging(params);
		
		
		return resultList;
	}
	
	@RequestMapping("/searchTripBoardAndPaging")
	@ResponseBody
	public List<Object> searchTripBoard(String pageType, String searchOption, String searchText, int selectPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("pageType", pageType);
		params.put("searchOption", searchOption);
		params.put("searchText", searchText);
		params.put("paging", (selectPage-1)*6);
		
		List<Object> resultBoardList = trip_boardService.searchTripBoardByOptionAndPaging(params);
		return resultBoardList;
	}
	
	@RequestMapping("/bestRecoTripBoard")
	@ResponseBody
	public Trip_Board bestRecoTripBoard() {
		return trip_boardService.selectBestRecoTripBoard();
	}
	
	@RequestMapping("/readOneTripBoard")
	public String readingOneBoard(String pageType, @RequestParam int trip_board_num, Model model) throws Exception{
		model.addAttribute("tripBoard", trip_boardService.selectOneTripBoard(trip_board_num));
//		System.out.println(pageType);
		if(pageType.equals("bool")) {
			return "tripBoardBoolView";
		}else if(pageType.equals("recruit")) {
			return "tripBoardRecruitView";
		}else {
			return "tripBoardBoolView";
		}
	}
	
	@RequestMapping("/readTripBoardWriterImg")
	public ResponseEntity<byte[]> displayImage(String writer_id, Principal principal){
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String UPLOAD_PATH = "C:\\Project_TF\\profile_img\\";
		String member_id = writer_id;
		String formatName = "profile."+memberService.getMemberOne(writer_id).getMember_pf_image(); 
		MediaType mType = MediaSelector.getMediaType(formatName);
		
		File fileCheck = new File(UPLOAD_PATH+member_id+"_"+formatName);
		System.out.println(fileCheck);
		if(fileCheck.exists()) {
			HttpHeaders headers = new HttpHeaders();
			try {
				in = new FileInputStream(UPLOAD_PATH+member_id+"_"+formatName);
			
				if(mType != null) {
					headers.setContentType(mType);
				}else {
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\"" + new String(formatName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
				}
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
				
			}catch (Exception e) {
//				logger.error(ExceptionPrint.stackTraceToString(e));
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				try {
					in.close();
				} catch (IOException e) {
//					logger.error(ExceptionPrint.stackTraceToString(e));
				}
			}
		}else {
			HttpHeaders headers = new HttpHeaders();
			try {
				in = new FileInputStream(UPLOAD_PATH+"default.png");
			
				if(mType != null) {
					headers.setContentType(mType);
				}else {
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\"" + new String(formatName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
				}
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
				
			}catch (Exception e) {
//				logger.error(ExceptionPrint.stackTraceToString(e));
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				try {
					in.close();
				} catch (IOException e) {
//					logger.error(ExceptionPrint.stackTraceToString(e));
				}
			}
		}
		
		
		
		return entity;
		
	}
	
	@RequestMapping("/readOneTripBoardAllDailyTrip")
	@ResponseBody
	public List<Daily_Trip> readOneTripBoardAllDailyTrip(int trip_board_num){
		return trip_boardService.selectAllDailyTripByTripBoard(trip_board_num);
	}
	
	
	@RequestMapping("/loadingRoad")
	@ResponseBody
	public List<String> loadingRoadJson(int daily_trip_index, HttpServletResponse response) throws IOException {
		System.out.println("들어옴");
		List<String> jsonList = trip_boardService.loadingRoadJson(daily_trip_index);
//		System.out.println(jsonList);
		return jsonList;
	}
	
	@RequestMapping("/tripBoardDelete")
	@ResponseBody
	public String deleteTripBoard(int trip_board_num) {
		if(trip_boardService.deleteTripBoard(trip_board_num)) {
			System.out.println("성공?");
			return "tripBoardBoolList";
		}else {
			System.out.println("실패?");
			return "readOneTripBoard?trip_board_num="+trip_board_num;
		}
	}
	
	@RequestMapping(value="/recommendUpDown", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String tripBoardRecommendUpDown(String upDown, int trip_board_num) {
		if(trip_boardService.tripBoardRecommendUpDown(upDown, trip_board_num)) {
			if(upDown.equals("up")) {
				return "추천되었습니다!";
			}else {
				return "비추천되었습니다!";
			}
		}else {
			return "추천에 실패하였습니다ㅠㅠ";
		}
	}
	
	
	
}