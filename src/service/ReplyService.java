package service;

import java.util.List;
import java.util.Map;

import model.Reply;

public interface ReplyService {
	public int regReply(Map<String, Object> paramMap);
	public List<Reply> getReplyList(int trip_board_num);
//	public int delReply(Map<String, Object> paramMap);
//	public boolean checkReply(Map<String, Object> paramMap);
	public boolean updateReply(Map<String, Object> paramMap);
	int deleteBoardReplyAll(Map<String, Object> paramMap);
	int deleteBoardReply(Map<String, Object> paramMap);
	public List<Reply> myReplyList(Map<String, Object> params);
}
