package dao;

import java.util.List;
import java.util.Map;

import model.Member;
import model.Reply;
import model.Trip_Board;

public interface MemberDao {
	public int insertMember(Member member);
	public int updateMember(Member member);
	public int updateEmail(Map<String,Object> params);
	public int updatePw(Map<String,Object> params);
	public int updateNick(Map<String,Object> params);
	public int insertAuthcode(Map<String,Object> params);
	public int deleteAuthcode(String member_id);
	public int deleteBoolMemo(String member_id);
	public int updateProfileImage(Map<String,Object> params);
	public int deleteProfileImage(String member_id);
	
	public int deleteMember(String member_id);
	
	public Member selectOne(String member_id);
	public List<Member> selectAll();
	public String checkID(String member_id);
	public String checkOwnEmail(String member_id);
	public String checkEmail(Map<String,Object> params);
	public String checkNick(Map<String,Object> params);
	public String checkAuthcode(String member_id);
	public String checkPw(String member_id);
	public String emailToId(String member_email);
	public List<Member> selectRelationList(Map<String,Object> params);
	public int selectRelationCount(Map<String,Object> params);
	public String checkProfileImage(String member_id);
	public Member adminSelectOne(String member_id);
	public List<Member> adminSelectAll();
	
	public int boolMember(Map<String,Object> params);
	public int reviveMember(String member_id);
	
	public List<Trip_Board> selectAllMyTripBoard(Map<String, Object> params);
	public List<Reply> selectAllMyReply(Map<String, Object> params);
}
