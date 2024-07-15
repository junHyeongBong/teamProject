package service;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Member;
import model.Recruit;
import model.Reply;
import model.Trip_Board;

public interface MemberService {
	public boolean join(Member member) throws Exception;
	public boolean authMember(String userEmail, String key);
	public boolean updtMember(Member member);
	public boolean updateMemberEmail(String member_id, String member_email);
	public boolean updateMemberPassword(String member_id, String member_pw);
	public boolean updateMemberNick(String member_id, String member_nick);
	public boolean leave(String member_id);
	public boolean updateProfileImage(String member_id, String member_pf_image);
	public boolean deleteProfileImage(String member_id);
	public Member getMemberOne(String member_id);
	public List<Member> getMemberList();
	public void logout(HttpServletRequest request, HttpServletResponse response);
	public boolean checkMemberID(String member_id);
	public boolean checkMemberEmail(String member_id, String member_email);
	public String sendAuthEmailForMod(String member_email) throws Exception;
	public boolean checkPasswordMatch(String member_id, String member_pw);
	public boolean checkNickDup(String member_id, String member_nick);
	public boolean checkProfileIamge(String member_id);
	public Map<String, Object> findMemberUserid(String member_email);
	public boolean findMemberUserPw(String member_id) throws Exception;
	public String addMemberRelation(String member_id, String relation_id, String member_relation);
	public boolean removeCheckedRelation(String member_id, List<String> checkedValues);
	
	
	//성재작성
	public List<Trip_Board> writeMyBoard(Principal principal, int paging);
	public List<Reply> writeMyReply(Principal principal, int paging);
	public String insertRecruitBoard(Recruit recruit);
	public List<Recruit> recruitListByTripBoardNum(int trip_board_num);
	public boolean recruitAcceptOrDeny(int recruit_index, String acceptDeny);
}
