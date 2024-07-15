package dao;

import java.util.List;

import model.Convenient;

public interface ConvenientDao {
	public int insertConvenient(Convenient convenient);
	public int updateConvenient(Convenient convenient);
	public int deleteConvenient(int convenient_index);
	public Convenient selectOneConvenient(int convenient_index);
	public List<Convenient> selectAllConvenientByOption(Convenient convenient);
	public List<Convenient> selectAllConvenient();
	
}
