package security;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import controller.MemberController;
import model.SMember;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider{
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private UserDetailsService userDetailService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		UsernamePasswordAuthenticationToken authToken = null;
		String member_id = authentication.getName();
		UserDetails member = userDetailService.loadUserByUsername(member_id);
		if(member == null) {
			throw new UsernameNotFoundException(member_id);
		}
		String member_type = ((SMember)member).getMember_type();
//		String member_type = ((ExtraParam)authentication.getDetails()).getMember_type();
		
		String member_bool = ((SMember)member).getMember_bool();
		if(StringUtils.equals(member_bool, "1")) {
			return authToken;
		}
		if(StringUtils.equals(member_type, "normal")) {
			String member_pw = (String) authentication.getCredentials();
			if(!passwordEncoder.matches(member_pw, member.getPassword())) {
				throw new BadCredentialsException("사용자가 없거나 비밀번호 불일치");
			}else {
//				authToken = new UsernamePasswordAuthenticationToken(member_id, member_pw, member.getAuthorities());
				authToken = new UsernamePasswordAuthenticationToken(member, member_pw, member.getAuthorities());
				// new UsernamePasswordAuthenticationToken()의 첫번째 파라미터에 member_id 텍스트만 넣느냐,
				// member 객체를 다 넣느냐가 다른것. SMember.java모델의 변수에 저장할 값을 넣어주면 된다.
				return authToken;
			}	
		}else {
			authToken = new UsernamePasswordAuthenticationToken(member, null, member.getAuthorities());
			return authToken;
		}
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(arg0);
	}
}



