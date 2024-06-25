<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<style>
body {
    font-family: 'Lato', sans-serif;
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

h1 {
    color: #333;
    text-align: center;
    margin-bottom: 20px;
    font-family: 'Bebas Neue', cursive;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
}

.login_input {
    width: 95%;
    padding: 10px;
    margin-bottom: 10px;
}

.error_message { 
    color: red;
    font-size: 12px;
    margin-bottom: 10px;
}

input[type="text"], input[type="password"] {
    width: 95%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

.login_button {
    display: flex;
    justify-content: space-between;
}

input[type="button"] {
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

input[type="button"]:hover {
    background-color: #ff69b4;
}

a {
    display: block;
    text-align: center;
    margin-top: 10px;
    color: #333;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}
</style>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="../js/script.js"></script>
</head>
<body>
<div class="header">
    <jsp:include page="header_user.jsp" />
</div>
<div class="main-content">
<%
if(id != null){		// 로그인 한 상태
%>
<script type="text/javascript">
	history.back();
</script>
<%
} else {	// 로그인 안 한 상태
%>
<form action="loginProc.jsp" method="post" class="borderbox">
	<div class="login_input">
		USER ID<input type="text" name="id">
	</div>
	<div class="error_message" id="login_id_check"></div>
	<div class="login_input">
		PASSWORD<input type="password" name="pwd" placeholder="Password">
	</div>
	<div class="error_message" id="login_pwd_check"></div>
	<div class="login_button">
		<input type="button" class="btnRegister btn-16" value="Join In" id="btnLogin">
		<input type="button" class="btnRegister btn-16" value="Join Up" onclick="location.href='registerForm.jsp'">
	</div>
</form>
<br>
<a href='findPassForm.jsp'>비밀번호 찾기</a>
<%
}
%>
</div>
</body>
</html>