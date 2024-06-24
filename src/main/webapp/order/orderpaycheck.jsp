<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.List"%>
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
String id = (String)session.getAttribute("idKey");
UserBean bean = umgr.getUser(id); 

// 장바구니에 있는 제품 목록을 가져옴
//Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 
//int totalPrice = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문결제 확인</title>
</head>
<body>
주문결제 확인 

<table>
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
   <td>제품명</td>
   <td>수량</td>
   <td>가격</td>
</tr>
<%
//장바구니에 있는 제품 목록을 가져옴
Hashtable<String, Order_productDto> hCart = (Hashtable<String, Order_productDto>)csmgr.getCartList(); 
int totalPrice = 0;

for(Map.Entry<String, Order_productDto> entry : hCart.entrySet()){ {
   opdto = entry.getValue();
   pdto = pmgr.getProduct(opdto.getName());
//   System.out.println(pdto.getName());
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
      <input type="text" name="quantity" size="5" value="<%=quantity %>">
   </td>
   
   <td><%=totalPrice %>원</td>
</tr>
</form>
<%
   }
}
%>

<tr>
   <td>
   <a href="orderinsertproc.jsp">결제하기</a>
   </td>
</tr>
</table>

</body>
</html>