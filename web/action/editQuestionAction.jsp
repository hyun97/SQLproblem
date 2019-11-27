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
    String userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    PrintWriter script = response.getWriter();

    String quizID = request.getParameter("quizID");
    String part = request.getParameter("part");
    String title = request.getParameter("title");
    String question = request.getParameter("question");
    String solution = request.getParameter("solution");
    String solution2 = null;
    String solution3 = null;
    if (!request.getParameter("solution2").equals("")) {
        solution2 = request.getParameter("solution2");
    }
    if (!request.getParameter("solution3").equals("")) {
        solution3 = request.getParameter("solution3");
    }

    SqlBankDAO sqlBankDAO = new SqlBankDAO();
    int result = sqlBankDAO.editQuestion(userName, quizID, part, title, question, solution, solution2, solution3);

    if (result == 1) {
        script.println("<script>");
        script.println("location.href='../index?id=" + quizID + "'");
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('이미 등록된 TITLE 입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>


