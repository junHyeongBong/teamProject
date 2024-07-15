package service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import model.GoogleUser;
import model.Member;

@Service
public class GoogleApiService{

	private static final String CLIENT_ID = "944268971430-qeqna441o1asom3mdqef0kctfees0ckl.apps.googleusercontent.com";
	private static final String CLIENT_SECRET = "_t2dUyi4bb4MNhODUoIFez_h";
	private static final String CALLBACK_URL = "http://localhost:8081/Project_TF/common/google/callback";
//	private static final String SESSION_STATE = "oauth_state";
	
	public String getAuthUrl() {
//		String state = generateState();
//		session.setAttribute(SESSION_STATE, state);
//		String encodedState = null;
//		String scope2 = "https://www.googleapis.com/auth/userinfo.email";
//		String scope = "https://www.googleapis.com/auth/plus.login";
		String scope = "https://www.googleapis.com/auth/userinfo.profile";
		
		String encodedCallBackURL = null;
		String encodedScope = null;
		try {
//			encodedState = URLEncoder.encode(state, "UTF-8");
			encodedCallBackURL = URLEncoder.encode(CALLBACK_URL, "UTF-8");
			encodedScope = URLEncoder.encode(scope, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
//		String apiURL = "https://nid.naver.com/oauth2.0/authorize?client_id="+CLIENT_ID+"&response_type=code&redirect_uri="+encodedCallBackURL+"&state="+encodedState;
		String apiURL = "https://accounts.google.com/o/oauth2/v2/auth?redirect_uri="+encodedCallBackURL+"&response_type=code&client_id="+CLIENT_ID+"&scope="+encodedScope;
		return apiURL;
	}

	public String getAccessToken(String code) {
//		String sessionState = (String) session.getAttribute(SESSION_STATE);
		BufferedReader br = null;
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
			 
		String apiURL = "https://www.googleapis.com/oauth2/v4/token";
		
		try {
			HttpClient client = HttpClientBuilder.create().build();
			HttpPost post = new HttpPost(apiURL);
			post.setHeader("Content-Type", "application/x-www-form-urlencoded");
			List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
			urlParameters.add(new BasicNameValuePair("code", code));
			urlParameters.add(new BasicNameValuePair("client_id", CLIENT_ID));
			urlParameters.add(new BasicNameValuePair("client_secret", CLIENT_SECRET));
			urlParameters.add(new BasicNameValuePair("redirect_uri", CALLBACK_URL));
			urlParameters.add(new BasicNameValuePair("grant_type", "authorization_code"));
			post.setEntity(new UrlEncodedFormEntity(urlParameters));
			HttpResponse response = client.execute(post);
			int responseCode = response.getStatusLine().getStatusCode();
			
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			}else {
				br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			}
	
			while((inputLine = br.readLine())!=null) {
				sb.append(inputLine);
			}
		}catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
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
		return accessToken;
	}

	public Member getUserProfile(String accessToken) {
		BufferedReader br = null;
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
//		String header = "Bearer " + accessToken;
		String apiURL = "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token="+accessToken;
		URL url;
	    try {
			url = new URL(apiURL);
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
//			connection.setRequestProperty("Authorization", header);
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
		String googleId = element.getAsJsonObject().get("user_id").getAsString();
		GoogleUser googleUser = new GoogleUser(googleId);
		return new Member(googleUser);
	}

	public String generateState() {
		return UUID.randomUUID().toString();
	}

}
