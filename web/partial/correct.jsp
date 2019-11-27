<%@ page import="star.StarDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (favoriteList != null) {
        // For Favorite List
        int nextQuestion = new StarDAO().nextFavoriteSQL(favoriteList, quizID);
%>
<div class="result-wrapper">
    <div class="card green darken-2">
        <div class=" card-content white-text">
            <span class="card-title">Correct !</span>
        </div>
        <div class="card-action">
            <% if (nextQuestion != -2) { %>
            <!-- Next Question -->
            <a href="../index?id=<%=nextQuestion%>&playlist=<%=favoriteList%>" class='indigo-text text-darken-3'><i
                    class="material-icons">keyboard_return</i></a>
            <!-- Question Finish -->
            <% } else { %>
            <a href="../partial/profile?user=<%=favoriteList%>" class='indigo-text text-darken-3'>END</a>
            <% } %>
        </div>
    </div>
</div>
<%
} else {
    // For Normal List
    int nextQuestion = new SqlBankDAO().getQuizId(quizID);
    ArrayList<SqlBankDTO> getPart = new SqlBankDAO().getQuestion(quizID);
    for (int i = 0; i < getPart.size(); i++) {
        SqlBankDTO sqlBankDTO = getPart.get(i);
%>
<div class="result-wrapper">
    <div class="card green darken-2">
        <div class=" card-content white-text">
            <span class="card-title">Correct !</span>
        </div>
        <div class="card-action">
            <% if (nextQuestion != -2) { %>
            <!-- Next Question -->
            <a href="../index?id=<%=nextQuestion%>" class='indigo-text text-darken-3'><i
                    class="material-icons">keyboard_return</i></a>
            <!-- Question Finish -->
            <!-- TODO: 마지막 문제 지정 -->
            <% } else { %>
            <a href="../index?id=1" class='indigo-text text-darken-3'>END</a>
            <%
                }
            %>
        </div>
    </div>
</div>
<%
        }
    }
%>







