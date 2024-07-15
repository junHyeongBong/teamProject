package security;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.web.servlet.support.RequestContextUtils;

public class ExtraParam extends WebAuthenticationDetails {

	private static final long serialVersionUID = 1L;
	private final String member_type;
	
	public ExtraParam(HttpServletRequest request) {
		super(request);
		this.member_type = request.getParameter("member_type");
	}

	public String getMember_type() {
		return member_type;
	}
}
