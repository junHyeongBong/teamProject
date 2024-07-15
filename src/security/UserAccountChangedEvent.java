package security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationEvent;

public class UserAccountChangedEvent extends ApplicationEvent{
	
	private static final Logger logger = LoggerFactory.getLogger(UserAccountChangedEvent.class);
	private static final long serialVersionUID = -5938802644234932980L;
	private final String member_id;
	
	public UserAccountChangedEvent(Object source, String member_id) {
		super(source);
		this.member_id = member_id;
	}

	public String getMember_id() {
		return member_id;
	}
	
}
