<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Map"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
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
<style>

#content {
    display: flex;
    flex-direction: column;
    align-items: center;
    box-sizing: border-box;
    width: 100%;
    max-width: 1200px;
    margin: auto;
}

table {
    width: 100%;
    border-spacing: 10px;
    margin-bottom: 20px;
    background-color: #fff;
}

th, td {
    padding: 10px;
    text-align: center;
    background-color: #fff;
    border: none;
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
    color: #000;
    text-decoration: none;
}

/* 수정/삭제 버튼 스타일 */
input[type="button"] {
    padding: 10px 20px;
    background-color: white;
    color: black;
    border-radius: 20px;
    border: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="button"]:hover {
    background-color: #444;
    color: white;
}

/* 주문하기 버튼 스타일 */
#orderButton {
    padding: 10px 20px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

#orderButton:hover {
    background-color: #444;
}

/* 재고 부족 메시지 스타일 */
.stockCheck {
    color: red;
}
</style>
</head>
<body>
<%@ include file="../shop/header_shop.jsp" %>
<div id="content">
    <table>
    <tr><th colspan="5" style="background-color: white; color: black; font-size: 160%">장바구니</th></tr>
        <tr style="background-color: pink;">
            <th>제품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>수정/삭제</th>
            <th>비고</th>
        </tr>
    <%
    request.setCharacterEncoding("utf-8");
    DecimalFormat df = new DecimalFormat("#,###");

    int totalPrice = 0;
    boolean b = false;
    Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 

    if(hCart.isEmpty() || hCart.size() == 0){
    %>
        <tr>
            <td colspan="5">장바구니에 담은 상품이 없습니다.</td>
        </tr>
    <%    
    }else{
        for(Map.Entry<String, Order_productDto> entry : hCart.entrySet()){
            opdto = entry.getValue();
            System.out.println("안녕 " + opdto.getName());
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
                <td><%= df.format(subTotal) %></td>
                <td><input type="number" name="quantity" size="5" value="<%=quantity %>"></td>
                <td>
                    <input type="button" value="수정" onclick="javascript:cartUpdate(this.form)">
                    <input type="button" value="삭제" onclick="javascript:cartDelete(this.form)">
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
                <b>총 결제 금액 : <%= df.format(totalPrice) %>원</b><br><br>
                <a id="orderButton" href='orderpaycheck.jsp'>주문하기</a>
            </td>
        </tr>
    <%
    }
    %>
    </table>
</div>
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