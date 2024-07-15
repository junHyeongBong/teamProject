package dao;

import java.util.List;

public interface AuthorityDao {
	public int insertUserAuthorities(String member_id);
	public int deleteUserAuthorities(String member_id);
	public List<String> selectUserAuthorities(String member_id);
}
