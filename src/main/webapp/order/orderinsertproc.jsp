<%@page import="pack.orders.OrdersBean"%>
<%@page import="java.util.Map"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="pmgr" class="pack.product.ProductMgr_u" scope="session" />
<jsp:useBean id="csmgr" class="pack.orders.CartSessionMgr" scope="session" />
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<jsp:useBean id="pdto" class="pack.product.ProductDto" />
<%
String id = (String)session.getAttribute("idKey");

Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 

if (hCart.isEmpty()) {
	%>
	<script>
		alert("주문 내역이 없습니다.");
		location.href = "orderlist.jsp";
	</script>	
	<%
} else {
	
	for (Map.Entry<String, Order_productDto> entry : hCart.entrySet()) {
		opdto = entry.getValue();
		pmgr.insertCart(opdto, id);
	}
	%>
	<script>
		alert("주문이 완료되었습니다.\n감사합니다.");
		location.href = "../my/orderinfo.jsp";
	</script>	
	<%
}

%>