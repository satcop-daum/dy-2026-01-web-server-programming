<%@ page import="product.ProductService" %>
<%@ page import="product.ProductDto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String productName = request.getParameter("productName");
  int price = Integer.parseInt(request.getParameter("price"));
  int stockQty = Integer.parseInt(request.getParameter("stockQty"));

  ProductDto dto = new ProductDto();
  dto.setProductName(productName);
  dto.setPrice(price);
  dto.setStockQty(stockQty);

  ProductService service = new ProductService();
  boolean result = service.addProduct(dto);

  if (result) {
    response.sendRedirect("list.jsp");
  } else {
    out.println("<h3>상품 등록 실패!</h3>");
    out.println("<a href='register.jsp'>다시 시도</a>");
  }
%>