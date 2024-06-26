<%@page import="java.text.DecimalFormat"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrderMgr"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.product.ProductDto"></jsp:useBean>
<%
DecimalFormat df = new DecimalFormat("#,###");
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
<title>주문 상세 내역</title>
<style>
/* 테이블 스타일 */
table {
    width: 100%;
    border-spacing: 10px;
    margin-bottom: 20px;
    background-color: #fff;
}

th, td {
    padding: 10px;
    background-color: #fff;
    border: none;
    text-align: center;
}

th {
    background-color: #333;
    color: white;
}

td img {
    max-width: 100px;
    height: auto;
    border-radius: 10px;
}

/* 링크 스타일 */
a {
    color: #000; /* 검정색 글씨 */
    text-decoration: none; /* 밑줄 제거 */
}

a:hover {
    font-size: 110%; /* 마우스 오버 시 글씨 크기 증가 */
}
</style>
<script type="text/javascript" src="../js/order.js"></script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<table>
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
			<td><img src="..\\upload\\product\\<%= pdto.getPic() %>"></td>
			<td><%= pdto.getName() %></td>
			<td><%= count %></td>
			<td><%= df.format(pdto.getPrice()) %>원</td>
			<td><%= df.format(count * pdto.getPrice()) %>원</td>
			<td><%= reviewabout %></td>
		</tr>
		<%
	}
	%>
</table>
<form action="../shop/reviewinsert.jsp" name="detailFrm" method="post">
	<input type="hidden" name="pro">
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>