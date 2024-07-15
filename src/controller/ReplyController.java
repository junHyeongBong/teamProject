package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Reply;
import service.ReplyService;

@Controller
@RequestMapping("/common")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	
//	@RequestMapping(value = "/List", method=RequestMethod.POST)
	@RequestMapping("/repliesList")
	@ResponseBody
//	public List<Reply> boardView(@RequestParam(value="num") int trip_board_num) {
	public List<Reply> boardView(int trip_board_num) {
//		System.out.println("들어오나1");
		return replyService.getReplyList(trip_board_num);
	}
	
	
	//댓글 등록
	@ResponseBody
	@RequestMapping(value="/replySave", method=RequestMethod.POST)
	public Object boardReplySave(@RequestParam Map<String, Object> paramMap) {
		//리턴값
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		//패스워드 암호화
//		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
//		String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
//		paramMap.put("reply_password", password);
		
		//정보입력
		int result = replyService.regReply(paramMap);
		
		if(result>0) {
			retVal.put("code", "OK");
			retVal.put("reply_num", paramMap.get("reply_num"));
			retVal.put("parent_id", paramMap.get("parent_id"));
			retVal.put("message", "등록에 성공하였습니다.");
		}else {
			retVal.put("code", "FAIL");
			retVal.put("message", "등록에 실패 하였습니다");
		}
		return retVal;
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value="/replyDelete", method=RequestMethod.POST)
	public Object boardReplyDel(@RequestParam Map<String, Object> paramMap) {
		
		//리턴 값
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		//패스워드 암호화
//		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
//		String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
//		paramMap.put("reply_password", password);
		
		int result = 0;
//		paramMap.put("reply_type", "main");
//		paramMap.put("reply_type", "sub");
		
//		result = replyService.delReply(paramMap);
		//정보입력
		if(paramMap.get("reply_type").equals("main")) {
			 result = replyService.deleteBoardReplyAll(paramMap);
		}
		if(paramMap.get("reply_type").equals("sub")) {
			result = replyService.deleteBoardReply(paramMap);
		}
		
//		int result = replyService.delReply(paramMap);
		
		if(result>0) {
			retVal.put("code", "OK");
		}else {
			retVal.put("code", "FAIL");
			retVal.put("message", "삭제에 실패하엿습니다. 패스워드 확인좀ㅋ");
		}
		return retVal;
	}
	
	//댓글 패스워드 확인
//	@ResponseBody
//	@RequestMapping(value="/replyPassCheck", method=RequestMethod.POST)
//	public Object boardReplyCheck(@RequestParam Map<String, Object> paramMap) {
//		
//		Map<String, Object> retVal = new HashMap<String,Object>();
//		
//		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
//		String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
//		paramMap.put("reply_password", password);
//		
		//정보 입력
//		boolean check = replyService.checkReply(paramMap);
//		
//		if(check) {
//			retVal.put("code", "OK");
//			retVal.put("reply_num", paramMap.get("reply_num"));
//		}else {
//			retVal.put("code", "FAIL");
//			retVal.put("message", "패스워드를 확인해 주세요 ㅋ");
//		}
//		return retVal;
//	}
	
	//댓글수정
	@ResponseBody
	@RequestMapping(value="/replyUpdate", method=RequestMethod.POST)
	public Object boardReplyUpdate(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String,Object>();
		
//		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
//		String password = encoder.encodePassword(paramMap.get("reply_password").toString(), null);
//		paramMap.put("reply_password", password);
		
		System.out.println(paramMap);
		
		//정보 입력
		boolean check = replyService.updateReply(paramMap);
		
		if(check) {
			retVal.put("code", "OK");
			retVal.put("reply_num", paramMap.get("reply_num"));
			retVal.put("message", "수정에 성공하였습니다.");
		}else {
			retVal.put("code", "FAIL");
			retVal.put("message", "수정에 실패하였습니다.");
		}
		return retVal;
	}
}
