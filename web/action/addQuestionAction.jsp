<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 라우팅 보안
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index?id=1");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String user = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    String part = request.getParameter("part");
    String title = request.getParameter("title").replaceAll("<", "&lt;");
    String question = request.getParameter("question").replaceAll("<", "&lt;");
    String solution = request.getParameter("solution").replaceAll("<", "&lt;");
    String solution2 = null;
    String solution3 = null;
    if (!request.getParameter("solution2").equals("")) {
        solution2 = request.getParameter("solution2").replaceAll("<", "&lt;");
    }
    if (!request.getParameter("solution3").equals("")) {
        solution3 = request.getParameter("solution3").replaceAll("<", "&lt;");
    }

    SqlBankDAO sqlBankDAO = new SqlBankDAO();
    int result = sqlBankDAO.addQuestion(user, part, title, question, solution, solution2, solution3);

    if (result == 1) {
        script.println("<script>");
        script.println("location.href='../index?id=" + sqlBankDAO.getQuizID(title) + "'");
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('이미 등록된 TITLE 입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>

