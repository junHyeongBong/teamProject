package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.common.io.ByteStreams;
import com.google.gson.Gson;

import common.ExceptionPrint;
import common.MediaSelector;
import model.Member;
import model.Message;
import model.Recruit;
import service.GoogleApiService;
import service.KakaoApiService;
import service.MemberService;
import service.MessageService;
import service.NaverApiService;
import service.NaverCaptchaService;
import service.Trip_BoardService;

@Controller
@RequestMapping("/common")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private Trip_BoardService tripBoardService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NaverApiService naverService;
	
	@Autowired
	private GoogleApiService googleService;
	
	@Autowired
	private KakaoApiService kakaoService;
	
	@Autowired
	private NaverCaptchaService naverCaptchaService;
	
	@Autowired
	private MessageService messageService;
	
	@RequestMapping("/memberList")
	public String memberList(Model model) {
		model.addAttribute("memberList", memberService.getMemberList());
		return "memberList";
	}	
	
	@RequestMapping("/loginUserInfo")
	public String main() {
		return "memberLoginUserInfo";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm(HttpServletRequest request, Model model) {
		Map<String, Object> flashParams = null;
		try{
			flashParams = (Map<String, Object>)RequestContextUtils.getInputFlashMap(request).get("flashParams");
		}catch(NullPointerException e) {
			flashParams = null;
		}
		Member memberInput = null;
		String msg = null;
		if(flashParams != null) {
			memberInput = (Member) flashParams.get("memberInput");
			msg = (String) flashParams.get("msg");
			model.addAttribute("memberInput", memberInput);
			model.addAttribute("msg", msg);
		}
		String captchaKey = naverCaptchaService.getCaptchaKey();
		String captchaImageUrl = naverCaptchaService.getCaptchaImageUrl(captchaKey);
		model.addAttribute("captchaKey", captchaKey);
		model.addAttribute("captchaImageUrl", captchaImageUrl);
		
		return "memberLogin";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		memberService.logout(request, response);
		return "redirect:/common/loginForm?logout=true";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/joinForm/sns")
	public String joinFormSns(HttpServletRequest request, Model model){
		Map<String, Object> flashParams = null;
		try{
			flashParams = (Map<String, Object>)RequestContextUtils.getInputFlashMap(request).get("flashParams");
		}catch(NullPointerException e) {
			flashParams = null;
		}
		Member apiMemberInfo = null;
		String msg = null;
		if(flashParams != null) {
			apiMemberInfo = (Member) flashParams.get("apiMemberInfo");
			model.addAttribute("apiMemberInfo", apiMemberInfo);
			msg = (String) flashParams.get("msg");
			model.addAttribute("msg", msg);
		}
		String captchaKey = naverCaptchaService.getCaptchaKey();
		String captchaImageUrl = naverCaptchaService.getCaptchaImageUrl(captchaKey);
		model.addAttribute("captchaKey", captchaKey);
		model.addAttribute("captchaImageUrl", captchaImageUrl);
		return "memberJoinSns";
	}
	
	@RequestMapping(value = "/join",method=RequestMethod.POST)
	public String join(Member member, String captchaKey, String captchaInput, RedirectAttributes ra) {
//		String inputMemberType = member.getMember_type();
		boolean inputIsNormalUser = StringUtils.equals(member.getMember_type(), "normal");
		if(!naverCaptchaService.isValidCaptcha(captchaKey, captchaInput)){
			if(inputIsNormalUser) {
				Map<String,Object> flashParams = new HashMap<String,Object>();
				flashParams.put("msg", "자동가입문자 입력 불일치");
				flashParams.put("memberInput", member);
				ra.addFlashAttribute("flashParams", flashParams);
				return "redirect:/common/loginForm?joinError=true";
			}else {
				Map<String,Object> flashParams = new HashMap<String,Object>();
				flashParams.put("msg", "자동가입문자 입력 불일치");
				flashParams.put("apiMemberInfo", member);
				ra.addFlashAttribute("flashParams", flashParams);
				return "redirect:/common/joinForm/sns";
			}
		}
		if(StringUtils.isEmpty(member.getMember_id())) {
			return "redirect:loginForm?regError=true";
		}
		
		try {
			if(memberService.join(member)) {
				if(inputIsNormalUser) {
					ra.addFlashAttribute("msg", "입력하신 이메일로 인증하시면 가입이 완료됩니다.");
				}else {
					ra.addFlashAttribute("msg", "가입하신 SNS버튼을 누르면 로그인이 완료됩니다.");
				}
				return "redirect:loginForm?join=true";
			}else {
				if (inputIsNormalUser) {
					Map<String,Object> flashParams = new HashMap<String,Object>();
					flashParams.put("msg", "회원 가입 실패");
					flashParams.put("memberInput", member);
					ra.addFlashAttribute("flashParams", flashParams);
					return "redirect:/common/loginForm?joinError=true";
				}else {
					Map<String,Object> flashParams = new HashMap<String,Object>();
					flashParams.put("msg", "회원 가입 실패");
					flashParams.put("apiMemberInfo", member);
					ra.addFlashAttribute("flashParams", flashParams);
					return "redirect:/common/joinForm/sns";
				}
			}
		}catch(Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
			
			if (inputIsNormalUser) {
				Map<String,Object> flashParams = new HashMap<String,Object>();
				flashParams.put("msg", "회원 가입 실패");
				flashParams.put("memberInput", member);
				ra.addFlashAttribute("flashParams", flashParams);
				return "redirect:/common/loginForm?joinError=true";
			}else {
				Map<String,Object> flashParams = new HashMap<String,Object>();
				flashParams.put("msg", "회원 가입 실패");
				flashParams.put("apiMemberInfo", member);
				ra.addFlashAttribute("flashParams", flashParams);
				return "redirect:/common/joinForm/sns";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/refreshCaptcha", method=RequestMethod.POST)
	public String refreshCaptcha() {
		String captchaKey = naverCaptchaService.getCaptchaKey();
		String captchaImageUrl = naverCaptchaService.getCaptchaImageUrl(captchaKey);
		Gson gson = new Gson();
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("captchaKey", captchaKey);
		result.put("captchaImageUrl", captchaImageUrl);
		String result2json = gson.toJson(result);
		return result2json;
	}
	
	@RequestMapping(value="/emailConfirm", method=RequestMethod.GET)
	public String emailConfirm(String userEmail, String key, RedirectAttributes ra) {
		
		try {
			if(memberService.authMember(userEmail, key)) {
				ra.addFlashAttribute("msg", "로그인이 가능합니다.");
				return "redirect:loginForm?confirm=true";
			}else {
				ra.addFlashAttribute("msg", "관리자에 문의하세요.");
				return "redirect:loginForm?confirm=false";
			}
		}catch(Exception e){
			logger.error(ExceptionPrint.stackTraceToString(e));
			ra.addFlashAttribute("msg", "관리자에 문의하세요.");
			return "redirect:loginForm?confirm=false";
		}
	}
	
	@RequestMapping("/myPage")
	public String myPage(Principal principal, Model model) {
		Member member = memberService.getMemberOne(principal.getName());
		member.setMember_pw(null);
		model.addAttribute("member", member);
		return "memberMyPage";
	}
	
	@ResponseBody
	@RequestMapping(value="/checkID", method=RequestMethod.POST)
	public String checkID(String member_id) {
		String result;
		
		if(memberService.checkMemberID(member_id)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkEmail", method=RequestMethod.POST)
	public String checkEmail(String member_id, String member_email) {
		String result;
		
		if(memberService.checkMemberEmail(member_id, member_email)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/sendAuthCode", method=RequestMethod.POST)
	public String sendAuthCode(String member_email) {
		String key = null;
		try {
			key = memberService.sendAuthEmailForMod(member_email);
		} catch (Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
		}
		return key;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String checkPw(String member_id, String member_pw) {
		String result;
		
		if(memberService.checkPasswordMatch(member_id, member_pw)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkNick", method=RequestMethod.POST)
	public String checkNick(String member_id, String member_nick) {
		String result;
		
		if(memberService.checkNickDup(member_id, member_nick)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateEmail", method=RequestMethod.POST)
	public String updateEmail(String member_id, String member_email) {
		String result;
		
		if(memberService.updateMemberEmail(member_id, member_email)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/updatePw", method=RequestMethod.POST)
	public String updatePw(String member_id, String member_pw) {
		String result;
		
		if(memberService.updateMemberPassword(member_id, member_pw)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateNick", method=RequestMethod.POST)
	public String updateNick(String member_id, String member_nick) {
		String result;
		
		if(memberService.updateMemberNick(member_id, member_nick)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@SuppressWarnings("finally")
	@RequestMapping("/update")
	public String memberUpdate(Member member, RedirectAttributes ra) {
		
		try {
			if(memberService.updtMember(member)) {
				ra.addFlashAttribute("", "정보 수정 성공");
			}else {
				ra.addFlashAttribute("msg", "정보 수정 실패");
			}
		}catch(Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
			ra.addFlashAttribute("msg", "정보 수정 실패");
		}finally {
			return "redirect:updateForm";
		}
	}
	
	@RequestMapping(value="/uploadPfImage", method=RequestMethod.POST)
	public void uploadProfileImage(MultipartHttpServletRequest request, HttpServletResponse response, Principal principal) {
		String UPLOAD_PATH = "C:\\Project_TF\\profile_img\\";
		String member_id = principal.getName();
		String filePath = null;
		String originalFileName = null;
		String formatName = null;
		Map<String, MultipartFile> fileMap = request.getFileMap();
		try {
			for(MultipartFile multipartFile : fileMap.values()) {
				originalFileName = multipartFile.getOriginalFilename();
				formatName = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				filePath = UPLOAD_PATH+member_id+"_profile."+formatName;
				File file = new File(filePath);
				if(!file.exists()) {
					file.mkdirs();
				}
				multipartFile.transferTo(file);
				memberService.updateProfileImage(member_id, formatName);
			}
			response.setContentType("text;");
			response.getWriter().write(filePath);
		}catch(Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/deletePfImage", method=RequestMethod.POST)
	public String deleteProfileImage(Principal principal) {
		String member_id = principal.getName();
		String result;
		if(memberService.deleteProfileImage(member_id)) {
			result = "{\"result\" : true}"; 
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value="/checkPfImage", method=RequestMethod.POST)
	public String checkProfileImage(Principal principal) {
		String member_id = principal.getName();
		String result;
		
		if(memberService.checkProfileIamge(member_id)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@RequestMapping(value="profile", method=RequestMethod.GET)
	public ResponseEntity<byte[]> displayImage(String fileName, boolean isDefault, Principal principal){
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String UPLOAD_PATH = "C:\\Project_TF\\profile_img\\";
		String member_id = principal.getName();
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = MediaSelector.getMediaType(formatName);
		
		HttpHeaders headers = new HttpHeaders();
		try {
			if(isDefault) {
				in = new FileInputStream(UPLOAD_PATH+"default.png");
			}else {
				in = new FileInputStream(UPLOAD_PATH+member_id+"_"+fileName);
			}
		
			if(mType != null) {
				headers.setContentType(mType);
			}else {
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
			}
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		}catch (Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			try {
				in.close();
			} catch (IOException e) {
				logger.error(ExceptionPrint.stackTraceToString(e));
			}
		}
		
		return entity;
		
	}
	
	
	@RequestMapping("/naver")
	public String naverLoginForm(HttpSession session, String loginType) {
		String naverAuthUrl = naverService.getAuthUrl(session);
		return "redirect:" + naverAuthUrl;
	}
	
	@RequestMapping("/naver/callback")
	public String naverCallBack(@RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes ra) {
		String accessToken = naverService.getAccessToken(code, state, session);
		Member getFromApi = naverService.getUserProfile(accessToken);
		Member getFromDB = memberService.getMemberOne(getFromApi.getMember_id());
		if (getFromDB == null) {
			Map<String,Object> flashParams = new HashMap<String,Object>();
			flashParams.put("apiMemberInfo", getFromApi);
			ra.addFlashAttribute("flashParams", flashParams);
			return "redirect:/common/joinForm/sns";
		}else {
			session.setAttribute("member_id", getFromApi.getMember_id());
			return "redirect:/common/apiLogin";
		}
	}
	
	@RequestMapping("/google")
	public String googleLoginForm(String loginType) {
		String googleAuthUrl = googleService.getAuthUrl();
		return "redirect:" + googleAuthUrl;
	}
	
	@RequestMapping("/google/callback")
	public String googleCallBack(@RequestParam String code, RedirectAttributes ra, HttpSession session) {
		String accessToken = googleService.getAccessToken(code);
		Member getFromApi = googleService.getUserProfile(accessToken);
		Member getFromDB = memberService.getMemberOne(getFromApi.getMember_id());
		if (getFromDB == null) {
			Map<String,Object> flashParams = new HashMap<String,Object>();
			flashParams.put("apiMemberInfo", getFromApi);
			ra.addFlashAttribute("flashParams", flashParams);
			return "redirect:/common/joinForm/sns";
		}else {
			session.setAttribute("member_id", getFromApi.getMember_id());
			return "redirect:/common/apiLogin";
		}
	}
	
	@RequestMapping("/kakao")
	public String kakaoLoginForm(String loginType) {
		String kakaoAuthUrl = kakaoService.getAuthUrl();
		return "redirect:" + kakaoAuthUrl;
	}
	
	@RequestMapping("/kakao/callback")
	public String kakaoCallBack(@RequestParam String code, RedirectAttributes ra, HttpSession session) {
		String accessToken = kakaoService.getAccessToken(code);
		Member getFromApi = kakaoService.getUserProfile(accessToken);
		Member getFromDB = memberService.getMemberOne(getFromApi.getMember_id());
		if (getFromDB == null) {
			Map<String,Object> flashParams = new HashMap<String,Object>();
			flashParams.put("apiMemberInfo", getFromApi);
			ra.addFlashAttribute("flashParams", flashParams);
			return "redirect:/common/joinForm/sns";
		}else {
			session.setAttribute("member_id", getFromApi.getMember_id());
			return "redirect:/common/apiLogin";
		}
	}
	
	@RequestMapping("/findAccount")
	public String findAccount() {
		return "memberFindAccount";
	}
	
	@ResponseBody
	@RequestMapping("/findAccount/userid")
	public String findUserid(String member_email) {
		Gson gson = new Gson();
		Map<String,Object> result = memberService.findMemberUserid(member_email);
		String result2json = gson.toJson(result);
		return result2json;
	}
	
	@ResponseBody
	@RequestMapping("/findAccount/userPw")
	public String findUserPw(String member_id) {
		String result;
		try {
			if(memberService.findMemberUserPw(member_id)) {
				result = "{\"result\" : true}";
			}else {
				result = "{\"result\" : false}";
			}
		} catch (Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
			result = "{\"result\" : false}";
		}
		
		return result;
	}
	
	@RequestMapping("/testBoard")
	public String tempBoardforTest(Principal principal, Model model) {
//		Member member = memberService.getMemberOne(principal.getName());
//		member.setMember_pw(null);
//		model.addAttribute("member", member);
		return "memberTestBoard";
	}
	
	@ResponseBody
	@RequestMapping("/addRelation")
	public String addRelation(String member_id, String relation_id, String member_relation) {
		return memberService.addMemberRelation(member_id, relation_id, member_relation);
	}
	
	@ResponseBody
	@RequestMapping("/removeCheckedRelation")
	public boolean removeCheckedRelation(@RequestParam(value="checkArray[]")List<String> checkedValues,
			String member_id) {
		return memberService.removeCheckedRelation(member_id, checkedValues);
	}
	
	@RequestMapping("/msgFriend")
	public String msgFriendList(Model model, Principal principal, @RequestParam(value="page", required=false)Integer page) {
		String member_id = principal.getName();
		int pageNumber = 1;
		if(page != null) {
			pageNumber = page;
		}
		Map<String,Object> viewData = messageService.getMsgFriendList(member_id, pageNumber);
		model.addAttribute("viewData", viewData);
		return "memberMsgFriend";
	}
	
	@RequestMapping("/msgIgnored")
	public String msgIgnoredList(Model model, Principal principal, @RequestParam(value="page", required=false)Integer page) {
		String member_id = principal.getName();
		int pageNumber = 1;
		if(page != null) {
			pageNumber = page;
		}
		Map<String,Object> viewData = messageService.getMsgIgnoredList(member_id, pageNumber);
		model.addAttribute("viewData", viewData);
		return "memberMsgIgnored";
	}
	
	@RequestMapping("/newMessage")
	public String newMessage(String message_receive_id, String message_receive_nick, Model model) {
		model.addAttribute("message_receive_id", message_receive_id);
		model.addAttribute("message_receive_nick", message_receive_nick);
		return "memberNewMessage";
	}
	
	@ResponseBody
	@RequestMapping(value="/sendMessage", produces="application/text; charset=UTF-8")
	public String sendMessage(Message message, Model model) throws Exception {
//		logger.info("발신id : " + message.getMessage_send_id());
//		logger.info("발신nick : " + message.getMessage_send_nick());
//		logger.info("수신id : " + message.getMessage_receive_id());
//		logger.info("수신nick : " + message.getMessage_receive_nick());
//		logger.info("제목 : " + message.getMessage_title());
//		logger.info("내용 : " + message.getMessage_content());
		String result = "";
		if(messageService.sendMessage(message)) {
			result = "{\"result\" : true, \"msg\" : \"쪽지가 전송되었습니다.\"}";
		}else {
			result = "{\"result\" : false, \"msg\" : \"쪽지 전송 실패\"}";
		}
		return result;
	}
	
	
	@MessageMapping("/message/{member_id}/{target_id}")
	@SendTo("/topic/message/{target_id}")
	public String notifyMessage(@DestinationVariable(value="member_id")String member_id, 
			@DestinationVariable(value="target_id")String target_id, String message) {
		return message;
	}
	
	@RequestMapping("/receiveMsgBox")
	public String receiveMsgBox(@RequestParam(defaultValue="1")Integer page,
			@RequestParam(required = false)String msg_search_keyword, 
			@RequestParam(defaultValue="default")String msg_search_type, Model model, Principal principal) {
		String member_id = principal.getName();
		Map<String,Object> viewData = messageService.getReceiveMessageList(msg_search_keyword, msg_search_type, member_id, page);
		model.addAttribute("viewDataReceive", viewData);
		return "memberReceiveMessage";
	}
	
	@RequestMapping("/sendMsgBox")
	public String sendMsgBox(@RequestParam(defaultValue="1")Integer page,
			@RequestParam(required = false)String msg_search_keyword,
			@RequestParam(defaultValue="default")String msg_search_type, Model model, Principal principal) {
		String member_id = principal.getName();
		Map<String,Object> viewData = messageService.getSendMessageList(msg_search_keyword, msg_search_type, member_id, page);
		model.addAttribute("viewDataSend", viewData);
		return "memberSendMessage";
	}
	
	@RequestMapping("/viewMessage")
	public String viewMessage(@RequestParam(value="num") int message_num,  Principal principal, Model model,
			@RequestParam(defaultValue="1")Integer page, @RequestParam(required = false)String msg_search_keyword, 
			@RequestParam(defaultValue="default")String msg_search_type) {
		
		Message message = messageService.getMessageOne(message_num);
		String member_id = principal.getName();
		if(StringUtils.equals(message.getMessage_receive_id(), member_id)) {
			messageService.checkIsRead(message_num);
		}
	
		Map<String,Object> viewDataReceive = messageService.getReceiveMessageList(msg_search_keyword, msg_search_type, member_id, page);
		Map<String,Object> viewDataSend = messageService.getSendMessageList(msg_search_keyword, msg_search_type, member_id, page);
		model.addAttribute("viewDataReceive", viewDataReceive);
		model.addAttribute("viewDataSend", viewDataSend);
		model.addAttribute("message", message);
		return "memberViewMessage";
	}
	
	@RequestMapping("/checkIsRead")
	public void checkIsRead(int message_num) {
		messageService.checkIsRead(message_num);
	}
	
	@ResponseBody
	@RequestMapping("/deleteMessage")
	public String deleteMessage(String which_message, int message_num, String message_id) {
		String result = null;
		if(StringUtils.equals(which_message, "receive")) {
			if(messageService.deleteReceiveMessage(message_num)) {
				result = "{\"result\" : true}";
			}else {
				result = "{\"result\" : false}";
			}
		}else {
			if(messageService.deleteSendMessage(message_num)) {
				result = "{\"result\" : true}";
			}else {
				result = "{\"result\" : false}";
			}
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/deleteCheckedMessage")
	public String deleteCheckedMessage(@RequestParam(value="checkArray[]")List<Integer> checkedValues, String which_message) {
		String result = null;
		if(messageService.deleteCheckedMessage(checkedValues, which_message)) {
			result = "{\"result\" : true}";
		}else {
			result = "{\"result\" : false}";
		}
		return result;
	}
	
	@RequestMapping(value="/recruitBoard", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String recruitTripBoard(Recruit recruit) {
		return memberService.insertRecruitBoard(recruit);
	}
	
	@RequestMapping(value="/recruitAcceptDeny", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String recruitAcceptDeny(int trip_board_num, int recruit_index, String acceptDeny) {
		if(tripBoardService.selectOneTripBoard(trip_board_num).getTrip_board_nowcount() < tripBoardService.selectOneTripBoard(trip_board_num).getTrip_board_finalcount()) {
			if(memberService.recruitAcceptOrDeny(recruit_index, acceptDeny)) {
				if(acceptDeny.equals("accept")) {
					if(tripBoardService.tripBoardRecruitUpDown(trip_board_num)) {
						return "승인되었습니다.";
					}else {
						return "정원이 초과되었습니다.";
					}
				}else {
					return "거절되었습니다.";
				}
			}else {
				return "다시 시도해주십시오.";
			}
		}else {
			return "정원이 초과되었습니다.";
		}
	}
	
	@RequestMapping("/recruitListByBoardNum")
	@ResponseBody
	public List<Recruit> recruitListByBoardNum(int trip_board_num) {
		return memberService.recruitListByTripBoardNum(trip_board_num);
	}
	
	
	@RequestMapping("/myBoard")
	public String myWriteBoard(Principal principal, int paging, Model model) {
		model.addAttribute("viewData", memberService.writeMyBoard(principal, paging));
		return "memberMyPageWrite";
	}
	
	@RequestMapping("/myReply")
	public String myWriteReply(Principal principal, int paging, Model model) {
		model.addAttribute("viewData", memberService.writeMyReply(principal, paging));
		return "memberMyPageReply";
	}
	
	@ResponseBody
	@RequestMapping(value="/myPage/leave", method=RequestMethod.POST )
	public String delMember(String member_id, HttpServletRequest request, HttpServletResponse response) {
		
		String result = "";
		
		if(memberService.leave(member_id)) {
//			result = "{\"result\" : true}";
			result = "true";
			memberService.logout(request, response);
		}else {
//			result = "{\"result\" : false}";
			result = "false";
		}
		return result;
	}
}

