<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    String user = request.getParameter("user");

    // 라우팅 보안
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index?id=1");
        return;
    }
    if (session.getAttribute("user") != null && !java.net.URLDecoder.decode((String) session.getAttribute("user")).equals(user)) {
        response.sendRedirect("../index?id=1");
        return;
    }
    PrintWriter script = response.getWriter();

    String userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    String newName = request.getParameter("name");
    String newEmail = request.getParameter("email");
    String currentPassword = request.getParameter("current-password");
    String newPassword = request.getParameter("new-password");

    UserDAO userDAO = new UserDAO();
    int result = userDAO.editProfile(userName, newName, newEmail, currentPassword, newPassword);

    if (result == 1) {
        // 성공
        session.setAttribute("user", java.net.URLEncoder.encode(newName));
        response.sendRedirect("../partial/profile?user=" + session.getAttribute("user"));
    } else if (result == 0) {
        // 현재 비밀번호 인증 실패
        script.println("<script>");
        script.println("alert('현재 비밀번호가 일치하지 않습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 2) {
        // 이름 중복
        script.println("<script>");
        script.println("alert('이미 존재하는 이름입니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 3) {
        // 이메일 중복
        script.println("<script>");
        script.println("alert('이미 존재하는 이메일입니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    } else {
        // db 오류
        script.println("<script>");
        script.println("alert('db 오류')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>


