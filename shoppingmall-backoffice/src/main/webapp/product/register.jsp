
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kr.ac.dy.cs.util.SessionUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
  String ctx = request.getContextPath();

  // 로그인 체크
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
  <title>상품 등록 - SHOPMALL ADMIN</title>
  <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>
<body class="dashboard-page">

<aside class="dash-sidebar">

  <div class="dash-logo">
    <a href="<%= ctx %>/dashboard/index.jsp">SHOP<span>MALL</span></a>
    <div class="dash-logo-sub">ADMIN CONSOLE</div>
  </div>

  <nav class="dash-nav">

    <div class="nav-group">
      <div class="nav-group-title">MAIN</div>
      <a href="<%= ctx %>/dashboard/index.jsp" class="nav-item">
        <span class="nav-icon">▦</span> 대시보드
      </a>
    </div>

    <div class="nav-group">
      <div class="nav-group-title">운영</div>
      <a href="<%= ctx %>/product/list.jsp" class="nav-item active"><span class="nav-icon">📦</span> 상품 관리</a>
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

<main class="dash-main">

  <header class="dash-topbar">
    <div class="dash-page-title">
      <h1>상품 등록</h1>
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
      <a href="<%= ctx %>/auth/adminLogout.jsp" class="dash-logout">로그아웃</a>
    </div>
  </header>

  <section class="dash-panel" style="max-width: 650px; margin: 0 auto; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border-radius: 8px;">

    <h3>새 상품 등록</h3>

    <div style="padding: 20px 10px;">
      <form action="registerSubmit.jsp" method="post" class="admin-form">

        <div class="form-group" style="margin-bottom: 18px;">
          <label style="display:block; font-weight:700; margin-bottom:8px; color:#4b5563; font-size:14px;">상품명</label>
          <input type="text" name="productName" placeholder="예: 아이폰 15 프로" style="width:100%; padding: 12px; border: 1px solid #d1d5db; border-radius:6px; background:#f9fafb;" required>
        </div>

        <div class="form-group" style="margin-bottom: 18px;">
          <label style="display:block; font-weight:700; margin-bottom:8px; color:#4b5563; font-size:14px;">판매 가격 (원)</label>
          <input type="number" name="price" placeholder="예: 1250000" min="0" style="width:100%; padding: 12px; border: 1px solid #d1d5db; border-radius:6px; background:#f9fafb;" required>
        </div>

        <div class="form-group" style="margin-bottom: 28px;">
          <label style="display:block; font-weight:700; margin-bottom:8px; color:#4b5563; font-size:14px;">초기 재고 수량 (개)</label>
          <input type="number" name="stockQty" placeholder="예: 50" min="0" style="width:100%; padding: 12px; border: 1px solid #d1d5db; border-radius:6px; background:#f9fafb;" required>
        </div>

        <div class="form-actions-row" style="display: flex; gap: 10px;">
          <button type="submit" class="btn-primary" style="padding: 12px 24px; border-radius: 6px; font-weight:700; cursor:pointer;">상품 등록 완료</button>
          <a href="list.jsp" class="btn-secondary" style="padding: 12px 24px; border-radius: 6px; text-align: center; text-decoration:none; font-weight:700; background:#e5e7eb; color:#4b5563; display:inline-block;">취소</a>
        </div>

      </form>
    </div>

  </section>

</main>

</body>
</html>