<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrderMgr"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.product.ProductDto"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
/* 
1. 로그인 세션 확인 작업
*/

String id = (String)session.getAttribute("idKey");
if (id == null) {
	id = "user1";
}

int orders_num = Integer.parseInt(request.getParameter("orders_num"));
String orders_state = request.getParameter("orders_state");
if (orders_num == 0) {
	orders_num = 1;
}
if (orders_state == null) {
	orders_state = "배송완료";
}

ArrayList<ProductDto> plist = orderMgr.getOPInfoDetail(orders_num);
OrdersDto odto = orderMgr.getOrderDataDetail(orders_num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/order.js"></script>
</head>
<body>
<table border="1">
	<tr>
		<th colspan="2">상품 정보</th>
		<th>주문수량</th>
		<th>가격</th>
		<th>소계</th>
		<th>리뷰 작성</th>
	</tr>
	<%
	for (int i = 0; i < plist.size(); i++) {
		pdto = plist.get(i);
		int count = orderMgr.countprocessDetail(orders_num, pdto.getName());
		String reviewabout = "";
		
		if (orders_state.equals("배송완료")) {
			if (orderMgr.getReivewOk(pdto.getName(), id)) {
				reviewabout = "<a href=\"javascript:newReview('" + pdto.getName() + "')\">리뷰 작성 완료</a>";
			} else {
				reviewabout = "<a href=\"javascript:newReview('" + pdto.getName() + "')\">리뷰 작성하기</a>";
			}
		}
		
		%>
		<tr>
			<td><%= pdto.getPic() %></td>
			<td><%= pdto.getName() %></td>
			<td><%= count %></td>
			<td><%= pdto.getPrice() %></td>
			<td><%= count * pdto.getPrice() %></td>
			<td><%= reviewabout %></td>
		</tr>
		<%
	}
	%>
</table>
<form action="review.jsp" name="detailFrm" method="post">
	<input type="hidden" name="product_name">
</form>
</body>
</html>