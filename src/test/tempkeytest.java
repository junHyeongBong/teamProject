package test;

import java.security.SecureRandom;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import service.TempKey;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:WebContent/WEB-INF/spring/root-Context.xml")
public class tempkeytest {
	
	private static final Logger logger = LoggerFactory.getLogger(CaptchaTest.class);
	
	@Test
	public void tempkeyTest() {
		
		TempKey tk = new TempKey();
		logger.info(tk.tempPw());
	}

}
