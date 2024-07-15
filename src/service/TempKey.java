package service;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TempKey {
	private static final Logger logger = LoggerFactory.getLogger(TempKey.class);
	
	private boolean lowerCheck;
	private int size;
	
	public String getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return init();
	}

	private String init() {
		SecureRandom ran = new SecureRandom();
		StringBuilder sb = new StringBuilder();
		int num = 0;
		do {
			num = ran.nextInt(75)+48;
			//숫자, 대문자, 소문자만 조합하기 위한 범위 설정.
			if((num>=48 && num<=57)||(num>=65 && num<=90)||(num>=97 && num<=122)) {
				sb.append((char)num);
			}else {
				continue;
			}
		}while(sb.length() < size);
			
		if(lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}
	
	public static String tempPw() {
		SecureRandom ran = new SecureRandom();
		StringBuilder sb = new StringBuilder();
		int size = 8;
		int num = 0;
		int scPos = ran.nextInt(8);
		int count = 0;

		do {
			if(count==scPos) {
				List<Integer> scList = new ArrayList<Integer>(
					Arrays.asList(33, 64, 35, 36, 37)	
				);
				num = scList.get(ran.nextInt(scList.size()));
				sb.append((char)num);
				count++;
			}
			
			num = ran.nextInt(75)+48;
			if((num>=48 && num<=57)||(num>=97 && num<=122)) {
				sb.append((char)num);
				count++;
			}else {
				continue;
			}
		}while(sb.length() < size);
		return sb.toString();
	}
	
}
