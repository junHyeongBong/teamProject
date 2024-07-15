package common;

public class ExceptionPrint {
	public static String stackTraceToString(Throwable e) {
	    StringBuilder sb = new StringBuilder();
	    sb.append(e.getMessage()).append("\n");
	    for (StackTraceElement element : e.getStackTrace()) {
	        sb.append(element.toString());
	        sb.append("\n");
	    }
	    return sb.toString();
	}
}
