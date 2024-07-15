package test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.apache.commons.codec.binary.Base64;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:WebContent/WEB-INF/spring/root-Context.xml")
public class JWT_Test {
	
	@Test
	public void bcryptTest() {
		
		String jwtToken  = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjlhMzNiNWVkYjQ5ZDA4NjdhODY3MmQ5NTczYjFlMGQyMzc1ODg2ZTEifQ.eyJhenAiOiI5NDQyNjg5NzE0MzAtcWVxbmE0NDFvMWFzb20zbWRxZWYwa2N0ZmVlczBja2wuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5NDQyNjg5NzE0MzAtcWVxbmE0NDFvMWFzb20zbWRxZWYwa2N0ZmVlczBja2wuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTQxMDQxMTk5MDk5NjgyMTg0NzAiLCJhdF9oYXNoIjoiamxLeG1CcmxJUkpadTdaYkJoZmRjQSIsImV4cCI6MTUzMzcxNTE2MiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTMzNzExNTYyLCJuYW1lIjoic3RyIGpheSIsInBpY3R1cmUiOiJodHRwczovL2xoNS5nb29nbGV1c2VyY29udGVudC5jb20vLTBVYlRMMnlqUTZBL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FBbm5ZN3BVTEVIZU1JWnJYT2k2RXVoZUNmN1duWm1BS0Evczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6InN0ciIsImZhbWlseV9uYW1lIjoiamF5IiwibG9jYWxlIjoia28ifQ.Qlt-06ttwUly5Hyq74fOmRh4Xw0kqkGlqb93FbAeQhzGgqJiwv0eAS42tbbTUB1irmWfMa5HqojVPL1eBPKgv7TXhedPdTBm2WF9SH_Jx5Co2rykjs67V5xcbS8YFsaZ0t6red4eD1P0gDn_jjKrMXSvp5SKWJ0R0LJalzBY6R0EaWR8QV6q57chTWCtAnMK0cXG6Cdd66iTQ_JUEO61aemK6t2mubh373VDnP1mT-KIPGIeWs_asFnlDlS35z_qhCCFx80yyyciSvetJZukLXiRxnl9r-dE-mMI5pCzhpmCccu8yl-Nmo-jBdSdt4z1rgvLX5LbKGZFKTzYq4yLLg";
		System.out.println("------------ Decode JWT ------------");
        String[] split_string = jwtToken.split("\\.");
        String base64EncodedHeader = split_string[0];
        String base64EncodedBody = split_string[1];
        String base64EncodedSignature = split_string[2];

        System.out.println("~~~~~~~~~ JWT Header ~~~~~~~");
        Base64 base64Url = new Base64(true);
        String header = new String(base64Url.decode(base64EncodedHeader));
        System.out.println("JWT Header : " + header);


        System.out.println("~~~~~~~~~ JWT Body ~~~~~~~");
        String body = new String(base64Url.decode(base64EncodedBody));
        System.out.println("JWT Body : "+body);       
		
	}
}
