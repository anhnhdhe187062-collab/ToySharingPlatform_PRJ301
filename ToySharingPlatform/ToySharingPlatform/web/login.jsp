<%-- 
    Document   : login
    Created on : Apr 19, 2026, 4:37:56 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Đăng nhập - Toy Sharing</title>
    </head>
    <body>
        <div class="container">
            <h2>Hệ thống đăng nhập</h2>
            <form action="login" method="POST">
                <label for="user">Tài khoản</label><br>
                <input type="text" name="user" placeholder="Tài khoản" required>
                <label for="pass">Mật khẩu</label><br>
                <input type="password" name="pass" placeholder="Mật khẩu" required>
                <p class="error">${requestScope.ERROR}</p>
                <button type="submit">Đăng nhập</button>
            </form>
            <div class="options">
                <a href="register.jsp">Đăng ký tài khoản</a> | 
                <a href="forgotPassword.jsp">Quên mật khẩu?</a>
            </div>
        </div>
    </body>
</html>
