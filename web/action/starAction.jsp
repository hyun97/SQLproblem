<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="star.StarDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    public static String getIP(HttpServletRequest request) {
        String userIP = request.getHeader("X-FORWARDED-FOR");
        if (userIP == null || userIP.length() == 0) {
            userIP = request.getHeader("Proxy-Client-IP");
        }
        if (userIP == null || userIP.length() == 0) {
            userIP = request.getHeader("WL-Proxy-Client-IP");
        }
        if (userIP == null || userIP.length() == 0) {
            userIP = request.getRemoteAddr();
        }
        return userIP;
    }
%>
<%
    PrintWriter script = response.getWriter();
    request.setCharacterEncoding("UTF-8");

    String quizID = request.getParameter("quizID");
    String userName;
    if (session.getAttribute("user") != null) {
        userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    } else {
        userName = (String) session.getAttribute("user");
    }

    StarDAO starDAO = new StarDAO();
    int result = starDAO.handleClickStar(SHA256.getSHA256(getIP(request)), quizID, userName);

    SqlBankDAO sqlBankDAO = new SqlBankDAO();
    if (result == 1) {
        // 추천
        sqlBankDAO.increaseStar(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else if (result == -1) {
        // 추천 취소
        sqlBankDAO.decreaseStar(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else if (result == 2) {
        // 비추천 취소 후 추천
        sqlBankDAO.increaseStar(quizID);
        sqlBankDAO.decreaseUnlike(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else {
        out.println("db 오류");
    }
%>