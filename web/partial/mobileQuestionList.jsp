<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="sqlBank.SqlBankDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="html-1.jsp" %>
<%@include file="header.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<div class="container">
    <!-- SQL List -->
    <div class="row">
        <!-- (DML) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">DML</h4>
                </li>
                <%
                    ArrayList<SqlBankDTO> sqlBankList = new SqlBankDAO().getSqlBankList();
                    for (int i = 0; i < sqlBankList.size(); i++) {
                        SqlBankDTO sqlBankDTO = sqlBankList.get(i);
                        if (sqlBankDTO.getPart().equals("dml")) {
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <%
                            if (sqlBankDTO.getStar() < 9999) {
                        %>
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
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
        <!-- (DDL) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">DDL</h4>
                </li>
                <%
                    for (int i = 0; i < sqlBankList.size(); i++) {
                        SqlBankDTO sqlBankDTO = sqlBankList.get(i);
                        if (sqlBankDTO.getPart().equals("ddl")) {
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <%
                            if (sqlBankDTO.getStar() < 9999) {
                        %>
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
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
        <!-- (DCL) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">DCL</h4>
                </li>
                <%
                    for (int i = 0; i < sqlBankList.size(); i++) {
                        SqlBankDTO sqlBankDTO = sqlBankList.get(i);
                        if (sqlBankDTO.getPart().equals("dcl")) {
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <%
                            if (sqlBankDTO.getStar() < 9999) {
                        %>
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
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
        <!-- (ETC) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">ETC</h4>
                </li>
                <%
                    for (int i = 0; i < sqlBankList.size(); i++) {
                        SqlBankDTO sqlBankDTO = sqlBankList.get(i);
                        if (sqlBankDTO.getPart().equals("etc")) {
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <%
                            if (sqlBankDTO.getStar() < 9999) {
                        %>
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
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
</div>
<%@include file="html-2.jsp" %>

