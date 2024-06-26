<%@page import="java.text.DecimalFormat"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Hashtable"%>
<%@page import="pack.orders.Order_productDto"%>
<%@page import="pack.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="umgr" class="pack.user.UserMgr" scope="session"/>
<jsp:useBean id="ubean" class="pack.user.UserBean" />
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<jsp:useBean id="csmgr" class="pack.orders.CartSessionMgr" scope="session" />
<jsp:useBean id="pdto" class="pack.product.ProductDto" />
<jsp:useBean id="pmgr" class="pack.product.ProductMgr_u" scope="session"/>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("#,###");
String id = (String)session.getAttribute("idKey");
UserBean bean = umgr.getUser(id); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문결제 확인</title>
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
<jsp:include page="../user/header_user.jsp" />
<div id="content">
    <table>
        <tr><th colspan="3" style="background-color: white; color: black; font-size: 160%">주문결제 확인</th></tr>
        <tr>
           <td>[주문자 정보]</td>
        </tr>
        <tr>
           <td>이름 :</td>
           <td><%=bean.getName() %></td>
        </tr>
        <tr>
           <td>이메일:</td>
           <td><%=bean.getEmail() %></td>
        </tr>
        <tr>
           <td>전화번호:</td>
           <td><%=bean.getTel() %></td>
        </tr>
        <tr>
           <td>배송지 :</td>
           <td><%=bean.getZipcode() %><br><%=bean.getAddress() %></td>
        </tr>
        <tr>
           <td>[주문 상품 확인]</td>
        </tr>
        <tr>
           <th>제품명</th>
           <th>수량</th>
           <th>가격</th>
        </tr>
        <%
        // 장바구니에 있는 제품 목록을 가져옴
        Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 
        int totalPrice = 0;

        for(Map.Entry<String, Order_productDto> entry : hCart.entrySet()) {
           opdto = entry.getValue();
           pdto = pmgr.getProduct(opdto.getName());
           int price = pdto.getPrice();
           int quantity = opdto.getQuantity();
           int subTotal = price * quantity; // 소계
           totalPrice += subTotal; // 총계   
        %>
        <form action="cartproc.jsp" method="post">
           <input type="hidden" name="flag">
           <input type="hidden" name="name" value="<%=opdto.getName() %>"
                    style="text-align: center;"> 
           <input type="hidden" name="orders" value="<%=opdto.getOrders() %>">
           
        <tr>
           <td><%=pdto.getName() %></td>
           <td>
              <input type="hidden" name="quantity" size="5" value="<%=quantity %>">
              <%=quantity %>
           </td>
           <td><%= df.format(subTotal) %>원</td>
        </tr>
        </form>
        <%
           }
        %>
        <tr>
           <td colspan="3">
           <b>총 결제 금액 : <%= df.format(totalPrice) %>원</b><br><br>
           <a id="orderButton" href="orderinsertproc.jsp">결제하기</a>
           </td>
        </tr>
    </table>
</div>
</body>
</html>