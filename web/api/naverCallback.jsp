<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="com.google.gson.JsonParser" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String clientId = "xALpyRaHhhaxEE532Nxp";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "yK70ltzoEA";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");  //네이버 아이디로 로그인 인증에 성공하면 반환받는 인증 코드, 접근 토큰(access token) 발급에 사용
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://sqlproblem.net/api/naverCallback.jsp", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    String resultCode;
    String name;
    String email;
    try {
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if (responseCode == 200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer res = new StringBuffer();
        int temp = 0;
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();
        if (responseCode == 200) {
            access_token = res.substring(res.indexOf(":") + 2, res.indexOf(",") - 1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    String token = access_token;// 네이버 로그인 접근 토큰;
    String header = "Bearer " + token; // Bearer 다음에 공백 추가
    try {
        apiURL = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", header);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if (responseCode == 200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer responses = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            responses.append(inputLine);
        }
        br.close();
        JsonParser jsonParser = new JsonParser();
        JsonElement jsonElement = jsonParser.parse(responses.toString());
        resultCode = jsonElement.getAsJsonObject().get("resultcode").getAsString();
        name = jsonElement.getAsJsonObject().get("response").getAsJsonObject().get("nickname").getAsString();
        email = jsonElement.getAsJsonObject().get("response").getAsJsonObject().get("email").getAsString();

        if (resultCode.equals("00")) {
            UserDAO userDAO = new UserDAO();
            int result = userDAO.naverLogin(name, email);
            if (result == 1) {
                session.setAttribute("user", java.net.URLEncoder.encode(userDAO.getName(email)));
                response.sendRedirect("../index?id=1");
            } else {
                // 이메일이 중복될 경우 기존 계정으로 로그인
                session.setAttribute("user", java.net.URLEncoder.encode(userDAO.getName(email)));
                response.sendRedirect("../index?id=1");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>