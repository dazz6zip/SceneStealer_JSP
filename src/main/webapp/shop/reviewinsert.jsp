<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
    <%
    String id = (String)session.getAttribute("idKey");
    if (id == null) {
    	id = "user1";
    }
    String pname = request.getParameter("pro");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form name="productForm" action="reviewproc.jsp?flag=insert" method="post"  enctype="multipart/form-data">

<table>

<tr>
		<td colspan="2">**리뷰 등록**</td>
		
	</tr>
	<tr>
		<td></td>
		<td><input type="hidden" name="num" value="<%= reviewMgr.newNum() %>"></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="user" value="<%= id %>"></td>
	</tr>
	<tr>
		<td>리뷰</td>
		<td><textarea rows="5" style="width: 99%" name="contents"></textarea></td>
	</tr>
		<tr>	
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
<input type="hidden" name="product" value="<%= pname %>">
</form>

</body>
</html>