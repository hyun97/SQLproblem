<%@ page import="user.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="html-1.jsp" %>
<%@include file="header.jsp" %>
<%
    // 라우팅 보안
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index?id=1");
        return;
    }

    String userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));

    if (userName != null) {
        UserDAO userDAO = new UserDAO();
        String result = userDAO.getEmailVerify(userName);
        if (result.equals("1")) {
            response.sendRedirect("../index?id=1");
        }
    }
%>
<header id="emailConfirm" class="header gradient center"><h1 class="emailConfirm-title">인증 메일이 전송되었습니다</h1>
    <h2 class="emailConfirm-subtitle">이메일로 가서 인증을 진행해주세요</h2>
    <a class="emailConfirm-subtitle" href="../action/confirmEmailAction.jsp">인증 메일 재전송</a>
    <p class="emailConfirm-footer"></p>
</header>
<%@include file="html-2.jsp" %>

