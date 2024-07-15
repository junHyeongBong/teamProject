package dao;

import java.util.List;

import model.Recruit;

public interface RecruitDao {
	public int insertRecruit(Recruit recruit);
	public int deleteOneRecruit(int recruit_index);
	public int deleteAllRecruitByBoardNum(int trip_board_num);
	
	public int recruitAccept(int recruit_index);
	public int checkRecruit(Recruit recruit);
	
	public List<Recruit> selectAllRecruitByBoardNum(int trip_board_num);
}
