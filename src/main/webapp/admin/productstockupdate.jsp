<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<%
request.setCharacterEncoding("utf-8");
    String productName = request.getParameter("productName");
    boolean updated = productMgr.updateStockToZero(productName); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 업데이트 결과</title>
</head>
<body>
<% if (updated) { %>
    <h1>상품 "<%=productName %>" 의 재고가 Sold Out 처리되었습니다.</h1>
<% } else { %>
    <h1>재고 업데이트 중 오류가 발생했습니다.</h1>
<% } %>

<a href="productlist.jsp?str=<%=productName %>">상품 상세 페이지로 돌아가기</a>

</body>
</html>
