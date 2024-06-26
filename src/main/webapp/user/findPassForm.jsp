<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.header {
    width: 100%;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.main-content {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin-top: 60px; /* Adjust according to the height of the header */
    flex-direction: column;
}

h3 {
    color: #333;
    text-align: center;
    margin-bottom: 20px;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    margin: 20px auto;
}

.search-title {
    text-align: center;
}

.form-search {
    margin: 20px 0;
}

.find-id, .find-phone {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    color: #333;
}

input[type="text"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

.btnSearch {
    display: flex;
    justify-content: space-between;
}

input[type="submit"], input[type="button"] {
    width: 48%;
    padding: 10px;
    border: none;
    background-color: #333;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-align: center;
}

input[type="submit"]:hover, input[type="button"]:hover {
    background-color: #ff69b4;
}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/script.js"></script>
</head>
<body>
  <jsp:include page="header_user.jsp" />
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