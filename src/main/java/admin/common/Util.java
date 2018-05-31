package admin.common;

public class Util {

	/**
	 * 문자열이 숫자로만 이루어져 있으면 true를 반환한다.
	 * @param str
	 * @return boolean
	 */
	public static boolean isStringInteger(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

}
