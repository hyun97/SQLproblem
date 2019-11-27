<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<a class="waves-effect waves-light btn modal-trigger blue-grey darken-3 tooltipped"
   href="#edit_sql" data-position="left" data-tooltip="수정"><i class="material-icons">edit</i></a>

<div id="edit_sql" class="modal add-edit-wrapper">
    <div class="modal-content blue-grey darken-4">
        <ul class="collection with-header white">
            <li class="collection-header">
                <h4>EDIT</h4>
            </li>
            <li class="collection-item">
                <form action="../action/editQuestionAction.jsp" method="post"
                      autocomplete="off">
                    <input type="hidden" value="<%=request.getParameter("id")%>" name="quizID">
                    <div class="input-field col s12">
                        <select name="part" required>
                            <option value="" selected disabled>Choose PART</option>
                            <option value="dml" <% if (sqlBankDTO.getPart().equals("dml"))
                                out.print("selected"); %>>DML
                            </option>
                            <option value="ddl" <% if (sqlBankDTO.getPart().equals("ddl"))
                                out.print("selected"); %>>DDL
                            </option>
                            <option value="dcl" <% if (sqlBankDTO.getPart().equals("dcl"))
                                out.print("selected"); %>>DCL
                            </option>
                            <option value="etc" <% if (sqlBankDTO.getPart().equals("etc"))
                                out.print("selected"); %>>ETC
                            </option>
                        </select>
                        <!-- 글 등록자, ADMIN 만 타이틀, 문제 수정 가능 -->
                        <p>TITLE</p>
                        <%
                            if (java.net.URLDecoder.decode((String) session.getAttribute("user")).equals(sqlBankDTO.getUser()) ||
                                    java.net.URLDecoder.decode((String) session.getAttribute("user")).equals("ADMIN")) {
                        %>
                        <input type="text" name="title" value="<%=sqlBankDTO.getTitle()%>" maxlength="35" required>
                        <%
                        } else {
                        %>
                        <input type="text" class="grey-text" name="title"
                               value="<%=sqlBankDTO.getTitle()%>"
                               maxlength="35" readonly style="border-bottom: dotted">
                        <%
                            }
                        %>
                        <p>QUESTION</p>
                        <%
                            if (java.net.URLDecoder.decode((String) session.getAttribute("user")).equals(sqlBankDTO.getUser()) ||
                                    java.net.URLDecoder.decode((String) session.getAttribute("user")).equals("ADMIN")) {
                        %>
                        <input type="text" name="question" value="<%=sqlBankDTO.getQuestion()%>" required>
                        <%
                        } else {
                        %>
                        <input type="text" class="grey-text" name="question"
                               value="<%=sqlBankDTO.getQuestion()%>" readonly style="border-bottom: dotted">
                        <%
                            }
                        %>
                        <p>SOLUTION 1</p>
                        <input type="text" name="solution" value="<%=sqlBankDTO.getSolution()%>" required>
                        <p>SOLUTION 2</p>
                        <input type="text" name="solution2"
                               value="<% if (sqlBankDTO.getSolution2() != null) out.println(sqlBankDTO.getSolution2()); %>">
                        <p>SOLUTION 3</p>
                        <input type="text" name="solution3"
                               value="<% if (sqlBankDTO.getSolution3() != null) out.println(sqlBankDTO.getSolution3()); %>">
                        <button class="btn waves-effect waves-light" type="submit" name="action">Edit
                            <i class="material-icons right">send</i>
                        </button>
                    </div>
                </form>
            </li>
        </ul>
    </div>
</div>

