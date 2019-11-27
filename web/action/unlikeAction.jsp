<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="unlike.UnlikeDAO" %>
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
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String quizID = request.getParameter("quizID");

    UnlikeDAO unlikeDAO = new UnlikeDAO();
    int result = unlikeDAO.handleClickUnlike(SHA256.getSHA256(getIP(request)), quizID);

    SqlBankDAO sqlBankDAO = new SqlBankDAO();
    if (result == 1) {
        // 비추천
        sqlBankDAO.increaseUnlike(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else if (result == -1) {
        // 비추천 취소
        sqlBankDAO.decreaseUnlike(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else if (result == 2) {
        // 추천 취소 후 비추천
        sqlBankDAO.increaseUnlike(quizID);
        sqlBankDAO.decreaseStar(quizID);
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else {
        out.println("db 오류");
    }
%>