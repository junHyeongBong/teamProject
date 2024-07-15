package test;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.AuthorityDao;
import dao.MemberDao;
import dao.MessageDao;
import dao.RelationDao;
import model.Member;
import model.Message;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:WebContent/WEB-INF/spring/root-Context.xml")
public class DaoTest {
	private static final Logger logger = LoggerFactory.getLogger(DaoTest.class);
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AuthorityDao authDao;
	
	@Autowired
	private RelationDao relaDao;
	
	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Test
	public void boardDaoTest() {
		
//		for(int i=71;i<=140;i++) {
//			Message msg = new Message();
//			msg.setMessage_title("쪽지 채워넣기 "+i);
//			msg.setMessage_send_id("tester");
//			msg.setMessage_send_nick("testman");
//			msg.setMessage_receive_id("lim1");
//			msg.setMessage_receive_nick("임꺽정");
//			msg.setMessage_content("쪽지 채워넣기 내용 "+i);
//			messageDao.insertMessage(msg);
//		}
		
		String temp = passwordEncoder.encode("1234");
		logger.info(temp);
		
//		Member member = new Member();
//		member.setMember_id("lim1");
//		member.setMember_type("normal");
//		member.setMember_pw("1234");
//		member.setMember_email("lim1@abc.com");
//		member.setMember_nick("의적");
//		member.setMember_gender("M");
			
//		memberDao.updateMember(member);
//		memberDao.insertMember(member);
//		memberDao.deleteMember("lim1");
		
//		System.out.println(memberDao.selectOne("hong1"));
//		System.out.println(memberDao.selectAll());
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_nick", "호부호형");
//		params.put("member_id", "hong1");
//		System.out.println(memberDao.checkNick(params));
		
//		memberDao.boolMember("hong1");
		
//		logger.info(memberDao.checkAuthcode("hong1"));
//		memberDao.boolMember("hong1");
//		memberDao.reviveMember("hong1");
//		logger.info(memberDao.emailToId("hong1@abc.com"));
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_email_authcode", "테스트코드");
//		params.put("member_id", "hong1");
//		memberDao.insertAuthcode(params);
//		memberDao.deleteAuthcode("hong1");
		
//		authDao.insertUserAuthorities("lim1");
//		authDao.deleteUserAuthorities("lim1");
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_bool_memo", "2018.08.11 탈퇴 신청");
//		params.put("member_id", "lim1");
//		memberDao.boolMember(params);
//		memberDao.reviveMember("lim1");
//		memberDao.deleteAuthcode("lim1");
//		memberDao.deleteBoolMemo("lim1");
//		logger.info(memberDao.adminSelectOne("lim1").toString());
//		logger.info(memberDao.adminSelectAll().toString());
//		logger.info(memberDao.checkPw("hong1"));
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_pw", "$2a$10$rdcp.vZ4G115d/XpZkM40eHsF9azKm5Z2HHoQQLXJfyuvMJni3uaK");
//		params.put("member_id", "lim1");
//		
//		memberDao.updateEmail(params);
//		memberDao.updatePw(params);
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_id", "hong1");
//		params.put("relation_id", "lim1");
//		params.put("member_relation", "ignored");
//		relaDao.insertMemberRelation(params);
//		relaDao.deleteMemberRelation(params);
//		logger.info(relaDao.selectMemberRelation(params));
		
//		Message message = new Message();
//		message.setMessage_title("제목1");
//		message.setMessage_send_id("hong1");
//		message.setMessage_send_nick("호부호형");
//		message.setMessage_receive_id("lim1");
//		message.setMessage_receive_nick("의적");
//		message.setMessage_content("내용1");
//		message.setMessage_isread("N");
//		messageDao.insertMessage(message);
		
//		Message message = new Message();
//		message.setMessage_title("제목12");
//		message.setMessage_send_id("lim1");
//		message.setMessage_send_nick("의적");
//		message.setMessage_receive_id("hong1");
//		message.setMessage_receive_nick("호부호형");
//		message.setMessage_content("내용12");
//		message.setMessage_isread("Y");
//		message.setMessage_del_sender("1");
//		message.setMessage_del_receiver("1");
//		message.setMessage_num(30);
//		messageDao.updateMessage(message);
//		messageDao.deleteMessage(1);
//		logger.info("셀렉트원 : " + messageDao.selectOne(30).toString());
//		logger.info("셀렉트올 : " + messageDao.selectPrivateList().toString());
		
//		messageDao.deleteSendMessage(30);
//		logger.info(messageDao.checkDeleteReceiver(31));
//		logger.info(messageDao.checkDeleteSender(31));
//		logger.info(messageDao.selectReceiveCount("lim1")+"");
		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("member_relation", "friend");
//		params.put("member_id", "lim1");
//		logger.info(memberDao.selectRelationList(params).toString());
//		logger.info(memberDao.selectRelationCount(params)+"");
	}
	
	
	
}
