<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (userName == null) {
%>
<!-- Add Question Modal Disabled -->
<a class="waves-effect waves-light btn modal-trigger blue-grey darken-3 tooltipped" data-position="right"
   data-tooltip="문제 등록은 로그인 후 사용 가능합니다."><i class="material-icons">add</i></a>
<%
} else {
%>
<!-- Add Question Modal -->
<a class="waves-effect waves-light btn modal-trigger blue-grey darken-3 tooltipped" data-position="right"
   data-tooltip="문제 등록"
   href="#add_sql"><i class="material-icons">add</i></a>
<%
    }
%>

<div id="add_sql" class="modal add-edit-wrapper">
    <div class="modal-content blue-grey darken-4">
        <ul class="collection with-header white">
            <li class="collection-header">
                <h4>ADD YOUR SQL !</h4>
            </li>
            <li class="collection-item">
                <form action="../action/addQuestionAction.jsp" method="post" autocomplete="off">
                    <div class="input-field col s12">
                        <select name="part" required>
                            <option value="" selected disabled>Choose PART</option>
                            <option value="dml">DML</option>
                            <option value="ddl">DDL</option>
                            <option value="dcl">DCL</option>
                            <option value="etc">ETC</option>
                        </select>
                        <p>TITLE</p>
                        <input type="text" name="title" maxlength="35" placeholder="문제의 주제를 간단하게 설명해 주세요." required>
                        <p>QUESTION</p>
                        <input type="text" name="question" required>
                        <p>SOLUTION 1</p>
                        <input type="text" name="solution" required>
                        <p>SOLUTION 2</p>
                        <input type="text" name="solution2">
                        <p>SOLUTION 3</p>
                        <input type="text" name="solution3">
                        <button class="btn waves-effect waves-light" type="submit" name="action">Submit
                            <i class="material-icons right">send</i>
                        </button>
                    </div>
                </form>
            </li>
        </ul>
    </div>
</div>

