package service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import dao.AuthorityDao;
import dao.MemberDao;
import dao.RecruitDao;
import dao.RelationDao;
import model.Member;
import model.Recruit;
import model.Reply;
import model.Trip_Board;
import security.UserAccountChangedEvent;

@Service
public class MemberServiceImp implements MemberService, ApplicationEventPublisherAware{
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImp.class);
	private ApplicationEventPublisher publisher;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AuthorityDao authDao;
	
	@Autowired
	private RelationDao relaDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private RecruitDao recruitDao;
	
	@Transactional
	@Override
	public boolean join(Member member) throws Exception {
		String input_member_id = member.getMember_id();
		String input_member_type = member.getMember_type();
		String input_member_email = member.getMember_email();
		boolean isNormalUser = StringUtils.equals(input_member_type, "normal");
		
		if(isNormalUser) {
			String encryptedPW = passwordEncoder.encode(member.getMember_pw());
			member.setMember_pw(encryptedPW);
		}
		
		if(memberDao.insertMember(member)>0) {
			if(isNormalUser) {
				String key = new TempKey().getKey(50, false);
				logger.info(key);
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("member_email_authcode", key);
				params.put("member_id", input_member_id);
				if(memberDao.insertAuthcode(params)>0) {
					MailHandler sendMail = new MailHandler(mailSender);
					sendMail.setSubject("Project TF 이메일 인증");
					sendMail.setText(
							new StringBuilder().append("<a href='http://localhost:8081/Project_TF/common/emailConfirm?userEmail=")
							.append(input_member_email)
							.append("&key=")
							.append(key)
							.append("' target='_blank'>")
							.append("<img src='https://i.imgur.com/NvyGjy6.png'></a>")
							.toString()
							);
					sendMail.setFrom("TF_Auth@tf.com", "Project_TF");
					sendMail.setTo(input_member_email);
					sendMail.send();
					return true;
				}
			}else {
				if(memberDao.reviveMember(input_member_id)>0 && authDao.insertUserAuthorities(input_member_id)>0){
					return true;
				}
			}
		}
		return false;
	}
	
	@Transactional
	@Override
	public boolean authMember(String userEmail, String key) {
		String input_member_id = memberDao.emailToId(userEmail);
		String input_member_email_authcord = memberDao.checkAuthcode(input_member_id);
		
		if(StringUtils.equals(key, input_member_email_authcord)) {
			if(memberDao.reviveMember(input_member_id)>0) {
				if(authDao.insertUserAuthorities(input_member_id)>0){
					memberDao.deleteAuthcode(input_member_id); //DB에 등록된 이메일 인증코드와 메모를 지운다.(NULL)
					memberDao.deleteBoolMemo(input_member_id);
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public boolean updtMember(Member member) {
		if(StringUtils.equals(member.getMember_type(), "normal")) {
			String encryptedPW = passwordEncoder.encode(member.getMember_pw());
			member.setMember_pw(encryptedPW);
		}
		
		if(memberDao.updateMember(member)>0) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean updateMemberEmail(String member_id, String member_email) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_email", member_email);
		params.put("member_id", member_id);
		if(memberDao.updateEmail(params)>0) {
			UserAccountChangedEvent event = new UserAccountChangedEvent(this, member_id);
			publisher.publishEvent(event);
			return true;
		}
		return false;
	}
	
	@Override
	public boolean updateMemberPassword(String member_id, String member_pw) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_pw", passwordEncoder.encode(member_pw));
		params.put("member_id", member_id);
		if(memberDao.updatePw(params)>0) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean updateMemberNick(String member_id, String member_nick) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("member_nick", member_nick);
		if(memberDao.updateNick(params)>0) {
			UserAccountChangedEvent event = new UserAccountChangedEvent(this, member_id);
			publisher.publishEvent(event);
			return true;
		}
		return false;
	}
	
	@Override
	public boolean leave(String member_id) {
		Map<String, Object> params = new HashMap<String, Object>();
		Date today = new Date();
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
		
		String member_bool_memo = date.format(today)+" 탈퇴 신청";
		
		params.put("member_id", member_id);
		params.put("member_bool_memo", member_bool_memo);
		if(memberDao.boolMember(params)>0){
			return true;
		}
		return false;
	}
	
	@Override
	public boolean updateProfileImage(String member_id, String member_pf_image) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("member_pf_image", member_pf_image);
		if(memberDao.updateProfileImage(params)>0) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deleteProfileImage(String member_id) {
		if(memberDao.deleteProfileImage(member_id)>0) {
			return true;
		}
		return false;
	}
	
	@Override
	public Member getMemberOne(String member_id) {
		return memberDao.selectOne(member_id);
	}

	@Override
	public List<Member> getMemberList() {
		return memberDao.selectAll();
	}

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		// 로그인 처리(권한과, userid등을 session에 저장)를 spring이 처리
		// 로그아웃도 spring에게 위임
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
	}
	
	@Override
	public boolean checkMemberID(String member_id) {
		boolean result;
		if(memberDao.checkID(member_id)==null) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	
	@Override
	public boolean checkMemberEmail(String member_id, String member_email) {
		boolean result;
		
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("member_email", member_email);
		
		if(memberDao.checkEmail(params)==null) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public String sendAuthEmailForMod(String member_email) throws Exception {
		String key = new TempKey().getKey(6, false);
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("Project TF 이메일 변경 코드");
		sendMail.setText(
				new StringBuilder().append("<img src='https://i.imgur.com/KkKnjsF.png'>")
				.append("<h2>이메일 변경 코드</h2>")
				.append(key)
				.toString()
				);
		sendMail.setFrom("TF_Auth@tf.com", "Project_TF");
		sendMail.setTo(member_email);
		sendMail.send();
		return key;
	}
	
	@Override
	public boolean checkPasswordMatch(String member_id, String member_pw) {
		if(passwordEncoder.matches(member_pw, memberDao.checkPw(member_id))){
			return true;
		}
		return false;
	}
	
	@Override
	public boolean checkNickDup(String member_id, String member_nick) {
		boolean result;
		
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("member_nick", member_nick);
		
		if(memberDao.checkNick(params)==null) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	
	@Override
	public boolean checkProfileIamge(String member_id) {
		if(StringUtils.isEmpty(memberDao.checkProfileImage(member_id))) {
			return false;
		}
		return true;
	}
	
	@Override
	public Map<String, Object> findMemberUserid(String member_email) {
		Map<String, Object> params = new HashMap<String, Object>();
		String emailToId = memberDao.emailToId(member_email); 
		
		if(memberDao.emailToId(member_email)==null) {
			params.put("isExist", false);
			params.put("member_id", null);
		}else {
			params.put("isExist", true);
			params.put("member_id", emailToId);
		}
		return params;
	}
	
	@Transactional
	@Override
	public boolean findMemberUserPw(String member_id) throws Exception {
		String tempPw = TempKey.tempPw();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("member_pw", passwordEncoder.encode(tempPw));
		if(memberDao.updatePw(params)>0) {
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("Project TF 임시 비밀번호");
			sendMail.setText(
					new StringBuilder()
					.append("<img src='https://i.imgur.com/KLyEF8S.png'>")
					.append("<h3>임시 비밀번호 : " + tempPw + "</h3>")
					.toString()
					);
			sendMail.setFrom("TF_Auth@tf.com", "Project_TF");
			sendMail.setTo(memberDao.checkOwnEmail(member_id));
			sendMail.send();
			return true;
		}
		return false;
	}
	
	@Override
	public String addMemberRelation(String member_id, String relation_id, String member_relation) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("relation_id", relation_id);
		params.put("member_relation", member_relation);
		
		String checkRela = relaDao.selectMemberRelation(params);
		Map<String,Object> result = new HashMap<String,Object>();
		Gson gson = new Gson();
		
		if(StringUtils.isEmpty(checkRela)) {
			if(relaDao.insertMemberRelation(params)>0) {
				return "{\"result\" : true}";
			}
			return "{\"result\" : false}";
		}else {
			result.put("checkRela", checkRela);
			result.put("result", false);
			return gson.toJson(result);
		}
	}
	
	@Override
	public boolean removeCheckedRelation(String member_id, List<String> checkedValues) {
//		int count = 0;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", member_id);
		params.put("checkedValues", checkedValues);
		
//			for(String checkedId : checkedValues) {
//				if(!deleteReceiveMessage(checkedId)) {
//					count++;
//				}
////			}
//		if(count==0) {
//			return true;
//		}else {
//			return false;
//		}
//		
			if(relaDao.deleteCheckedRelation(params)>0) {
				return true;
			}
		return false;
	}
	
	@Override
	public void setApplicationEventPublisher(ApplicationEventPublisher publisher) {
		this.publisher = publisher;
	}
	
	//성재작성
	public List<Trip_Board> writeMyBoard(Principal principal, int paging){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", principal.getName());
		params.put("paging", paging*10);
		return memberDao.selectAllMyTripBoard(params);
	}
	
	public List<Reply> writeMyReply(Principal principal, int paging){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("member_id", principal.getName());
		params.put("paging", paging*10);
		return memberDao.selectAllMyReply(params);
	}
	
	public String insertRecruitBoard(Recruit recruit) {
		if(recruitDao.checkRecruit(recruit) > 0) {
			return "이미 신청한 게시물입니다.";
		}else {
			if(recruitDao.insertRecruit(recruit)>0) {
				return "성공";
			}else {
				return "신청에 실패하였습니다. 다시 시도해주세요!";
			}
		}
	}
	
	public boolean recruitAcceptOrDeny(int recruit_index, String acceptDeny) {
		if(acceptDeny.equals("accept")) {
			if(recruitDao.recruitAccept(recruit_index)>0) {
				return true;
			}else {
				return false;
			}
		}else if(acceptDeny.equals("deny")) {
			if(recruitDao.deleteOneRecruit(recruit_index)>0) {
				return true;
			}else {
				return false;
			}
		}else {
			return false;
		}
	}
	
	public List<Recruit> recruitListByTripBoardNum(int trip_board_num){
		System.out.println("recruit 결과 : "+recruitDao.selectAllRecruitByBoardNum(trip_board_num));
		return recruitDao.selectAllRecruitByBoardNum(trip_board_num);
	}
}
