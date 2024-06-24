<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/script.js"></script>
</head>
<body>
<form name="pwfindscreen" method ="POST" action="findPassProc.jsp">
	<div class = "search-title">
		<h3>등록한 정보로 인증</h3>
	</div>
	<section class = "form-search">
	
	<div class = "find-id">
		<label>아이디</label>
		<input type="text" name="id" class = "btn-name" placeholder = "ID">
	</div>
	
	<div class = "find-phone">
		<label>전화번호</label>
		<input type="text" name="tel" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
	</div>
	</section>
	<br>
	<div class = "btnSearch">
		<input type="submit" name="enter" value="찾기">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
	</div>
</form>
</body>
</html>