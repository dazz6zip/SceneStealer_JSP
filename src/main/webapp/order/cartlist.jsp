<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Map"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="csmgr" class="pack.orders.CartSessionMgr" scope="session"/>
<jsp:useBean id="pdto" class="pack.product.ProductDto" />
<jsp:useBean id="pmgr" class="pack.product.ProductMgr_u" scope="session"/>
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<%@ include file="../shop/header_shop.jsp" %>
<table border="1">
    <tr style="background-color: pink; width: 90%">
        <th>제품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>수정/삭제</th>
        <th>비고</th>
    </tr>
<%
request.setCharacterEncoding("utf-8");
int totalPrice = 0;
boolean b = false;
Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 

if(hCart.isEmpty() || hCart.size() == 0){
%>
<tr>
    <td colspan="5">주문 건수가 없어요.</td>
</tr>
<%	
}else{
    for(Map.Entry<String, Order_productDto> entry : hCart.entrySet()){
        opdto = entry.getValue();
        pdto = pmgr.getProduct(opdto.getName());
        if (pdto != null) {
            int price = pdto.getPrice();
            int quantity = opdto.getQuantity();
            int subTotal = price * quantity;
            totalPrice += subTotal;
            
            int stock = pmgr.nowStock(opdto.getName());
            b = stock > quantity;
%>
<form action="cartproc.jsp" method="post">
    <input type="hidden" name="flag">
    <input type="hidden" name="name" value="<%=opdto.getName() %>" style="text-align: center;"> 
    <input type="hidden" name="orders" value="<%=opdto.getOrders() %>">
    <tr>
        <td><%=opdto.getName() %></td>
        <td><%=subTotal %></td>
        <td><input type="text" name="quantity" size="5" value="<%=quantity %>"></td>
        <td>
            <input style="background-color : aqua;" type="button" value="수정" onclick="javascript:cartUpdate(this.form)">
            <input style="background-color : aqua;" type="button" value="삭제" onclick="javascript:cartDelete(this.form)">
        </td>
        <td class="stockCheck">
            <% if (!b) { %> 재고 부족 <% } %>
        </td>
    </tr>
</form>
<%
        } else {
%>
<tr>
    <td colspan="5">해당 제품 정보를 불러올 수 없습니다: <%=opdto.getName()%></td>
</tr>
<%
        }
    }
%>
<tr>
    <td colspan="5">
        <br>
        <b>총 결제 금액 : <%=totalPrice %>원</b>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a id="orderButton" href='orderpaycheck.jsp'>[주문하기]</a>
    </td>
</tr>
<%
}
%>
</table>
<script>
window.onload = () => {
    const stockCheckElements = document.querySelectorAll('.stockCheck');
    let valueCheck = false;

    stockCheckElements.forEach((e) => {
        if (e.textContent.trim() !== '') {
        	valueCheck = true;
        }
    });

    if (valueCheck) {
        document.getElementById('orderButton').style.display = 'none';
    }
}
</script>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>