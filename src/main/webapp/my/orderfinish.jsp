<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	width: 100%;
	text-align: center;
}

input[type="button"] {
	padding: 10px 20px;
	margin: 10px 5px;
	border: none;
	background-color: #000;
	color: white;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

input[type="button"]:hover {
	background-color: #444;
}

</style>
</head>
<body>
<jsp:include page="../shop/header_shop.jsp"></jsp:include>
<br><br><br>
<h1>주문이 완료 되었습니다.</h1>
<br><br><br><br><br>
<input type="button" onclick="location.href='../my/orderinfo.jsp'" value="주문내역">
<br>
<input type="button" onclick="location.href='../main/main.jsp'" value="메인페이지">
</body>
</html>