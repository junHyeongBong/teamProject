package service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import dao.AuthorityDao;
import dao.MemberDao;
import model.Member;
import model.Role;
import model.SMember;

@Component
public class CustomUserDetailService implements UserDetailsService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AuthorityDao authDao;
	
	@Override
	public UserDetails loadUserByUsername(String member_id) throws UsernameNotFoundException {

		SMember smember = null;
		Member member = memberDao.selectOne(member_id);
		
		if(member != null && StringUtils.equals(member.getMember_bool(), "0")) {
			smember = new SMember();
			smember.setMember_id(member.getMember_id());
			smember.setMember_pw(member.getMember_pw());
			smember.setMember_nick(member.getMember_nick());
			smember.setMember_type(member.getMember_type());
			smember.setMember_bool(member.getMember_bool());
			List<String> Authorities = authDao.selectUserAuthorities(member_id);
			
			for(String auth:Authorities) {
				smember.addAuthority(new Role(auth));
			}	
		}
		
		return smember;
	}
	
}
