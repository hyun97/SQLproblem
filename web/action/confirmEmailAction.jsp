<%@ page import="user.UserDAO" %>
<%@ page import="util.Gmail" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../partial/html-1.jsp" %>
<%@include file="../partial/header.jsp" %>
<%
    // 라우팅 보안
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index?id=1");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String userName = java.net.URLDecoder.decode((String) session.getAttribute("user"));
    String mail = request.getParameter("mail");

    UserDAO userDAO = new UserDAO();
    if (userName != null) {
        String result = userDAO.getEmailVerify(userName);
        if (result.equals("1")) {
            // 이미 인증 되있을 경우
            response.sendRedirect("../index?id=1");
        } else if (mail != null && mail.equals("1")) {
            // 인증 성공
            int result2 = userDAO.setEmailVerify(userName);
            if (result2 == 1) {
                response.sendRedirect("../index?id=1");
            }
        }
    }

    String from = "nkh1602@gmail.com";
    String to = userDAO.getEmail(userName);
    String subject = "[SQL Problem] 이메일 주소를 인증해 주세요";
    String content = "<div style=\"text-align: center;\">" +
            "             <p style=\"font-size: 1.5em;\">" + userName + "님, 안녕하세요.</p>" +
            "             <br>" +
            "             <p style=\"font-size: 1.5em;\">SQL Problem 에 오신 것을 환영합니다! 시작하려면 이메일 주소를 인증해 주세요.</p>" +
            "             <br>" +
            "             <p>기타 문의 사항은 아래로 연락 해주세요: <br>" +
            "                 <a href=\"mailto:nkh1602@naver.com\">nkh1602@naver.com</a>" +
            "             </p>" +
            "             <br>" +
            "             <a href=\"http://localhost:8080/action/confirmEmailAction.jsp?mail=1\">" +
            "                 <button style=\"border: 0; padding: 12px 128px !important; font-size: 1.5em; font-weight:bold; color: white; border-radius:4px; height: auto !important; background-color: #ff5a5f;\">" +
            "                     이메일 주소 인증" +
            "                 </button>" +
            "             </a>" +
            "         </div>";


    Properties prof = new Properties();
    prof.put("mail.smtp.user", from);
    prof.put("mail.smtp.host", "smtp.googlemail.com");
    prof.put("mail.smtp.port", "465");
    prof.put("mail.smtp.starttls.enable", "true");
    prof.put("mail.smtp.auth", "true");
    prof.put("mail.smtp.debug", "true");
    prof.put("mail.smtp.socketFactory.port", "465");
    prof.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    prof.put("mail.smtp.socketFactory.fallback", "false");

    try {
        Authenticator auth = new Gmail();

        Session ses = Session.getInstance(prof, auth);
        ses.setDebug(true);

        MimeMessage msg = new MimeMessage(ses);
        msg.setSubject(subject);

        Address fromAddr = new InternetAddress(from);
        msg.setFrom(fromAddr);

        Address toAddr = new InternetAddress(to);
        msg.addRecipient(Message.RecipientType.TO, toAddr);

        msg.setContent(content, "text/html;charset=UTF-8");

        Transport.send(msg);

        response.sendRedirect("../partial/sendConfirmEmail");
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('인증 메일 오류')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>
<%@include file="../partial/html-2.jsp" %>
