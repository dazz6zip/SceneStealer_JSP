<%@page import="pack.orders.OrdersBean"%>
<%@page import="java.util.Map"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="pmgr" class="pack.product.ProductMgr_u" scope="session" />
<jsp:useBean id="csmgr" class="pack.orders.CartSessionMgr" scope="session" />
<jsp:useBean id="cmgr" class="pack.orders.CartMgr"></jsp:useBean>
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<jsp:setProperty property="*" name="opdto"/>
<jsp:useBean id="pdto" class="pack.product.ProductDto" />
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");

Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 

if (hCart.isEmpty()) {
	%>
	<script>
		alert("상품 내역이 없습니다.");
		location.href = "../my/orderinfo.jsp";
	</script>	
	<%
} else {
	int orders_num = pmgr.insertOrder(id);
	System.out.println(orders_num);
	for (Map.Entry<String, Order_productDto> entry : hCart.entrySet()) {
		opdto = entry.getValue();
		System.out.println(orders_num);
		pmgr.insertCart(opdto, id, orders_num); 
		cmgr.reduceProduct(opdto);
	}
	
	hCart.clear();
	%>
	<script>
		location.href = "../my/orderfinish.jsp";
	</script>	
	<%
}

%>