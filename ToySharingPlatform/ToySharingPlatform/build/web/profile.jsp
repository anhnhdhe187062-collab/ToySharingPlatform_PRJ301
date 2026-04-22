<%-- 
    Document   : profile
    Created on : Apr 19, 2026, 5:09:55 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ sơ cá nhân</title>
    </head>
    <body>
        <h2>Thông tin tài khoản</h2>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user != null) {
        %>
            <form action="updateProfile" method="POST">
                ID: <input type="text" value="<%= user.getUserID() %>" readonly><br>
                Họ tên: <input type="text" name="fullName" value="<%= user.getFullName() %>"><br>
                Email: <input type="email" name="email" value="<%= user.getEmail() %>"><br>
                <button type="submit">Cập nhật thông tin</button>
            </form>
        <% } %>
        <br>
        <a href="home.jsp">Quay lại trang chủ</a>
    </body>
</html>
