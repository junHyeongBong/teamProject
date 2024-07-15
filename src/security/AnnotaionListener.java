package security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

@Component
public class AnnotaionListener {
	
	private static final Logger logger = LoggerFactory.getLogger(AnnotaionListener.class);
	
	@Autowired
	private UserDetailsService userDetailService;
	
	@EventListener
	public void UserAccountChangedEvent(UserAccountChangedEvent event) {
		logger.info("어노테이션으로 이벤트리스너 들어오나");
		String member_id = event.getMember_id();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, member_id));
	}
	
	protected Authentication createNewAuthentication(Authentication currentAuth, String member_id) {

		UserDetails newPrincipal  = userDetailService.loadUserByUsername(member_id);
		UsernamePasswordAuthenticationToken newAuth = 
				new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		
		return newAuth;
	}

	
	
}
