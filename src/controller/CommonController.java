package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.StringBuilderWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Coordinate;
import service.RouteService;

@Controller
@RequestMapping("/common")
public class CommonController {


	@RequestMapping("/opening")
	public String openingSite() {
		return "opening";
	}

	@RequestMapping("/main")
	public String mainSite() {
		return "main";
	}

	@RequestMapping("/image")
	@ResponseBody
	public byte[] getImageAsByteArray(String imageName, String imageType) {
		// 특정 이미지 읽어와서 byte[] 배열로 만들어서 반환
		// C:\boardImage
		// 파일 읽어오기
		File originFile = null;
		if (imageType.equals("place")) {
			originFile = new File("C:/Project_TF/placeimage/" + imageName + ".png");
		} else if (imageType.equals("convenient")) {
			originFile = new File("C:/Project_TF/convenientimage/" + imageName + ".png");
		} else {

		}
//		System.out.println(originFile);
		InputStream targetStream = null;
		if (originFile.exists()) {
			try {
				targetStream = new FileInputStream(originFile);
				// 스트림을 byte[] 변환하기 >>IOUtils, commons.io
				return IOUtils.toByteArray(targetStream);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			File nonFile = new File("C:/Project_TF/placeimage/티모.png");
			try {
				targetStream = new FileInputStream(nonFile);
				// 스트림을 byte[] 변환하기 >>IOUtils, commons.io
				return IOUtils.toByteArray(targetStream);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}

	@RequestMapping("/oneRouteFinder")
	public void routeFinder(String transportType, Double startLatY, Double startLngX, String startAddr,
			Double arriveLatY, Double arriveLngX, String arriveAddr, HttpServletResponse response) throws Exception {
		System.out.println(transportType);
		System.out.println(startLatY);
		System.out.println(startLngX);
		System.out.println(startAddr);
		System.out.println(arriveLatY);
		System.out.println(arriveLngX);
		System.out.println(arriveAddr);

		BufferedReader br = null;
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
		String webURL = "";

		if (transportType.equals("car")) {
			System.out.println("나는 차에요");
			webURL = "https://map.naver.com/spirra/findCarRoute.nhn?route=route3&output=json&result=web3&coord_type=naver&search=2&car=0&mileage=12.4&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination="
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8") + "&via=";
		} else if (transportType.equals("pubTransport")) {
			System.out.println("나는 대중교통이에요");
			webURL = "http://map.daum.net/route/pubtrans.json?inputCoordSystem=WCONGNAMUL&outputCoordSystem=WCONGNAMUL&service=map.daum.net&sX="
					+ startLngX + "&sY=" + startLatY + "&sName=" + URLEncoder.encode(startAddr, "UTF-8") + "&sid=&eX="
					+ arriveLngX + "&eY=" + arriveLatY + "&eName=" + URLEncoder.encode(arriveAddr, "UTF-8") + "&eid=";
		} else if (transportType.equals("bicycle")) {
			System.out.println("나는 자전거에요");
			webURL = "https://map.naver.com/spirra/findCarRoute.nhn?call=route3&output=json&search=8&result=web3&coord_type=naver&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination="
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8") + "&via=";
		} else if (transportType.equals("walk")) {
			System.out.println("나는 걷기에요");
			webURL = "https://map.naver.com/findroute2/findWalkRoute.nhn?call=route2&output=json&coord_type=naver&search=0&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination="
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8");
		}
		System.out.println(webURL);
		URL url = new URL(webURL);
		if (!transportType.equals("pubTransport")) {
			System.out.println("네이버");
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0");
			try {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else {
			System.out.println("다음");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0");
			try {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println("결과");
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(sb);
		System.out.println(sb);
	}

	@RequestMapping("/dayRouteFinder")
	@ResponseBody
	public void dayRouteFinder(String transportList, Double startLatY, Double startLngX, Double startJb, Double startIb, String startAddr,
			Double arriveLatY, Double arriveLngX, Double arriveJb, Double arriveIb, String arriveAddr, HttpServletResponse response) throws IOException {
		System.out.println(transportList);
		System.out.println(startLatY);
		System.out.println(startLngX);
		System.out.println(startJb);
		System.out.println(startIb);
		System.out.println(startAddr);
		System.out.println(arriveLatY);
		System.out.println(arriveLngX);
		System.out.println(arriveJb);
		System.out.println(arriveIb);
		System.out.println(arriveAddr);

		BufferedReader br = null;
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
		String webURL = "";
		String tmp = "";

		if (transportList.equals("car")) {
			System.out.println("나는 차에요");
			webURL = "https://map.naver.com/spirra/findCarRoute.nhn?route=route3&output=json&result=web3&coord_type=naver&search=2&car=0&mileage=12.4&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination=" 
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8") + "&via=";
		} else if (transportList.equals("pubTransport")) {
			System.out.println("나는 대중교통이에요");
			webURL = "http://map.daum.net/route/pubtrans.json?inputCoordSystem=WCONGNAMUL&outputCoordSystem=WCONGNAMUL&service=map.daum.net&sX="
					+ startIb + "&sY=" + startJb + "&sName=" + URLEncoder.encode(startAddr, "UTF-8") + "&sid=&eX=" 
					+ arriveIb + "&eY=" + arriveJb + "&eName=" + URLEncoder.encode(arriveAddr, "UTF-8") + "&eid=";
		} else if (transportList.equals("bicycle")) {
			System.out.println("나는 자전거에요");
			webURL = "https://map.naver.com/spirra/findCarRoute.nhn?call=route3&output=json&search=8&result=web3&coord_type=naver&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination=" 
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8") + "&via=";
		} else if (transportList.equals("walk")) {
			System.out.println("나는 걷기에요");
			webURL = "https://map.naver.com/findroute2/findWalkRoute.nhn?call=route2&output=json&coord_type=naver&search=0&start="
					+ startLngX + "%2C" + startLatY + "%2C" + URLEncoder.encode(startAddr, "UTF-8") + "&destination=" 
					+ arriveLngX + "%2C" + arriveLatY + "%2C" + URLEncoder.encode(arriveAddr, "UTF-8") + "&via=";
		}
		System.out.println(webURL);
		URL url = new URL(webURL);
		if (!transportList.equals("pubTransport")) {
			System.out.println("네이버");
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0");
			try {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else {
			System.out.println("다음");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0");
			try {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(sb);
	}
}
