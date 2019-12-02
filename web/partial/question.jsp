<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Part Area -->
<div class="row">
    <!-- Title -->
    <div class="col s12">
        <h1 class="title question-title">
            <a href="./partial/profile?user=<%=sqlBankDTO.getUser()%>" class="black-text tooltipped"
               data-position="top"
               data-tooltip="등록자 <strong><%=sqlBankDTO.getUser()%></strong> 님의 프로필로 이동">
                <%=sqlBankDTO.getTitle()%>
            </a>
        </h1>
    </div>
</div>
<%
    if (sqlBankDTO.getStar() < 9999) {
%>
<div class="row">
    <div class="col s12">
        <!-- Like -->
        <a class="sql-like light-blue-text tooltipped" data-tooltip="프로필에 문제 저장" data-position="left"
           href="./action/starAction.jsp?quizID=<%=sqlBankDTO.getQuizID()%>">
            <i class="material-icons">thumb_up</i>
            <%=sqlBankDTO.getStar()%>
        </a>
        <!-- Unlike -->
        <a class="sql-unlike red-text text-lighten-2"
           href="./action/unlikeAction.jsp?quizID=<%=sqlBankDTO.getQuizID()%>">
            <i class="material-icons">thumb_down</i>
            <%=sqlBankDTO.getUnlike()%>
        </a>
    </div>
</div>
<%
    }
%>
<div class="list-add-info-wrapper">
    <div>
        <!-- List Modal -->
        <%
            if (!ua.equals("mobile")) {
        %>
        <%@include file="../partial/listModal.jsp" %>
        <%
        } else {
        %>
        <a class="waves-effect waves-light btn blue-grey darken-1 tooltipped" data-position="left"
           data-tooltip="목록"
           href="./partial/mobileQuestionList.jsp"><i class="material-icons">format_list_bulleted</i></a>
        <%
            }
        %>
        <!-- Add Question Modal -->
        <%@include file="../partial/addQuestionModal.jsp" %>
    </div>
    <div>
        <!-- ToolTips -->
        <%@include file="../partial/infoTooltip.jsp" %>
    </div>
</div>

<!-- Question Area -->
<div class="grey lighten-4 question-wrapper">
    <form class="input-field" method="post" id="form">
        <!-- Question -->
        <p class="question-wrapper__question">
            <%=sqlBankDTO.getQuestion().replaceAll("\n", "<br>")%>
        </p>
        <!-- Textarea -->
        <div class="input-field">
            <!-- Check Mobile -->
            <%
                if (sqlBankDTO.getQuizID() == 1 && !ua.equals("mobile")) {
            %>
            <textarea class="materialize-textarea question-wrapper__answer tooltipped"
                      data-position="left" data-tooltip="대소문자를 구분하지 않습니다.<br><br>
                   마지막에 세미콜론(;)을 붙여주세요.<br><br>
                   줄 바꿈(엔터)은 정답에 영향을 끼치지 않습니다." name="fullAnswer" placeholder="select * from movie;"
                      required></textarea>
            <%
            } else {
            %>
            <textarea class="materialize-textarea question-wrapper__answer" name="fullAnswer" required></textarea>
            <%
                }
            %>
        </div>
        <div class="submit-solution-button">
            <!-- Submit & Solution Button -->
            <%@include file="submitButton.jsp" %>
        </div>
    </form>
</div>

<!-- Solution Modal Content -->
<div id="sql-solution" class="modal bottom-sheet">
    <p class="modal-content solution">
        <%=sqlBankDTO.getSolution()%>
        <% if (sqlBankDTO.getSolution2() != null) { %>
        <br><br> <%=sqlBankDTO.getSolution2()%> <br><br>
        <% } %>
        <% if (sqlBankDTO.getSolution3() != null) { %>
        <%=sqlBankDTO.getSolution3()%>
        <% } %>
    </p>
</div>
<div class="list-add-info-wrapper">
    <div>
        <!-- Edit Question Modal -->
        <%
            if (session.getAttribute("user") != null) {
        %>
        <%@include file="editQuestionModal.jsp" %>
        <%
        } else {
        %>
        <a class="waves-effect waves-light btn modal-trigger blue-grey darken-3 tooltipped" data-position="right"
           data-tooltip="문제 수정은 로그인 후 사용 가능합니다."><i class="material-icons">edit</i></a>
        <%
            }
            // ADMIN 과 작성자, 수정 안된 문제만 삭제 가능
            if ((session.getAttribute("user") != null && java.net.URLDecoder.decode((String) session.getAttribute("user")).equals("ADMIN")) ||
                    session.getAttribute("user") != null && java.net.URLDecoder.decode((String) session.getAttribute("user")).equals(sqlBankDTO.getUser()) &&
                            sqlBankDTO.getEdit() == 0) {
        %>
        <!-- Delete Question -->
        <a class="waves-effect waves-light btn red darken-4"
           href="./action/deleteQuestionAction.jsp?id=<%=request.getParameter("id")%>">
            <i class="material-icons">delete</i>
        </a>
        <%
            }
        %>
    </div>
    <div class="btn disabled">
        <!-- Edit Count -->
        <span class="grey-text text-darken-3"><%=sqlBankDTO.getEdit()%>번 수정됨</span>
    </div>
</div>




















