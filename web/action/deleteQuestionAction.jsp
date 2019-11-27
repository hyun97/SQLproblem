<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String quizID = request.getParameter("id");
    SqlBankDAO sqlBankDAO = new SqlBankDAO();
    String creator = sqlBankDAO.getUser(quizID);
    String sessionUser;
    if (session.getAttribute("user") != null) {
        sessionUser = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    } else {
        sessionUser = (String) session.getAttribute("user");
    }

    // 라우팅 보안
    if (session.getAttribute("user") == null) {
        response.sendRedirect("/index?id=1");
        return;
    }
    if (session.getAttribute("user") != null && !sessionUser.equals(creator) && !sessionUser.equals("ADMIN")) {
        response.sendRedirect("/index?id=1");
        return;
    }

    int result = sqlBankDAO.deleteQuestion(quizID);

    if (result == 1) {
        response.sendRedirect("../index?id=1");
    } else {
        out.println("db 오류");
    }
%>