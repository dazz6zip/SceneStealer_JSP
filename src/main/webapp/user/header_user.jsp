<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("idKey");
String log = "";

if (id == null) {
	log = "<a href='../user/loginForm.jsp'>로그인</a>";
} else {
	log = "<a href='../user/logout.jsp'>로그아웃</a>";
}
%>

<table style="height: 10px;">
<tr>
<td><img src="../image/logo-01.png" width="15px"></td>
<td><a href="../main/main.jsp">HOME</a></td>
<td><a href="../shop/productlist.jsp">SHOP</a></td>
<td><a href="">cart</a></td><td><a href=""><%= log %></a></td>
</tr>
</table>
