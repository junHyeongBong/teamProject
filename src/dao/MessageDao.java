package dao;

import java.util.List;
import java.util.Map;

import model.Message;

public interface MessageDao {
	public int insertMessage(Message message);
	public int updateMessage(Message message);
	public int deleteReceiveMessage(int message_num);
	public int deleteSendMessage(int message_num);
	public int updateIsRead(int message_num);
	
	public int deleteMessage(int message_num);
	
	public Message selectOne(int message_num);
	public List<Message> selectPrivateList();
	public List<Message> selectReceiveMsgList(Map<String,Object> params);
	public List<Message> selectSendMsgList(Map<String,Object> params);
	public int selectReceiveCount(Map<String,Object> params);
	public int selectSendCount(Map<String,Object> params);
	public int selectReceiveNoReadCount(String member_id);
	public int selectSendNoReadCount(String member_id);
	public String selectFriendList(String member_id);
	public String selectIgnoredList(String member_id);
	
	public String checkDeleteSender(int message_num);
	public String checkDeleteReceiver(int message_num);
	
}
