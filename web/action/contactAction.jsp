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

<%
    request.setCharacterEncoding("UTF-8");

    String contactEmail = request.getParameter("contactEmail");
    String contactTitle = request.getParameter("contactTitle");
    String contentText = request.getParameter("contactText");

    String from = "nkh1602@gmail.com";
    String to = "nkh1602@naver.com";
    String subject = "[SQL Problem] " + contactTitle;
    String content = contentText + "  [" + contactEmail + "]";

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

        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('메일이 전송 되었습니다.')");
        script.println("location.href='../index?id=1'");
        script.println("</script>");
        script.close();
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류 발생')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>