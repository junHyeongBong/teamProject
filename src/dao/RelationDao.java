package dao;

import java.util.Map;

public interface RelationDao {
	public int insertMemberRelation(Map<String,Object> params);
	public int deleteMemberRelation(Map<String,Object> params);
	public int deleteCheckedRelation(Map<String,Object> params);
	public String selectMemberRelation(Map<String,Object> params);
}
