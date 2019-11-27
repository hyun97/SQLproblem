<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="html-1.jsp" %>
<%@include file="header.jsp" %>
<%
    // 라우팅 보안
    if (session.getAttribute("user") != null) {
        response.sendRedirect("../index.jsp?id=1");
    }
%>
<script>
    document.title = "SQL Problem - Login";
</script>
<div style="text-align: center;">
    <div class="container login-wrapper">
        <div class="z-depth-1 white row login-wrapper__row">
            <form class="col s12" method="post" action="../action/loginAction.jsp">
                <div class='row'>
                    <div class='col s12'></div>
                </div>
                <div class='row'>
                    <h4>Login</h4>
                    <div class='input-field col s12'>
                        <input class='validate' type='email' name='email' id='email' required/>
                        <label for='email'>Enter your email</label>
                    </div>
                </div>
                <div class='row'>
                    <div class='input-field col s12'>
                        <input class='validate' type='password' name='password' id='password' required/>
                        <label for='password'>Enter your password</label>
                    </div>
                </div>
                <br/>
                <div style="text-align: center;">
                    <div class='row'>
                        <button type='submit' name='btn_login'
                                class='col s12 btn btn-large waves-effect waves-light teal grey'>
                            Login
                        </button>
                    </div>
                    <div class='row'>
                        <%@include file="../api/naverLogin.jsp" %>
                    </div>
                </div>
                <a href="../partial/join">Create account</a>
            </form>
        </div>
    </div>
</div>
<%@include file="html-2.jsp" %>
