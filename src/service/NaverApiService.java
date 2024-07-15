package service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import model.Member;
import model.NaverUser;

@Service
public class NaverApiService{

	private static final String CLIENT_ID = "r8dFNPpSk8CFtf6pOI4W";
	private static final String CLIENT_SECRET = "6fTH53QPHO";
	private static final String CALLBACK_URL = "http://localhost:8081/Project_TF/common/naver/callback";
	private static final String SESSION_STATE = "oauth_state";
	
	public String getAuthUrl(HttpSession session) {
		String state = generateState();
		session.setAttribute(SESSION_STATE, state);
		String encodedState = null;
		String encodedCallBackURL = null;
		try {
			encodedState = URLEncoder.encode(state, "UTF-8");
			encodedCallBackURL = URLEncoder.encode(CALLBACK_URL, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?client_id="+CLIENT_ID+"&response_type=code&redirect_uri="+encodedCallBackURL+"&state="+encodedState;
		return apiURL;
	}

	public String getAccessToken(String code, String state, HttpSession session) {
		String sessionState = (String) session.getAttribute(SESSION_STATE);
		
		if(StringUtils.equals(state, sessionState)) {
			BufferedReader br = null;
			String inputLine = null;
			StringBuilder sb = new StringBuilder();
			String encodedState = null;
			try {
				encodedState = URLEncoder.encode(state, "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			String apiURL = "https://nid.naver.com/oauth2.0/token?client_id="+CLIENT_ID+"&client_secret="+CLIENT_SECRET+"&grant_type=authorization_code&state="+encodedState+"&code="+code;
			URL url;
			try {
				url = new URL(apiURL);
				HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
				connection.setRequestMethod("POST");
				int responseCode = connection.getResponseCode();
				
				if(responseCode == 200) {
					br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				}else {
					br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
				}
				while((inputLine = br.readLine())!=null) {
					sb.append(inputLine);
				}
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(sb.toString());
			String accessToken = element.getAsJsonObject().get("access_token").getAsString();
//			System.out.println(accessToken);
//			JSONObject jsonToken = new JSONObject(sb.toString());
//			System.out.println(jsonObject);
//			String accessToken = jsonToken.getString("access_token");
			return accessToken;
		}
		return null;
	}

	public Member getUserProfile(String accessToken) {
		BufferedReader br = null;
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
		String header = "Bearer " + accessToken;
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		URL url;
	    try {
			url = new URL(apiURL);
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Authorization", header);
//			connection.disconnect();
			int responseCode = connection.getResponseCode();
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			}else {
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			}
			while((inputLine = br.readLine())!=null) {
				sb.append(inputLine);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	    JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(sb.toString());
		String naverResponse =element.getAsJsonObject().get("response").getAsJsonObject().toString();
		Gson gson = new Gson();
		NaverUser naverUser = gson.fromJson(naverResponse, NaverUser.class);
//		String naverId = element.getAsJsonObject().get("response").getAsJsonObject().get("id").getAsString();
//	    String naverId2 = new JSONObject(sb.toString()).getJSONObject("response").getString("id");
//		return naverId;
		return new Member(naverUser);
	}

	public String generateState() {
		return UUID.randomUUID().toString();
	}

}
