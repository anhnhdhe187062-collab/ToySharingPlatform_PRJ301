<%-- 
    Document   : forgotpassword
    Created on : Apr 19, 2026, 4:50:24 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Quên mật khẩu - Toy Sharing</title>
    </head>
    <body>
        <div class="container">
            <h2>Khôi phục mật khẩu</h2>
            <form action="forgot" method="POST">
                <label>Tên đăng nhập</label><br>
                <input type="text" name="user" placeholder="Tài khoản" required>
                <label>Email liên hệ</label><br>
                <input type="email" name="email" placeholder="Email đăng ký" required>
                <label>Mật khẩu</label><br>
                <input type="password" name="newPass" placeholder="Mật khẩu mới" required>
                <p class="error">${requestScope.ERROR}</p>
                <p class="success">${requestScope.SUCCESS}</p>
                <button type="submit">Đổi mật khẩu</button>
            </form>
            <div class="options">
                <a href="login.jsp">Quay lại đăng nhập</a>
            </div>
        </div>
    </body>
</html>
