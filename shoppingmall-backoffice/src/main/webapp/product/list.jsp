<%@ page import="product.ProductService" %>
<%@ page import="product.ProductDto" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.ac.dy.cs.util.SessionUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

  // 상품 서비스 연동
  ProductService service = new ProductService();
  List<ProductDto> products = service.getAllProducts();
  int totalCount = products != null ? products.size() : 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 관리 - SHOPMALL ADMIN</title>
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
      <h1>상품 관리</h1>
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

  <section class="dash-panel">

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
      <h3 style="margin: 0;">상품 목록 <span style="font-size: 13px; color: #6b7280; font-weight: normal; margin-left: 8px;">총 <%= totalCount %>종</span></h3>
      <a href="register.jsp" class="btn-primary" style="text-decoration: none; padding: 8px 16px; font-size: 13px; border-radius: 6px; display: inline-flex; align-items: center;">
        ➕ 새 상품 등록
      </a>
    </div>

    <div class="table-wrap">
      <table class="dash-table">
        <thead>
        <tr>
          <th style="width: 80px;">No.</th> <th>상품 ID</th>
          <th>상품명</th>
          <th>판매 가격</th>
          <th>현재 재고</th>
          <th>최초 등록일</th>
          <th>판매 상태</th>
          <th style="text-align: center;">관리 권한</th>
        </tr>
        </thead>

        <tbody>
        <% if (totalCount == 0) { %>
        <tr>
          <td colspan="8" style="text-align:center; padding: 32px; color:#9ca3af;">
            등록된 상품이 없습니다. 새 상품을 등록해 주세요.
          </td>
        </tr>
        <% } else { %>
        <%
          int no = 1; // ✨ [A 방법] 화면 정렬용 연번 변수 선언 (1부터 시작)

          for (ProductDto p : products) {
            String statusStr;
            String badgeClass;

            if (p.getStockQty() == 0) {
              statusStr = "품절";
              badgeClass = "danger";
            } else if (p.getStockQty() <= 5) {
              statusStr = "재고 부족";
              badgeClass = "warn";
            } else {
              statusStr = "판매중";
              badgeClass = "active";
            }
        %>
        <tr>
          <td style="font-weight: bold; color: #4b5563;"><%= no++ %></td>

          <td><code>#<%= p.getProductId() %></code></td>

          <td><strong><%= p.getProductName() %></strong></td>
          <td>₩<%= String.format("%,d", p.getPrice()) %></td>
          <td><%= p.getStockQty() %> 개</td>
          <td style="color: #6b7280;"><%= p.getRegDt() %></td>
          <td>
            <span class="status-badge <%= badgeClass %>"><%= statusStr %></span>
          </td>
          <td style="text-align: center;">
            <a href="deleteSubmit.jsp?productId=<%= p.getProductId() %>"
               onclick="return confirm('정말 이 상품을 영구 삭제하시겠습니까?');">
              <button type="button" class="btn-action-delete" style="padding: 4px 10px; cursor: pointer;">삭제</button>
            </a>
          </td>
        </tr>
        <% } %>
        <% } %>
        </tbody>
      </table>
    </div>

  </section>

</main>

</body>
</html>