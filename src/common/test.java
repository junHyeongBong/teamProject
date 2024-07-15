package common;

public class test {
	public static void main(String[] args) {
		String s = "가,나,다,라,마,바,사";
		System.out.println(s.split(",")[0]);
		System.out.println(s.split(",")[1]);
		System.out.println(s.split(",")[2]);
		System.out.println(s.split(",")[3]);
		
		String tmp = "";
		System.out.println(tmp);
		
		String[] sibap = {"개", "같", "은"};
		
		System.out.println(sibap[0]);
		System.out.println(sibap[1]);
		System.out.println(sibap[2]);
	}
}
