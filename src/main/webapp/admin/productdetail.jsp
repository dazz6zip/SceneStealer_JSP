<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
    <%
    String str = request.getParameter("str"); 
    ProductDto dto = productMgr.getProduct(str);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리</title>

<script type="text/javascript" src="../js/productedit.js"></script>
</head>
<body>
**상품 상세 보기**<p/>

<%@ include file="admin_top.jsp" %>
<table>
	<tr>
		<td style="width: 20%">
			<img src="../upload/product/<%=dto.getPic()%>" width="150" />
		</td>
		<td style="vertical-align: top;">
			<table style="width: 100%">
				<tr>
					<td>상품명 :</td>
					<td><%=dto.getName() %></td>
				</tr>
				<tr>
					<td>가격 :</td>
					<td><%=dto.getPrice() %></td>
				</tr>
				<tr>
					<td>카테고리 :</td>
					<td><%=dto.getCategory() %></td>
				</tr>
				<tr>
					<td>상품설명 :</td>
					<td><%=dto.getContents() %></td>
				</tr>
				<tr>
					<td>재고량 :</td>
					<td><%=dto.getStock() %></td>
				</tr>
				<tr>
					<td>등록일 :</td>
					<td><%=dto.getDate() %></td>
				</tr>
				
			</table>
		</td>
		<td style="width: 30%">
		<br>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center;">
		 <form action="productstockupdate.jsp" method="post">
			<a href="javascript:productUpdate('<%=dto.getName() %>')">수정 하기</a>&nbsp;&nbsp;
                <input type="hidden" name="productName" value="<%=dto.getName() %>">
                <input type="submit" value="Sold Out">
			 </form>
		</td>
	</tr>
</table>

<form action="productupdate.jsp" name="updateForm" method="post">
<input type="hidden" name="name">
</form>

<form action="productproc.jsp?flag=delete" name="delForm" method="post">
<input type="hidden" name="name">
</form>

<a href="productlist.jsp">상품 목록으로</a>

</body>
</html>