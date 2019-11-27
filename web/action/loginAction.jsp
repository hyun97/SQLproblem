<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 라우팅 보안
    if ((session.getAttribute("user")) != null) {
        response.sendRedirect("../index?id=1");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    PrintWriter script = response.getWriter();
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(email, password);

    if (result == 1) {
        session.setAttribute("user", java.net.URLEncoder.encode(userDAO.getName(email)));
        script.println("<script>");
        script.println("location.href='../index?id=1'");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 0) {
        script.println("<script>");
        script.println("alert('비밀번호가 다릅니다')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    } else {
        script.println("<script>");
        script.println("alert('아이디가 존재하지 않습니다.')");
        script.println("location.href='../partial/login'");
        script.println("</script>");
        script.close();
        return;
    }
%>