<%@page import="pack.product.ProductDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrderMgr"></jsp:useBean>
<jsp:useBean id="odto" class="pack.orders.OrdersDto"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.product.ProductDto"></jsp:useBean>
<%

String id = (String)session.getAttribute("idKey");
if (id == null) {
	response.sendRedirect("login.jsp");
}
String stateabout = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/order.js"></script>
</head>
<body>
<input type="button" id="#orderBtn" value="ORDER">
<input type="button" id="#reviewBtn" value="REVIEW">
<input type="button" id="#qnaBtn" value="Q&A">
<table border="1">
	<tr>
		<th>주문번호</th>
		<th>이미지</th>
		<th>주문내역</th>
		<th>주문상태</th>
		<th>취소/환불/반품</th>
	</tr>
	<%
	ArrayList<OrdersDto> olist = orderMgr.getOrderData(id);
	for (int i = 0; i < olist.size(); i++) {
		odto = olist.get(i);
		pdto = orderMgr.getOPinfo(odto.getNum());
		%>
		<tr>
			<td><%= odto.getNum() %></td>
			<td><%= pdto.getPic() %></td>
			<td><a href="javascript:orderinfo('<%= odto.getNum() %>', '<%= odto.getState() %>')"><%= pdto.getName() %> 
			<% 
			int count = orderMgr.countprocess(odto.getNum());
			if (count > 1) {
				out.print("외 " + (count - 1) + "건");
			}
			%>
			</a></td>
			<td><%= odto.getState() %></td>
			<%
			if (odto.getState().equals("결제완료") || odto.getState().equals("배송준비중")) {
				stateabout = "<a href=\"javascript:orderDelete('" + odto.getNum() + "','" + pdto.getName() + "')\">취소</a>";
			} else if (odto.getState().equals("배송중")) {			
				stateabout = "<a href=\"javascript:orderRefund('" + odto.getNum() + "','" + pdto.getName() + "')\">환불</a>";
			} else if (odto.getState().equals("배송완료")) {
				stateabout = "<a href=\"javascript:orderReturn('" + odto.getNum() + "','" + pdto.getName() + "')\">반품</a>";
			}
			%>
			<td><%= stateabout %></td>
		</tr>
		<%
		}
	%>
</table>
<form action="orderinfodetail.jsp" method="post" name="orderFrm">
	<input type="hidden" name="orders_num">
	<input type="hidden" name="orders_state">
</form>
<form action="orderproc.jsp" method="post" name="orderflagFrm">
	<input type="hidden" name="flag">
	<input type="hidden" name="orders_num">
	<input type="hidden" name="product_name">
</form>

</body>
</html>