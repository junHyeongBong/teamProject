package security;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class CustomUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
	private String jsonUsername;
    private String jsonPassword;

    @Override
    protected String obtainPassword(HttpServletRequest request) {
        String password = null; 
        return password;
    }

    @Override
    protected String obtainUsername(HttpServletRequest request){
        String username = null;

        HttpSession session = request.getSession();
        username = (String) session.getAttribute("member_id");
        session.removeAttribute("member_id");
        return username;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response){
    	HttpSession session = request.getSession();
    	
    	String member_id = (String) session.getAttribute("member_id");
    	session.removeAttribute("member_id");
//    	String member_type = (String) session.getAttribute("member_type");
    	
    	UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(member_id, null);
    	
    	return this.getAuthenticationManager().authenticate(authRequest);

    }
}
