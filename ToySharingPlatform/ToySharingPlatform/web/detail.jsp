<%-- 
    Document   : detail
    Created on : Apr 23, 2026
    Author     : Part B - Toy Management & Browsing
    Description: Trang chi tiết đồ chơi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserDTO"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${requestScope.TOY.toyName} - Toy Sharing Platform</title>
        <style>
            /* ===== RESET & GLOBAL ===== */
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #e0f7fa 0%, #f3e5f5 100%);
                min-height: 100vh;
            }

            /* ===== NAVBAR ===== */
            .navbar {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 15px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            }
            .navbar .logo {
                font-size: 24px;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .navbar .logo span { font-size: 28px; }
            .navbar .nav-links {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .navbar .nav-links a {
                color: rgba(255,255,255,0.9);
                text-decoration: none;
                font-size: 14px;
                padding: 8px 16px;
                border-radius: 20px;
                transition: all 0.3s ease;
            }
            .navbar .nav-links a:hover {
                background: rgba(255,255,255,0.2);
                color: #fff;
            }
            .navbar .user-info {
                color: #fff;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .navbar .user-info .avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                background: rgba(255,255,255,0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 16px;
            }
            .btn-logout {
                background: rgba(255,255,255,0.2);
                color: #fff !important;
                padding: 8px 20px;
                border-radius: 20px;
                text-decoration: none;
                font-size: 13px;
                transition: all 0.3s ease;
                border: 1px solid rgba(255,255,255,0.3);
            }
            .btn-logout:hover {
                background: rgba(255,255,255,0.35);
            }

            /* ===== BREADCRUMB ===== */
            .breadcrumb {
                max-width: 1000px;
                margin: 20px auto 0;
                padding: 0 20px;
                font-size: 14px;
                color: #888;
            }
            .breadcrumb a {
                color: #667eea;
                text-decoration: none;
            }
            .breadcrumb a:hover {
                text-decoration: underline;
            }

            /* ===== DETAIL CONTAINER ===== */
            .detail-container {
                max-width: 1000px;
                margin: 20px auto 40px;
                padding: 0 20px;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 40px;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 30px rgba(0,0,0,0.08);
                overflow: hidden;
            }

            /* ===== IMAGE SECTION ===== */
            .detail-image {
                width: 100%;
                min-height: 400px;
                background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }
            .detail-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .detail-image .no-image {
                font-size: 100px;
                color: #ccc;
            }

            /* ===== INFO SECTION ===== */
            .detail-info {
                padding: 40px 30px 40px 0;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .detail-info .category-tag {
                display: inline-block;
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: #fff;
                padding: 5px 16px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 12px;
                width: fit-content;
            }
            .detail-info h1 {
                font-size: 28px;
                color: #333;
                margin-bottom: 16px;
                line-height: 1.3;
            }
            .detail-info .description {
                font-size: 15px;
                color: #666;
                line-height: 1.7;
                margin-bottom: 24px;
            }

            /* ===== INFO TABLE ===== */
            .info-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 24px;
            }
            .info-table tr {
                border-bottom: 1px solid #f0f0f0;
            }
            .info-table td {
                padding: 12px 0;
                font-size: 14px;
            }
            .info-table td:first-child {
                color: #999;
                width: 120px;
                font-weight: 500;
            }
            .info-table td:last-child {
                color: #333;
                font-weight: 500;
            }

            /* ===== BADGES ===== */
            .badge {
                display: inline-block;
                padding: 4px 14px;
                border-radius: 12px;
                font-size: 13px;
                font-weight: 600;
            }
            .badge-condition {
                background: linear-gradient(135deg, #43e97b, #38f9d7);
                color: #1a5e3a;
            }
            .badge-available {
                background: linear-gradient(135deg, #a8edea, #fed6e3);
                color: #2d7a6f;
            }
            .badge-shared {
                background: #fff3cd;
                color: #856404;
            }

            /* ===== BUTTONS ===== */
            .btn-group {
                display: flex;
                gap: 12px;
                margin-top: 10px;
            }
            .btn-primary {
                flex: 1;
                padding: 14px 24px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: #fff;
                border: none;
                border-radius: 12px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                width: auto;
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
                opacity: 0.95;
            }
            .btn-secondary {
                padding: 14px 24px;
                background: #f5f5f5;
                color: #666;
                border: none;
                border-radius: 12px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                text-align: center;
                width: auto;
            }
            .btn-secondary:hover {
                background: #e8e8e8;
            }

            /* ===== POST DATE ===== */
            .post-date {
                font-size: 12px;
                color: #bbb;
                margin-top: 16px;
            }

            /* ===== FOOTER ===== */
            .footer {
                text-align: center;
                padding: 30px;
                color: #999;
                font-size: 13px;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .detail-container {
                    grid-template-columns: 1fr;
                }
                .detail-info {
                    padding: 30px;
                }
            }
        </style>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
        %>

        <!-- NAVBAR -->
        <nav class="navbar">
            <a href="home" class="logo">
                <span>🧸</span> Toy Sharing
            </a>
            <div class="nav-links">
                <a href="home">Trang chủ</a>
                <% if (user != null) { %>
                    <div class="user-info">
                        <div class="avatar"><%= user.getFullName().charAt(0) %></div>
                        <span style="color: #fff;">Xin chào, <strong><%= user.getFullName() %></strong></span>
                    </div>
                    <a href="profile.jsp">Hồ sơ</a>
                    <a href="logout" class="btn-logout">Đăng xuất</a>
                <% } else { %>
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="register.jsp">Đăng ký</a>
                <% } %>
            </div>
        </nav>

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="home">🏠 Trang chủ</a> &raquo; 
            <span>${requestScope.TOY.toyName}</span>
        </div>

        <!-- DETAIL CONTENT -->
        <c:if test="${not empty requestScope.TOY}">
            <div class="detail-container">
                <!-- IMAGE -->
                <div class="detail-image">
                    <c:choose>
                        <c:when test="${not empty requestScope.TOY.imageURL}">
                            <img src="assets/images/${requestScope.TOY.imageURL}" 
                                 alt="${requestScope.TOY.toyName}"
                                 onerror="this.parentElement.innerHTML='<div class=no-image>🧸</div>'">
                        </c:when>
                        <c:otherwise>
                            <div class="no-image">🧸</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- INFO -->
                <div class="detail-info">
                    <div class="category-tag">📂 ${requestScope.TOY.categoryName}</div>
                    <h1>${requestScope.TOY.toyName}</h1>
                    <p class="description">${requestScope.TOY.description}</p>

                    <table class="info-table">
                        <tr>
                            <td>📦 Tình trạng</td>
                            <td><span class="badge badge-condition">${requestScope.TOY.condition}</span></td>
                        </tr>
                        <tr>
                            <td>📋 Trạng thái</td>
                            <td>
                                <c:choose>
                                    <c:when test="${requestScope.TOY.status == 'Available'}">
                                        <span class="badge badge-available">✅ Sẵn sàng cho mượn</span>
                                    </c:when>
                                    <c:when test="${requestScope.TOY.status == 'Shared'}">
                                        <span class="badge badge-shared">🔄 Đang được mượn</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge">${requestScope.TOY.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td>👤 Chủ sở hữu</td>
                            <td>${requestScope.TOY.ownerName}</td>
                        </tr>
                    </table>

                    <div class="btn-group">
                        <c:if test="${requestScope.TOY.status == 'Available'}">
                            <a href="#" class="btn-primary">📩 Yêu cầu mượn</a>
                        </c:if>
                        <a href="home" class="btn-secondary">⬅ Quay lại</a>
                    </div>

                    <c:if test="${not empty requestScope.TOY.postDate}">
                        <div class="post-date">📅 Đăng ngày: ${requestScope.TOY.postDate}</div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2026 Toy Sharing Platform - FPT University | Chia sẻ niềm vui cùng bé yêu 🧡</p>
        </div>
    </body>
</html>
