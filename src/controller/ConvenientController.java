package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Convenient;
import service.ConvenientService;

@Controller
@RequestMapping("/common")
public class ConvenientController {

	@Autowired
	private ConvenientService convenientService;
	
	@RequestMapping("/convenientAdder")
	public void convenientAdder(String convenient_name, String convenient_address, Double convenient_laty,
			Double convenient_lngx, String convenient_type) {
		
		Convenient convenient = new Convenient();
		convenient.setConvenient_name(convenient_name);
		convenient.setConvenient_address(convenient_address);
		convenient.setConvenient_laty(convenient_laty);
		convenient.setConvenient_lngx(convenient_lngx);
		convenient.setConvenient_type(convenient_type);
		
		System.out.println(convenient);
		System.out.println(convenientService.insertConvenient(convenient));
	}
	
	@RequestMapping("/restRecommend")
	@ResponseBody
	public List<Convenient> restrecommend(Double convenient_laty, Double convenient_lngx, String convenient_type) {
//		System.out.println("무엇?");
		
		Convenient searchConvenient = new Convenient();
		searchConvenient.setConvenient_laty(convenient_laty);
		searchConvenient.setConvenient_lngx(convenient_lngx);
		searchConvenient.setConvenient_type(convenient_type);
		
//		System.out.println(searchConvenient);
		List<Convenient> conveninetResultList = convenientService.selectAllConvenientByOption(searchConvenient);
		
//		System.out.println(conveninetResultList);
		
		return conveninetResultList;
	}
}
