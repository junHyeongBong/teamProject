package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ConvenientDao;
import dao.PlaceDao;
import model.Convenient;
import model.Place;

@Service
public class ConvenientService {
	
	@Autowired
	private ConvenientDao convenientDao;
	
	public boolean insertConvenient(Convenient convenient) {
		if(convenientDao.insertConvenient(convenient) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public List<Convenient> selectAllConvenientByOption(Convenient convenient) {
		return convenientDao.selectAllConvenientByOption(convenient);
	}
}
