package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.MemberDao;
import dao.MessageDao;
import model.Member;
import model.Message;

@Service
public class MessageService {
	private static final Logger logger = LoggerFactory.getLogger(MessageService.class);
	private static final int NUM_OF_MESSAGE_PER_PAGE = 10;
	private static final int NUM_OF_NAVI_PAGE = 10;
	
	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private MemberDao memberDao;
	
	public boolean sendMessage(Message message) {
		if(messageDao.insertMessage(message)>0) {
			return true;
		}
		return false;
	}
	
	@Transactional
	public boolean deleteReceiveMessage(int message_num) {
		if(messageDao.deleteReceiveMessage(message_num)>0){
			if(StringUtils.equals(messageDao.checkDeleteSender(message_num), "1")) {
				if(messageDao.deleteMessage(message_num)>0) {
					return true;
				}
			}
			return true;
		}
		return false;
	}
	
	@Transactional
	public boolean deleteSendMessage(int message_num) {
		if(messageDao.deleteSendMessage(message_num)>0){
			if(StringUtils.equals(messageDao.checkDeleteReceiver(message_num), "1")  
					|| StringUtils.equals(messageDao.selectOne(message_num).getMessage_isread(), "N")) {
				if(messageDao.deleteMessage(message_num)>0) {
					return true;
				}
			}
			
			return true;
		}
		return false;
	}
	
	@Transactional
	public boolean deleteCheckedMessage(List<Integer> checkedValues, String which_message) {
		int count = 0;
		if(StringUtils.equals(which_message, "receive")) {
			for(int checkedNum : checkedValues) {
				if(!deleteReceiveMessage(checkedNum)) {
					count++;
				}
			}
		}else {
			for(int checkedNum : checkedValues) {
				if(!deleteSendMessage(checkedNum)) {
					count++;
				}
			}
		}
		if(count==0) {
			return true;
		}else {
			return false;
		}
	}
	
	public void checkIsRead(int message_num) {
		messageDao.updateIsRead(message_num);
	}
	
	public Message getMessageOne(int message_num) {
		return messageDao.selectOne(message_num);
	}
	
	public Map<String, Object> getMessageList(){
		Map<String, Object> viewData = new HashMap<String,Object>();
		List<Message> messageList = messageDao.selectPrivateList();
		viewData.put("messageList", messageList);
		return viewData;
	}
	
	public Map<String, Object> getReceiveMessageList(String keyword, String type, String member_id, int pageNumber){
		Map<String, Object> viewData = new HashMap<String,Object>();
		int totalCount = 0;
		int noReadCount = 0; 
		int offset = 0;
		offset = (pageNumber-1)*NUM_OF_MESSAGE_PER_PAGE;
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("message_offset", offset);
		params.put("type", type);
		if(StringUtils.equals(type, "titleCont")) {
			params.put("title", keyword);
			params.put("content", keyword);
		}else if(StringUtils.equals(type, "title")) {
			params.put("title", keyword);
		}else if(StringUtils.equals(type, "content")) {
			params.put("content", keyword);
		}else if(StringUtils.equals(type, "nick")) {
			params.put("nick", keyword);
		}
		List<Message> receiveMsgList = messageDao.selectReceiveMsgList(params);
		totalCount = messageDao.selectReceiveCount(params);
		noReadCount = messageDao.selectReceiveNoReadCount(member_id);
		viewData.put("currentPage", pageNumber);
		viewData.put("totalCount", totalCount);
		viewData.put("noReadCount", noReadCount);
		viewData.put("receiveMsgList", receiveMsgList);
		viewData.put("pageTotalCount", calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("msg_search_type", type);
		viewData.put("msg_search_keyword", keyword);
		return viewData;
	}
	
	public Map<String, Object> getSendMessageList(String keyword, String type, String member_id, int pageNumber){
		Map<String, Object> viewData = new HashMap<String,Object>();
		int totalCount = 0;
		int noReadCount = 0;
		int offset = 0;
		offset = (pageNumber-1)*NUM_OF_MESSAGE_PER_PAGE;
		
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("message_offset", offset);
		params.put("type", type);
		if(StringUtils.equals(type, "titleCont")) {
			params.put("title", keyword);
			params.put("content", keyword);
		}else if(StringUtils.equals(type, "title")) {
			params.put("title", keyword);
		}else if(StringUtils.equals(type, "content")) {
			params.put("content", keyword);
		}else if(StringUtils.equals(type, "nick")) {
			params.put("nick", keyword);
		}
		List<Message> sendMsgList = messageDao.selectSendMsgList(params);
		totalCount = messageDao.selectSendCount(params);
		noReadCount = messageDao.selectSendNoReadCount(member_id);
		
		viewData.put("currentPage", pageNumber);
		viewData.put("totalCount", totalCount);
		viewData.put("noReadCount", noReadCount);
		viewData.put("sendMsgList", sendMsgList);
		viewData.put("pageTotalCount", calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		viewData.put("msg_search_type", type);
		viewData.put("msg_search_keyword", keyword);
		return viewData;
	}
	
	public Map<String, Object> getMsgFriendList(String member_id, int pageNumber){
		int totalCount = 0;
		int offset = 0;
		offset = (pageNumber-1)*NUM_OF_MESSAGE_PER_PAGE;
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("member_relation", "friend");
		params.put("message_offset", offset);
		totalCount = memberDao.selectRelationCount(params);
		List<Member> msgFriendList = memberDao.selectRelationList(params);
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		viewData.put("currentPage", pageNumber);
		viewData.put("totalCount", totalCount);
		viewData.put("msgFriendList", msgFriendList);
		viewData.put("pageTotalCount", calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		return viewData;
	}
	
	public Map<String, Object> getMsgIgnoredList(String member_id, int pageNumber){
		int totalCount = 0;
		int offset = 0;
		offset = (pageNumber-1)*NUM_OF_MESSAGE_PER_PAGE;
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("member_id", member_id);
		params.put("member_relation", "ignored");
		params.put("message_offset", offset);
		totalCount = memberDao.selectRelationCount(params);
		List<Member> msgIgnoredList = memberDao.selectRelationList(params);
		
		Map<String, Object> viewData = new HashMap<String,Object>();
		viewData.put("currentPage", pageNumber);
		viewData.put("totalCount", totalCount);
		viewData.put("msgIgnoredList", msgIgnoredList);
		viewData.put("pageTotalCount", calPageTotalCount(totalCount));
		viewData.put("startPage", getStartPage(pageNumber));
		viewData.put("endPage", getEndPage(pageNumber));
		return viewData;
	}
	
	public int calPageTotalCount(int totalCount) {
		int pageTotalCount = 0 ;
		if(totalCount != 0) {
			pageTotalCount = (int)Math.ceil(
					((double)totalCount / NUM_OF_MESSAGE_PER_PAGE));
		}
		return pageTotalCount;
	}
	
	public int getStartPage(int pageNumber) {
		int startPage = ((pageNumber-1)/NUM_OF_NAVI_PAGE)*NUM_OF_NAVI_PAGE + 1;
		return startPage;
	}

	public int getEndPage(int pageNumber) {
		int endPage = (((pageNumber-1)/NUM_OF_NAVI_PAGE)+1)* NUM_OF_NAVI_PAGE;
		return endPage;
	}
	
}
