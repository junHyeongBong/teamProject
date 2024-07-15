package model;

import org.springframework.security.core.GrantedAuthority;

public class Role implements GrantedAuthority{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8846719920622457364L;
	
	private String authority;
	
	public Role() {
	}
	
	public Role(String authority) {
		this.authority = authority;
	}
	
	@Override
	public String getAuthority() {
		return authority;
	}

	@Override
	public String toString() {
		return "Role [authority=" + authority + "]";
	}
	
	
	
}
