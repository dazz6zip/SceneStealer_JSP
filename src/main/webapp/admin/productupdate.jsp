<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<%
request.setCharacterEncoding("utf-8");
ProductDto dto = productMgr.getProduct(request.getParameter("name"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/productedit.js"></script> 

</head>
<body>
<%@ include file="admin_top.jsp" %>
<form action="productproc.jsp?flag=update" name="ppfrm" method="post" enctype="multipart/form-data">
<table>
<tr>
		<td colspan="2">**상품 등록**</td>
		
	</tr>
	<tr>
		<td>상품명</td>
		<td><%=dto.getName()%></td>
	
	</tr>
	<tr>
		<td>가 격</td>
		<td><input type="text" name="price"  value="<%=dto.getPrice()%>"></td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
			<select name="category">
				<option value="상의">상의</option>
				<option value="하의">하의</option>
				<option value="신발">신발</option>
				<option value="잡화">잡화</option>
			</select>
			<script type="text/javascript">
			document.ppfrm.category.value = "<%=dto.getCategory() %>";
			</script>
		</td>
	</tr>
	<tr>
		<td>상품설명</td>
		<td><textarea rows="5" style="width: 99%" name="contents"><%=dto.getContents() %></textarea></td>
	</tr>
	<tr>
		<td>재고량</td>
		<td><input type="text" name="stock" value="<%=dto.getStock()%>"></td>
		
	</tr>
	<tr>
		<td>이미지</td>
		<td>
			<img src="../upload/<%=dto.getPic()%>">
			<input type="file" name="pic" size="30">
		</td>
	</tr>
	
	<tr>
		<td colspan="2">
			<br>
				<input type="hidden" name="name"  value="<%=dto.getName()%>">
			<input type="submit" value="상품 수정">
			<input type="reset" value="수정 취소" onclick="history.back()">
			
		</td>
	<tr>
</table>
</form>


</body>
</html>