<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@include file="../ignore.jsp" %>

<%
    String clientId = naverClientID; // 애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://sqlproblem.net/api/naverCallback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
%>

<a href="<%=apiURL%>" class='col s12 btn btn-large waves-effect waves-light green'
   style="text-transform: none; font-weight: bold">
    Sign in with Naver
</a>