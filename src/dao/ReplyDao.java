package dao;

import java.util.List;
import java.util.Map;

import model.Reply;

public interface ReplyDao {
	
	public int regReply(Map<String, Object> paramMap);
	public List<Reply> getReplyList(int trip_board_num);
	public boolean checkReply(Map<String, Object> paramMap);
	public boolean updateReply(Map<String, Object> paramMap);
//	public int delReply(Map<String, Object> paramMap);
	public int deleteBoardReply(Map<String, Object> paramMap);
	public int deleteBoardReplyAll(Map<String, Object> paramMap);
	
	public List<Reply> searchMyReplyList(Map<String,Object> params);
}
