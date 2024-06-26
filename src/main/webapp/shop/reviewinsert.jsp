<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
    <%
    request.setCharacterEncoding("utf-8");
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
<title>SceneStealer</title>
<style>
/* body 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* header 스타일 */
header {
    background-color: #333;
    color: #fff;
    padding: 10px 0;
    text-align: center;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-spacing: 20px;
    margin: 20px 0;
}

/* 텍스트 스타일 */
td {
    vertical-align: top;
    padding: 10px;
}

td h2 {
    margin-top: 0;
}

td p {
    margin: 10px 0;
}

/* 입력 필드 스타일 */
input[type="text"], input[type="file"], textarea {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* 버튼 스타일 */
input[type="submit"], input[type="reset"] {
    padding: 10px 20px;
    margin: 10px 5px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #444;
}
</style>
</head>
<body>
<jsp:include page="../shop/header_shop.jsp"></jsp:include>
<form name="productForm" action="reviewproc.jsp?flag=insert&product=<%= pname %>" method="post"  enctype="multipart/form-data">

<table>
	<tr>
		<td></td>
		<td><input type="hidden" name="num" value="<%= reviewMgr.newNum() %>"></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="user" value="<%= id %>" readonly="readonly"></td>
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
			<input type="submit" value="리뷰 등록">
			<input type="reset" value="새로 입력">
		</td>
	<tr>
</table>
<input type="hidden" name="product" value="<%= pname %>">
</form>

<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>