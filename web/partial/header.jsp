<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Header -->
<nav class="nav-wrapper">
    <div class="container">
        <!-- Logo -->
        <a href="../index?id=1" class="brand-logo">SQL Problem</a>

        <!-- Links -->
        <ul class="right hide-on-med-and-down">
            <%
                if (session.getAttribute("user") == null) {
            %>
            <li><a class="btn tooltipped" href="../partial/join" data-tooltip="문제 등록 및 문제 저장 활성화"
                   data-position="bottom">Sign
                up</a>
            </li>
            <li><a href="../partial/login">Login</a></li>
            <%@include file="aboutModal.jsp" %>
            <%@include file="contactModal.jsp" %>
            <%
            } else {
            %>
            <li><a class="btn"
                   href="../partial/profile?user=<%=java.net.URLDecoder.decode((String) session.getAttribute("user"))%>">MyPage</a>
            </li>
            <li><a href="../action/logoutAction.jsp">Logout</a></li>
            <%@include file="aboutModal.jsp" %>
            <%@include file="contactModal.jsp" %>
            <%
                }
            %>
        </ul>

        <!-- Hamburger Menu List (On Mobile) -->
        <a href="#" data-target="mobile-links" class="sidenav-trigger left"><i
                class="material-icons">menu</i></a>
        <ul class="sidenav" id="mobile-links">
            <%
                if (session.getAttribute("user") == null) {
            %>
            <li><a class="btn" href="../partial/join">Sign up</a></li>
            <li><a href="../index?id=1">Home</a></li>
            <li><a href="../partial/login">Login</a></li>
            <%
            } else {
            %>
            <li><a class="btn modal-trigger"
                   href="../partial/profile?user=<%=java.net.URLDecoder.decode((String) session.getAttribute("user"))%>">MyPage</a>
            </li>
            <li><a href="../index?id=1">Home</a></li>
            <li><a href="../action/logoutAction.jsp">Logout</a></li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
