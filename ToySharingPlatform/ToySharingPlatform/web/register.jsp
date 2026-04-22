<%-- 
    Document   : register
    Created on : Apr 19, 2026, 4:42:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Đăng ký - Toy Sharing</title>
    </head>
    <body>
        <div class="container">
            <h2>Đăng ký tài khoản</h2>
            <form action="register" method="POST">
                <label>Tên đăng nhập</label><br>
                <input type="text" name="userID" placeholder="Tên tài khoản" required>
                <label>Mật khẩu</label><br>
                <input type="password" name="password" placeholder="Mật khẩu" required>
                <label>Họ và tên</label><br>
                <input type="text" name="fullName" placeholder="Họ và tên" required>
                <label>Email liên hệ</label><br>
                <input type="email" name="email" placeholder="Email" required>
                <button type="submit">Đăng ký ngay</button>
            </form>
            <div class="options">
                <a href="login.jsp">Đã có tài khoản? Đăng nhập</a>
            </div>
        </div>
    </body>
</html>
