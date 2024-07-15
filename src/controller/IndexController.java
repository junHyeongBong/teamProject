package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	@RequestMapping(value = "/",method=RequestMethod.GET)
	public String goOpening() {
//		return "login";
		return "redirect:/common/opening";
	}
	
	@RequestMapping(value = "/common",method=RequestMethod.GET)
	public String goMain() {
//		return "login";
		return "redirect:/common/main";
	}
	
	@RequestMapping("/noAuth")
	public String noAuth() {
		return "memberNoAuth";
	}
	
}
