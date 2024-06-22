<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ordersMgr" class="pack.orders.OrdersMgr"></jsp:useBean>
    
<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num");
String state = request.getParameter("state");
 
boolean b = ordersMgr.updateOrder(num, state);
if(b==true){
	if(state.equals("취소완료")){
		// 관리자가 취소 완료로 변경 시 해당 주문의 상품들의 수량을 상품재고량으로 돌려줘야 함
		ordersMgr.delOrderStock(num);
	}
%>
	<script>
	alert("수정 완료");
	history.back();
	</script>
<%	 
}
else{
%>
	<script>
	alert("수정 실패");
	history.back();
	</script>
<%	 
}
%>