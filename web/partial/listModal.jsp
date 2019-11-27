<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Question List Modal -->
<a class="waves-effect waves-light btn modal-trigger blue-grey darken-1 tooltipped" data-position="left"
   data-tooltip="목록"
   href="#question-list"><i class="material-icons">format_list_bulleted</i></a>

<div id="question-list" class="modal">
    <div class="modal-content blue-grey darken-4">
        <!-- Question List -->
        <%
            ArrayList<SqlBankDTO> sqlBankList = new SqlBankDAO().getSqlBankList();
        %>
        <!-- DML Part -->
        <ul class="collection with-header first">
            <li class="collection-header list-header-wrapper">
                <h4>DML</h4>
            </li>
            <%
                for (i = 0; i < sqlBankList.size(); i++) {
                    SqlBankDTO sqlBankListDTO = sqlBankList.get(i);
                    if (sqlBankListDTO.getPart().equals("dml")) {
            %>
            <li class="list-content-wrapper">
                <a href="../index?id=<%=sqlBankListDTO.getQuizID()%>" class="collection-item black-text">
                    <%=sqlBankListDTO.getTitle()%> &nbsp
                    <%
                        if (sqlBankListDTO.getStar() < 9999) {
                    %>
                    <span class="red-text">★</span><%=sqlBankListDTO.getStar()%>
                    <%
                        }
                    %>
                </a>
            </li>
            <%
                    }
                }
            %>
        </ul>
        <!-- DDL Part -->
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>DDL</h4>
            </li>
            <%
                for (i = 0; i < sqlBankList.size(); i++) {
                    SqlBankDTO sqlBankListDTO = sqlBankList.get(i);
                    if (sqlBankListDTO.getPart().equals("ddl")) {
            %>
            <li class="list-content-wrapper">
                <a href="../index?id=<%=sqlBankListDTO.getQuizID()%>" class="collection-item black-text">
                    <%=sqlBankListDTO.getTitle()%> &nbsp
                    <%
                        if (sqlBankListDTO.getStar() < 9999) {
                    %>
                    <span class="red-text">★</span><%=sqlBankListDTO.getStar()%>
                    <%
                        }
                    %>
                </a>
            </li>
            <%
                    }
                }
            %>
        </ul>
        <!-- DCL Part -->
        <ul class="collection with-header">
            <li class="collection-header">
                <h4>DCL</h4>
            </li>
            <%
                for (i = 0; i < sqlBankList.size(); i++) {
                    SqlBankDTO sqlBankListDTO = sqlBankList.get(i);
                    if (sqlBankListDTO.getPart().equals("dcl")) {
            %>
            <li class="list-content-wrapper">
                <a href="../index?id=<%=sqlBankListDTO.getQuizID()%>" class="collection-item black-text">
                    <%=sqlBankListDTO.getTitle()%> &nbsp
                    <%
                        if (sqlBankListDTO.getStar() < 9999) {
                    %>
                    <span class="red-text">★</span><%=sqlBankListDTO.getStar()%>
                    <%
                        }
                    %>
                </a>
            </li>
            <%
                    }
                }
            %>
        </ul>
        <!-- ETC Part -->
        <ul class="collection with-header last">
            <li class="collection-header">
                <h4>ETC</h4>
            </li>
            <%
                for (i = 0; i < sqlBankList.size(); i++) {
                    SqlBankDTO sqlBankListDTO = sqlBankList.get(i);
                    if (sqlBankListDTO.getPart().equals("etc")) {
            %>
            <li class="list-content-wrapper">
                <a href="../index?id=<%=sqlBankListDTO.getQuizID()%>" class="collection-item black-text">
                    <%=sqlBankListDTO.getTitle()%> &nbsp
                    <%
                        if (sqlBankListDTO.getStar() < 9999) {
                    %>
                    <span class="red-text">★</span><%=sqlBankListDTO.getStar()%>
                    <%
                        }
                    %>
                </a>
            </li>
            <%
                    }
                }
            %>
        </ul>
    </div>
</div>

