package util;

import java.security.MessageDigest;

public class SHA256 {

    // SHA-256 (Secure Hash Algorithm) : 어떤 길이의 값을 입력하더라도 256비트의 고정된 결과값을 출력한다.

    public static String getSHA256(String input) {
        StringBuffer result = new StringBuffer();

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // 바이트로 메시지 다이제스트를 갱신
            digest.update(input.getBytes());

            // digest 한 결과를 byte 배열에 저장
            byte[] chars = digest.digest();

            // 바이트배열을 16진수 문자열로 변환하여 표시
            for (int i = 0; i < chars.length; i++) {
                String hex = Integer.toHexString(0xff & chars[i]);
                result.append(hex);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }

}
