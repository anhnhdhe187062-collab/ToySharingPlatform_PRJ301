<%-- 
    Document   : home
    Created on : Apr 19, 2026
    Author     : ADMIN
    Description: Trang chủ - Hiển thị danh sách đồ chơi dạng card
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserDTO"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ - Toy Sharing Platform</title>
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            /* ===== RESET & GLOBAL ===== */
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #e0f7fa 0%, #f3e5f5 100%);
                min-height: 100vh;
                display: block;
                height: auto;
                align-items: normal;
                justify-content: normal;
            }

            /* ===== HEADER / NAVBAR ===== */
            .navbar {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 15px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
                position: sticky;
                top: 0;
                z-index: 100;
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

            /* ===== HERO SECTION ===== */
            .hero {
                text-align: center;
                padding: 40px 20px 20px;
            }
            .hero h1 {
                font-size: 32px;
                color: #4a148c;
                margin-bottom: 8px;
            }
            .hero p {
                color: #666;
                font-size: 16px;
            }

            /* ===== SEARCH & FILTER BAR ===== */
            .filter-bar {
                max-width: 900px;
                margin: 20px auto;
                display: flex;
                gap: 12px;
                padding: 0 20px;
                flex-wrap: wrap;
                justify-content: center;
            }
            .search-box {
                display: flex;
                flex: 1;
                min-width: 280px;
                max-width: 500px;
            }
            .search-box input[type="text"] {
                flex: 1;
                padding: 12px 20px;
                border: 2px solid #e0e0e0;
                border-right: none;
                border-radius: 25px 0 0 25px;
                font-size: 14px;
                outline: none;
                transition: border-color 0.3s;
                width: auto;
                margin: 0;
            }
            .search-box input[type="text"]:focus {
                border-color: #667eea;
            }
            .search-box button {
                padding: 12px 24px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: #fff;
                border: none;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
                font-size: 14px;
                transition: opacity 0.3s;
                width: auto;
            }
            .search-box button:hover {
                opacity: 0.9;
            }
            .category-filter select {
                padding: 12px 20px;
                border: 2px solid #e0e0e0;
                border-radius: 25px;
                font-size: 14px;
                outline: none;
                background: #fff;
                cursor: pointer;
                color: #333;
                transition: border-color 0.3s;
            }
            .category-filter select:focus {
                border-color: #667eea;
            }

            /* ===== TOY CARDS GRID ===== */
            .toy-grid {
                max-width: 1200px;
                margin: 30px auto;
                padding: 0 20px;
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
                gap: 25px;
            }
            .toy-card {
                background: #fff;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                cursor: pointer;
                text-decoration: none;
                color: inherit;
                display: flex;
                flex-direction: column;
            }
            .toy-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 12px 35px rgba(102,126,234,0.2);
            }
            .toy-card .card-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }
            .toy-card .card-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .toy-card .card-image .no-image {
                font-size: 48px;
                color: #ccc;
            }
            .toy-card .card-body {
                padding: 18px;
                flex: 1;
                display: flex;
                flex-direction: column;
            }
            .toy-card .card-body .card-category {
                font-size: 11px;
                color: #667eea;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 6px;
            }
            .toy-card .card-body h3 {
                font-size: 17px;
                color: #333;
                margin-bottom: 8px;
                line-height: 1.3;
            }
            .toy-card .card-body .card-desc {
                font-size: 13px;
                color: #888;
                margin-bottom: 12px;
                line-height: 1.5;
                flex: 1;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            .toy-card .card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 18px;
                border-top: 1px solid #f0f0f0;
                font-size: 12px;
            }
            .card-footer .condition-badge {
                background: linear-gradient(135deg, #43e97b, #38f9d7);
                color: #1a5e3a;
                padding: 4px 12px;
                border-radius: 12px;
                font-weight: 600;
                font-size: 11px;
            }
            .card-footer .owner-name {
                color: #999;
                font-style: italic;
            }

            /* ===== STATUS BADGES ===== */
            .status-available {
                color: #27ae60;
                font-weight: 600;
            }

            /* ===== EMPTY STATE ===== */
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #999;
                grid-column: 1 / -1;
            }
            .empty-state .empty-icon {
                font-size: 64px;
                margin-bottom: 16px;
            }
            .empty-state p {
                font-size: 16px;
            }

            /* ===== FOOTER ===== */
            .footer {
                text-align: center;
                padding: 30px;
                color: #999;
                font-size: 13px;
                margin-top: 40px;
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
                        <span>Xin chào, <strong><%= user.getFullName() %></strong></span>
                    </div>
                    <a href="profile.jsp">Hồ sơ</a>
                    <a href="logout" class="btn-logout">Đăng xuất</a>
                <% } else { %>
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="register.jsp">Đăng ký</a>
                <% } %>
            </div>
        </nav>

        <!-- HERO -->
        <div class="hero">
            <h1>🎪 Chia sẻ đồ chơi cùng bé</h1>
            <p>Tìm kiếm và mượn đồ chơi từ cộng đồng - Vui chơi không giới hạn!</p>
        </div>

        <!-- SEARCH & FILTER -->
        <div class="filter-bar">
            <form action="home" method="GET" class="search-box">
                <input type="text" name="search" placeholder="🔍 Tìm kiếm đồ chơi..." 
                       value="${requestScope.SEARCH_KEY != null ? requestScope.SEARCH_KEY : ''}">
                <button type="submit">Tìm kiếm</button>
            </form>
            <div class="category-filter">
                <form action="home" method="GET" id="categoryForm">
                    <select name="categoryID" onchange="document.getElementById('categoryForm').submit();">
                        <option value="">📂 Tất cả danh mục</option>
                        <c:forEach var="cat" items="${requestScope.CATEGORY_LIST}">
                            <option value="${cat.categoryID}" 
                                    ${requestScope.SELECTED_CATEGORY == cat.categoryID ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </form>
            </div>
        </div>

        <!-- TOY CARDS -->
        <div class="toy-grid">
            <c:choose>
                <c:when test="${empty requestScope.TOY_LIST}">
                    <div class="empty-state">
                        <div class="empty-icon">🔍</div>
                        <p>Không tìm thấy đồ chơi nào. Hãy thử tìm kiếm khác!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="toy" items="${requestScope.TOY_LIST}">
                        <a href="detail?toyID=${toy.toyID}" class="toy-card">
                            <div class="card-image">
                                <c:choose>
                                    <c:when test="${not empty toy.imageURL}">
                                        <img src="assets/images/${toy.imageURL}" 
                                             alt="${toy.toyName}"
                                             onerror="this.parentElement.innerHTML='<div class=no-image>🧸</div>'">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image">🧸</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="card-body">
                                <div class="card-category">${toy.categoryName}</div>
                                <h3>${toy.toyName}</h3>
                                <div class="card-desc">${toy.description}</div>
                            </div>
                            <div class="card-footer">
                                <span class="condition-badge">📦 ${toy.condition}</span>
                                <span class="owner-name">👤 ${toy.ownerName}</span>
                            </div>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2026 Toy Sharing Platform - FPT University | Chia sẻ niềm vui cùng bé yêu 🧡</p>
        </div>
    </body>
</html>
