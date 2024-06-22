<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String adminId = (String)session.getAttribute("adminOk");
if(adminId == null){
	response.sendRedirect("adminlogin.jsp");
}
%>
<h1>🔒Scene Stealer 관리자🔒</h1>
<table style="width: 90%;">
	<tr style="background-color: lavender; text-align: center; ">
		<td><a href="../main/main.jsp">User's</a></td>
		<td><a href="mainedit.jsp">Main Edit</a></td>
		<td><a href="productlist.jsp">Product</a></td>
		<td><a href="orderlist.jsp">Order</a></td>
		<td><a href="noticelist.jsp">Notice</a></td>
		<td><a href="questionlist.jsp">Q & A</a></td>
		<td><a href="adminlogout.jsp">Log Out</a></td>
	</tr>
</table> 