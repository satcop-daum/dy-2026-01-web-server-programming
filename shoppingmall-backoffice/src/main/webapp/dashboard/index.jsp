<%@ page import="kr.ac.dy.cs.util.SessionUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String ctx = request.getContextPath();

    if (!SessionUtils.isLoginYn(session)) {
        response.sendRedirect(ctx + "/auth/adminLogin.jsp");
        return;
    }

    String loginId = (String) session.getAttribute("loginId");
    Date loginAt = (Date) session.getAttribute("loginAt");

    String loginAtStr = loginAt != null
            ? new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(loginAt)
            : "-";

    String nowStr = new SimpleDateFormat("yyyy년 MM월 dd일 (E) HH:mm", java.util.Locale.KOREAN)
            .format(new Date());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대시보드 - SHOPMALL ADMIN</title>

    <!-- CSS 경로 수정 -->
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>

<body class="dashboard-page">

<!-- ===== 좌측 사이드바 ===== -->
<aside class="dash-sidebar">

    <div class="dash-logo">
        <a href="<%= ctx %>/dashboard/index.jsp">SHOP<span>MALL</span></a>
        <div class="dash-logo-sub">ADMIN CONSOLE</div>
    </div>

    <nav class="dash-nav">

        <div class="nav-group">
            <div class="nav-group-title">MAIN</div>
            <a href="<%= ctx %>/dashboard/index.jsp" class="nav-item active">
                <span class="nav-icon">▦</span> 대시보드
            </a>
        </div>

        <div class="nav-group">
            <div class="nav-group-title">운영</div>
            <a href="<%= ctx %>/product/list.jsp" class="nav-item">📦 상품 관리</a>
            <a href="#" class="nav-item">🛒 주문 관리</a>
            <a href="<%= ctx %>/member/list.jsp" class="nav-item">👥 회원 관리</a>
            <a href="#" class="nav-item">🎁 프로모션</a>
        </div>

        <div class="nav-group">
            <div class="nav-group-title">분석</div>
            <a href="#" class="nav-item">📊 매출 통계</a>
            <a href="#" class="nav-item">📈 방문자 분석</a>
        </div>

        <div class="nav-group">
            <div class="nav-group-title">시스템</div>
            <a href="<%= ctx %>/adminUser/register.jsp" class="nav-item">⚙ 관리자 등록</a>
            <a href="#" class="nav-item">🔧 시스템 설정</a>
        </div>

    </nav>

    <div class="dash-sidebar-foot">
        © 2026 SHOPMALL ADMIN
    </div>

</aside>

<!-- ===== 메인 ===== -->
<main class="dash-main">

    <!-- 상단 -->
    <header class="dash-topbar">

        <div class="dash-page-title">
            <h1>대시보드</h1>
            <p><%= nowStr %></p>
        </div>

        <div class="dash-user">

            <div class="dash-user-info">
                <span><strong><%= loginId %></strong>님</span><br>
                <small>최근 로그인: <%= loginAtStr %></small>
            </div>

            <div class="dash-user-avatar">
                <%= loginId != null ? loginId.substring(0,1).toUpperCase() : "?" %>
            </div>

            <a href="<%= ctx %>/auth/adminLogout.jsp" class="dash-logout">
                로그아웃
            </a>

        </div>

    </header>

    <!-- 환영 -->
    <section class="dash-welcome">
        <h2><%= loginId %>님, 환영합니다 👋</h2>
        <p>오늘 쇼핑몰 상태를 확인하세요.</p>
    </section>

    <!-- KPI -->
    <section class="kpi-grid">

        <div class="kpi-card">
            <div>오늘 주문</div>
            <h3>128건</h3>
        </div>

        <div class="kpi-card">
            <div>매출</div>
            <h3>₩ 4,820,000</h3>
        </div>

        <div class="kpi-card">
            <div>신규 회원</div>
            <h3>37명</h3>
        </div>

        <div class="kpi-card">
            <div>재고 부족</div>
            <h3>12종</h3>
        </div>

    </section>

    <!-- 최근 주문 -->
    <section class="dash-panel">

        <h3>최근 주문</h3>

        <table class="dash-table">
            <thead>
            <tr>
                <th>주문번호</th>
                <th>주문자</th>
                <th>상품</th>
                <th>금액</th>
                <th>상태</th>
            </tr>
            </thead>

            <tbody>
            <tr>
                <td>#20260529-1284</td>
                <td>김민준</td>
                <td>니트 외 2건</td>
                <td>128,000</td>
                <td>결제완료</td>
            </tr>
            </tbody>

        </table>

    </section>

</main>

</body>
</html>