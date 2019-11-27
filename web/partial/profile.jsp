<%@ page import="sqlBank.SqlBankDAO" %>
<%@ page import="sqlBank.SqlBankDTO" %>
<%@ page import="star.StarDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="html-1.jsp" %>
<%@include file="header.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("user");
    UserDAO userDAO = new UserDAO();
    String userEmail;
    String userPassword;
    if (session.getAttribute("user") != null) {
        userEmail = userDAO.getEmail(java.net.URLDecoder.decode((String) session.getAttribute("user")));
        userPassword = userDAO.getPassword(java.net.URLDecoder.decode((String) session.getAttribute("user")));
    } else {
        userEmail = userDAO.getEmail((String) session.getAttribute("user"));
        userPassword = userDAO.getPassword((String) session.getAttribute("user"));
    }
%>
<script>
    document.title = "SQL Problem - <%=userName%>";
</script>
<div class="container">
    <!-- User Name & Edit Profile -->
    <div class="profile-wrapper">
        <div class="profile-wrapper__name">
            <%=userName%>
        </div>
        <%
            String user;
            if (session.getAttribute("user") != null) {
                user = java.net.URLDecoder.decode((String) session.getAttribute("user"));
            } else {
                user = userDAO.getPassword((String) session.getAttribute("user"));
            }
            if (session.getAttribute("user") != null && user.equals(userName)) {
        %>
        <a class="profile-wrapper__edit modal-trigger" href="#edit-profile">Edit</a>
        <%
            }
        %>
    </div>

    <!-- Edit Profile Modal -->
    <div id="edit-profile" class="modal add-edit-wrapper">
        <div class="modal-content blue-grey darken-4">
            <ul class="collection with-header white">
                <li class="collection-header">
                    <h4>EDIT PROFILE</h4>
                </li>
                <li class="collection-item">
                    <form action="../action/editProfileAction.jsp?user=<%=userName%>" method="post" autocomplete="off">
                        <div class="input-field col s12">
                            <p>NAME</p>
                            <input type="text" name="name" value="<%=userName%>"
                                   maxlength="13" required>
                            <%
                                if (userPassword == null) {
                            %>
                            <p>EMAIL</p>
                            <input type="text" class="grey-text" name="email"
                                   value="<%=userEmail%>" readonly style="border-bottom: dotted">
                            <p>CURRENT PASSWORD</p>
                            <input type="text" class="grey-text" name="current-password"
                                   placeholder="소셜계정은 비밀번호를 변경할 수 없습니다."
                                   readonly style="border-bottom: dotted">
                            <p>NEW PASSWORD</p>
                            <input type="text" class="grey-text" name="new-password"
                                   placeholder="소셜계정은 비밀번호를 변경할 수 없습니다."
                                   readonly style="border-bottom: dotted">
                            <%
                            } else {
                            %>
                            <p>EMAIL</p>
                            <input type="text" name="email" value="<%=userEmail%>">
                            <p>CURRENT PASSWORD</p>
                            <input type="password" name="current-password" class="currentPassword"
                                   placeholder="비밀번호 변경을 원할 경우 작성">
                            <p>NEW PASSWORD</p>
                            <input type="password" name="new-password" minlength="6">
                            <%
                                }
                            %>
                            <button class="btn waves-effect waves-light" type="submit" name="action">Edit
                                <i class="material-icons right">send</i>
                            </button>
                        </div>
                    </form>
                </li>
            </ul>
        </div>
    </div>

    <!-- SQL List -->
    <div class="row">
        <!-- (Register) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">YOUR SQL</h4>
                </li>
                <%
                    ArrayList<SqlBankDTO> mySqlList = new SqlBankDAO().getMySqlList(userName);
                    for (int i = 0; i < mySqlList.size(); i++) {
                        SqlBankDTO sqlBankDTO = mySqlList.get(i);
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
                    </a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>

        <!-- (Favorite) -->
        <div class="col s12 m6 mySql-wrapper">
            <ul class="collection with-header z-depth-1">
                <li class="collection-header">
                    <h4 class="mySql-wrapper__title">FAVORITE SQL</h4>
                    <%
                        StarDAO starDAO = new StarDAO();
                        int firstQuizID = starDAO.getFavoriteID(userName);
                        if (firstQuizID != -2) {
                    %>
                    <a href="../index?id=<%=firstQuizID%>&playlist=<%=userName%>"
                       class="btn-small waves-effect waves-light deep-orange darken-2">
                        Start <i class="material-icons right">fast_forward</i>
                    </a>
                    <%
                    } else {
                    %>
                    <a href="../index?id=<%=firstQuizID%>&playlist=<%=userName%>"
                       class="btn-small disabled waves-effect waves-light deep-orange darken-2">
                        Start <i class="material-icons right">fast_forward</i>
                    </a>
                    <%
                        }
                    %>
                </li>
                <%
                    ArrayList<SqlBankDTO> starSqlList = new SqlBankDAO().getStarSqlList(userName);
                    for (int i = 0; i < starSqlList.size(); i++) {
                        SqlBankDTO sqlBankDTO = starSqlList.get(i);
                %>
                <li class="list-content-wrapper">
                    <a href="../index?id=<%=sqlBankDTO.getQuizID()%>" class="collection-item black-text">
                        <%=sqlBankDTO.getTitle()%> &nbsp
                        <span class="red-text">★</span><%=sqlBankDTO.getStar()%>
                    </a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</div>
<%@include file="html-2.jsp" %>

