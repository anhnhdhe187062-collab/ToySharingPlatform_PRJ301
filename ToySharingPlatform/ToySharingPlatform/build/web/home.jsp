<%-- 
    Document   : home
    Created on : Apr 19, 2026, 5:09:42 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="Model.UserDTO"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ - Toy Sharing</title>
    </head>
    <body>
        <%
            // Ép kiểu UserDTO từ Session
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
            <h1>Chào mừng, <%= user.getFullName() %>!</h1>
            <p>Email: <%= user.getEmail() %></p>
            <hr>
            <a href="logout">Đăng xuất</a>
        <% } %>
    </body>
</html>
