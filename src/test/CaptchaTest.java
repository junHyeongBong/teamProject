package test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.MemberDao;
import service.NaverCaptchaService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:WebContent/WEB-INF/spring/root-Context.xml")
public class CaptchaTest {
	private static final Logger logger = LoggerFactory.getLogger(CaptchaTest.class);
	
	@Autowired
	private NaverCaptchaService naverCaptchaServce;
	
	
	@Test
	public void captchaTest() {
		String captchaKey = naverCaptchaServce.getCaptchaKey();
		logger.info("캡챠키 : " + captchaKey);
		logger.info("캡차URL : " + naverCaptchaServce.getCaptchaImageUrl(captchaKey));
//		logger.info("캡차확인 : " + naverCaptchaServce.isValidCaptcha("2mvdbk6H9L6Zb8f4", "CPU6F"));
		
	}
}
