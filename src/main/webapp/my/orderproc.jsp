<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrderMgr"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.orders.Order_productDto"></jsp:useBean>
<%
String flag = request.getParameter("flag");
String num = request.getParameter("orders_num");
String name = request.getParameter("product_name");
boolean b1, b2;
if (flag.equals("delete")) {
	if (orderMgr.delOrder(num) && orderMgr.delOrderStock(num)) {
		%>
		<script type="text/javascript">
			alert("취소가 완료되었습니다.");
			location.href = "orderinfo.jsp";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("취소 실패");
			location.href = "orderinfo.jsp";
		</script>
		<%
	}
} else if (flag.equals("refund") || flag.equals("return")) {
	%>
		<script type="text/javascript">
			alert("Q&A 페이지로 이동합니다.");
			location.href = "questionlist.jsp";
		</script>
	<%
} 
%>
