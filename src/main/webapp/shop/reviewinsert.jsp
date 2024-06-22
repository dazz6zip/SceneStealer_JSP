<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String id = (String)session.getAttribute("idKey");
    if (id == null) {
    	id = "user1";
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header_shop.jsp" />
<form name="productForm" action="reviewproc.jsp?flag=insert" method="post"  enctype="multipart/form-data">

<table>

<tr>
		<td colspan="2">**리뷰 등록**</td>
		
	</tr>
	
	<tr>
		<td>아이디</td>
		<td><%=id %></td>
	</tr>
	<tr>
		<td>리뷰</td>
		<td><textarea rows="5" style="width: 99%" name="contents"></textarea></td>
	</tr>
	
	
	
		<tr>
		<td>
		<select id="kk" onchange="ChangeValue()">
			<option>카테고리</option>
			<option value="1">상의</option>
			<option value="2">하의</option>
			<option value="3">신발</option>
			<option value="4">기타</option>
		</select>
		</td>
	
		<td>이미지</td>
		<td><input type="file" name="pic" size="30"></td>
	</tr>
	<tr>
		<td colspan="2">
			<br>
			<input type="submit" value="상품 등록">
			<input type="reset" value="새로 입력">
		</td>
	<tr>
</table>
</form>

</body>
</html>