package security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.AuthenticationDetailsSource;

public class ExtraParamSource implements AuthenticationDetailsSource<HttpServletRequest, ExtraParam> {

	public ExtraParam buildDetails (HttpServletRequest context) {
		return new ExtraParam(context);
	}
}
