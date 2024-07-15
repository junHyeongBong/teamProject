package service;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import model.Coordinate;

@Service
public class RouteService {
	
//	public List<Coordinate> makeCoordList(String[] dailyData) throws Exception {
//		//길찾기 데이터(dailyData) 보내는 순서 : 교통수단, 다음좌표리스트, 좌표리스트, 주소리스트, 시작인덱스, 끝인덱스
////		for(String s : dailyData) {
////			System.out.println(s);
////		}
//		
//		String road_finder_transport_type = dailyData[0];
//		String tmpdaumCoordList = "";
//		List<String> daumCoordList = new ArrayList<String>();
//		if(dailyData[1] != null) {
//			tmpdaumCoordList = dailyData[1];
//			for(int i=0; i<tmpdaumCoordList.split(",").length; i++) {
//				daumCoordList.add(tmpdaumCoordList.split(",")[i]);
//			}
//		}
//		String tmplatYlngXList = dailyData[2];
//		List<String> latYlngXList = new ArrayList<String>();
//		for(int i=0; i<tmplatYlngXList.split(",").length; i++) {
//			latYlngXList.add(tmplatYlngXList.split(",")[i]);
//		}
//		String tmpaddressList = dailyData[3];
//		List<String> addressList = new ArrayList<String>();
//		for(int i =0; i<tmpaddressList.split(",").length; i++) {
//			addressList.add(tmpaddressList.split(",")[i]);
//		}
//		String startIndex = dailyData[4];
//		String endIndex = dailyData[5];
////		System.out.println(road_finder_transport_type);
////		System.out.println(daumCoordList);
////		System.out.println(latYlngXList);
////		System.out.println(addressList);
////		System.out.println(startIndex);
////		System.out.println(endIndex);
//		
//		List<Coordinate> coords = new ArrayList<Coordinate>();
//		
//		if(road_finder_transport_type.equals("1")) {
//			for(int i=0; i<daumCoordList.size(); i++) {
//				coords.add(new Coordinate(Double.parseDouble(daumCoordList.get(i).split("/")[0]), Double.parseDouble(daumCoordList.get(i).split("/")[1]), Double.parseDouble(latYlngXList.get(i).split("/")[0]), Double.parseDouble(latYlngXList.get(i).split("/")[1]), URLEncoder.encode(addressList.get(i),"UTF-8")));
//			}
//		}else{
//			for(int i=0; i<latYlngXList.size(); i++) {
//				coords.add(new Coordinate(Double.parseDouble(latYlngXList.get(i).split("/")[0]), Double.parseDouble(latYlngXList.get(i).split("/")[1]), URLEncoder.encode(addressList.get(i), "UTF-8")));
//			}
//		}
//		
//		Coordinate tmpStartCoord = coords.get(Integer.parseInt(startIndex));
//		Coordinate tmpFinalCoord = coords.get(Integer.parseInt(endIndex));
//		for(int i=0; i<coords.size(); i++) {
//			if(coords.get(i).getAddress().equals(tmpStartCoord.getAddress())) {
//				coords.remove(i);
//			}
//		}
//		for(int i=0; i<coords.size(); i++) {
//			if(coords.get(i).getAddress().equals(tmpFinalCoord.getAddress())) {
//				coords.remove(i);
//			}
//		}
//		coords.add(0, tmpStartCoord);
//		coords.add(tmpFinalCoord);
//		
//		return coords;
//	}
	
	public List<Coordinate> makeCoordList(String[] params) throws Exception {
		//1 6 11 16 21 26 31 addr
		//2 7 12 17 22 27 32 y
		//3 8 13 18 23 28 33 x
//		for(String s : params) {
//			System.out.println(s);
//		}
		
		List<Coordinate> coordList = new ArrayList<Coordinate>();
		for(int i=0; i < 7; i++) {
//			System.out.println("검사 : "+params[2+(5*i)]);
			if(!params[2+(5*i)].equals("0")) {
//				System.out.println("false냐");
				Coordinate coord = new Coordinate(Double.parseDouble(params[2+(5*i)]), Double.parseDouble(params[3+(5*i)]), URLEncoder.encode(params[1+(5*i)], "UTF-8"));
				coordList.add(coord);
			}
		}
		return coordList;
	}
}
