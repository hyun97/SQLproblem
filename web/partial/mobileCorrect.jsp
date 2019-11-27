<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="star.StarDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int nextQuestion;
    script.println("<script>");
    script.println("alert('Correct !')");
    if (favoriteList == null) {
        // Normal List
        nextQuestion = new SqlBankDAO().getQuizId(quizID);
        if (nextQuestion != -2) {
            script.println("location.href='./index.jsp?id=" + nextQuestion + "'");
        } else {
            script.println("location.href='./index.jsp?id=1'");
        }
    } else {
        // Favorite List
        nextQuestion = new StarDAO().nextFavoriteSQL(favoriteList, quizID);
        if (nextQuestion != -2) {
            script.println("location.href='./index.jsp?id=" + nextQuestion + "&playlist=" + favoriteList + "'");
        } else {
            script.println("location.href='../partial/profile?user=" + favoriteList + "'");
        }
    }
    script.println("</script>");
    script.close();
%>

