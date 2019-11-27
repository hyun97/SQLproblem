<%@ page import="sqlBank.SqlBankDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="partial/html-1.jsp" %>
<%@include file="partial/header.jsp" %>
<%@include file="partial/userAgent.jsp" %>

<%
    if (request.getRequestURL().toString().equals("http://www.sqlproblem.net/") ||
            request.getRequestURL().toString().equals("http://sqlproblem.net/")) {
        response.sendRedirect("/index?id=1");
    }

    request.setCharacterEncoding("UTF-8");

    String userName;
    if (session.getAttribute("user") != null) {
        userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    } else {
        userName = (String) session.getAttribute("user");
    }

    if (userName != null) {
        UserDAO userDAO = new UserDAO();
        String result = userDAO.getEmailVerify(userName);
        try {
            if (result.equals("0")) {
                response.sendRedirect("action/confirmEmailAction.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    String quizID = request.getParameter("id");
    if (request.getParameter("fullAnswer") != null) {
        PrintWriter script = response.getWriter();
        String fullAnswer = request.getParameter("fullAnswer");
        String favoriteList = request.getParameter("playlist");
        int fullVerifyResult = new SqlBankDAO().verifyAll(quizID, fullAnswer);

        if (fullVerifyResult == 1 && !ua.equals("mobile")) {
%>
<!-- 데스크톱 정답 -->
<%@include file="partial/correct.jsp" %>
<%
} else if (fullVerifyResult == -1 && !ua.equals("mobile")) {
%>
<!-- 데스크톱 오답 -->
<%@include file="partial/wrong.jsp" %>
<%
} else if (fullVerifyResult == 1) {
%>
<!-- 모바일 정답 -->
<%@include file="partial/mobileCorrect.jsp" %>
<%
} else if (fullVerifyResult == -1) {
%>
<!-- 모바일 오답 -->
<%@include file="partial/mobileWrong.jsp" %>
<%
        }
    }
%>
<!-- Section -->
<section class="container">
    <div class="row">
        <div class="col s12">
            <%
                ArrayList<SqlBankDTO> questionList = new SqlBankDAO().getQuestion(quizID);
                if (questionList != null) {
                    for (int i = 0; i < questionList.size(); i++) {
                        SqlBankDTO sqlBankDTO = questionList.get(i);
            %>
            <!-- Question -->
            <%@include file="partial/question.jsp" %>
            <%
                    }
                }
            %>
        </div>
    </div>
</section>
<%@include file="partial/html-2.jsp" %>

























