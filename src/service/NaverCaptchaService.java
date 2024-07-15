package service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import common.ExceptionPrint;

@Service
public class NaverCaptchaService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImp.class);
	
	private static final String CLIENT_ID = "ZQtqEBBnRhLkUVRJ8H41" ;
	private static final String CLIENT_SECRET = "pk8JQzAoMr";
	private static final String CAPTCHA_API_URL = "https://openapi.naver.com/v1/captcha/nkey";
	private static final String CAPTCHA_IMAGE_URL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin";
	
	public String getCaptchaKey(){
		String code = "0";
		String apiURL = CAPTCHA_API_URL + "?code=" + code;
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		String inputLine = null;
			
		try {
			URL url = new URL(apiURL);
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", CLIENT_ID);
			con.setRequestProperty("X-Naver-Client-Secret", CLIENT_SECRET);
			int responseCode = con.getResponseCode();
			
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));		
			}else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
	
			while((inputLine = br.readLine()) != null){
				sb.append(inputLine);
			}
		}catch(Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
		}finally {
			try {
				br.close();
			} catch (IOException e) {
				logger.error(ExceptionPrint.stackTraceToString(e));
			}
		}
		
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(sb.toString());
		String captchaKey = element.getAsJsonObject().get("key").getAsString();
		return captchaKey;
	}
	
	public String getCaptchaImageUrl(String captchaKey) {
		StringBuilder sb = new StringBuilder(CAPTCHA_IMAGE_URL);
		sb.append("?key=").append(captchaKey);
		return sb.toString();
	}
	
	public boolean isValidCaptcha(String captchaKey, String captchaInput) {
		String code = "1";
		String apiURL = CAPTCHA_API_URL + "?code=" + code + "&key=" + captchaKey + "&value=" + captchaInput;
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		String inputLine = null;
			
		try {
			URL url = new URL(apiURL);
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", CLIENT_ID);
			con.setRequestProperty("X-Naver-Client-Secret", CLIENT_SECRET);
			int responseCode = con.getResponseCode();
			
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));		
			}else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
	
			while((inputLine = br.readLine()) != null){
				sb.append(inputLine);
			}
		}catch(Exception e) {
			logger.error(ExceptionPrint.stackTraceToString(e));
		}finally {
			try {
				br.close();
			} catch (IOException e) {
				logger.error(ExceptionPrint.stackTraceToString(e));
			}
		}
		
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(sb.toString());
//		String result = element.getAsJsonObject().get("result").getAsString();
		boolean result = element.getAsJsonObject().get("result").getAsBoolean();
		return result;
	}
		
		
	
	
}
