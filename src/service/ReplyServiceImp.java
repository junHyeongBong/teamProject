package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReplyDao;
import model.Reply;

@Service
public class ReplyServiceImp implements ReplyService{

	@Autowired
	private ReplyDao replyDao;
	
	@Override
	public int regReply(Map<String, Object> paramMap) {
		return replyDao.regReply(paramMap);
	}

	@Override
	public List<Reply> getReplyList(int trip_board_num) {
		List<Reply> boardReplyList = replyDao.getReplyList(trip_board_num);
		//mysql에서는 계층적 쿼리가 어려워 service에서 해결
		
		//부모
		List<Reply> boardReplyListParent = new ArrayList<Reply>();
		//자식
		List<Reply> boardReplyListChild = new ArrayList<Reply>();
		//통합
		List<Reply> newBoardReplyList = new ArrayList<Reply>();
		
		//1. 부모와 자식 분리
		for(Reply reply: boardReplyList) {
			if(reply.getDepth().equals("0")) {
				boardReplyListParent.add(reply);
			}else {
				boardReplyListChild.add(reply);
			}
		}
		
		//2.부모를 돌린다.
		for(Reply boardReplyParent: boardReplyListParent) {
			//2-1 부모는 무조건 넣는다.
			newBoardReplyList.add(boardReplyParent);
			//3 자식을 돌린다.
			for(Reply boardReplychild: boardReplyListChild) {
				//3-1. 부모의 자식인 것들만 넣는다.
				if(boardReplyParent.getReply_num().equals(boardReplychild.getParent_id())) {
					newBoardReplyList.add(boardReplychild);
				}
			}
		}
		//정리한 list return
		return newBoardReplyList;
	}

//	@Override
//	public int delReply(Map<String, Object> paramMap) {
//		System.out.println(paramMap.get("reply_type"));
//		return replyDao.delReply(paramMap);
//	}
	
	@Override
	public int deleteBoardReply(Map<String, Object> paramMap) {
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("reply_type", "sub");
		System.out.println("sub로 지우기");
		return replyDao.deleteBoardReply(paramMap);
	}
	
	@Override
	public int deleteBoardReplyAll(Map<String, Object> paramMap) {
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("reply_type", "main");
		System.out.println("main으로 지우기");
		return replyDao.deleteBoardReplyAll(paramMap);
	}
//	
//	@Override
//	public int delReply(Map<String, Object> paramMap) {
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("deleteType", "one");
//		params.put("reply_num", 32);
//		params.put("parnet_id", null);
//		
//		return replyDao.delReply(paramMap);
//	}
	

//	@Override
//	public boolean checkReply(Map<String, Object> paramMap) {
//		return replyDao.checkReply(paramMap);
//	}

	@Override
	public boolean updateReply(Map<String, Object> paramMap) {
		return replyDao.updateReply(paramMap);
	}


	//내 리플 조회 메서드 
	public List<Reply> myReplyList(Map<String, Object> params){
		return replyDao.searchMyReplyList(params);
	}
}
