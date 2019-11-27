<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="html-1.jsp" %>
<%@include file="header.jsp" %>
<%
    // 라우팅 보안
    if (session.getAttribute("user") != null) {
        response.sendRedirect("../index?id=1");
    }
%>
<script>
    document.title = "SQL Problem - Join";
</script>
<div class="join-wrapper container">
    <div class="container z-depth-1">
        <div class="row">
            <form class="col s12" id="reg-form" action="../action/joinAction.jsp" method="post">
                <div class="row">
                    <div class="col s12" style="text-align: center">
                        <h4>Sign Up</h4>
                    </div>
                    <div class="input-field col s12">
                        <input id="email" type="email" name="email" class="validate" required>
                        <label for="email">Email</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="user-name" type="text" name="name" class="validate" maxlength="13" required>
                        <label for="user-name">Name</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="password" type="password" name="password" class="validate" minlength="6"
                               required>
                        <label for="password">Password (최소 6자)</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="password2" type="password" name="password-verify" class="validate" minlength="6"
                               required>
                        <label for="password">Confirm Password</label>
                    </div>
                </div>
                <div class='row'>
                    <button class='col s12 btn btn-large waves-effect waves-light grey' type="submit" name="action">
                        Register
                    </button>
                </div>
                <div class='row'>
                    <%@include file="../api/naverLogin.jsp" %>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="html-2.jsp" %>