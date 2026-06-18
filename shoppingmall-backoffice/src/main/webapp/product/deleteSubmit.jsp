<%@ page import="product.ProductService" %>
<%@ page import="kr.ac.dy.cs.util.SessionUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String ctx = request.getContextPath();

  // 1. 보안을 위해 로그인 여부 먼저 체크
  if (!SessionUtils.isLoginYn(session)) {
    response.sendRedirect(ctx + "/auth/adminLogin.jsp");
    return;
  }

  // 2. list.jsp에서 보낸 productId 파라미터 받기
  String productIdStr = request.getParameter("productId");

  if (productIdStr != null && !productIdStr.trim().isEmpty()) {
    try {
      int productId = Integer.parseInt(productIdStr);

      // 3. 서비스 객체를 생성하여 DB에서 삭제 수행
      ProductService service = new ProductService();
      service.removeProduct(productId); // ※주의: ProductService에 해당 메서드명이 일치하는지 확인 필요

    } catch (NumberFormatException e) {
      e.printStackTrace();
    }
  }

  // 4. 삭제 완료 후 다시 상품 목록 페이지(list.jsp)로 리다이렉트 이동
  response.sendRedirect(ctx + "/product/list.jsp");
%>