<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 라우팅 보안
    if (session.getAttribute("user") != null) {
        response.sendRedirect("../index?id=1");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String passwordVerify = request.getParameter("password-verify");
    PrintWriter script = response.getWriter();

    if (password.equals(passwordVerify)) {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.signUp(new UserDTO(name, SHA256.getSHA256(password), email, 0));
        if (result == 1) {
            session.setAttribute("user", java.net.URLEncoder.encode(name));
            script.println("<script>");
            script.println("location.href='confirmEmailAction.jsp'");
            script.println("</script>");
            script.close();
            return;
        } else {
            script.println("<script>");
            script.println("alert('이미 존재하는 이메일 or 이름 입니다.')");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }
    } else {
        script.println("<script>");
        script.println("alert('비밀번호가 다릅니다')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>