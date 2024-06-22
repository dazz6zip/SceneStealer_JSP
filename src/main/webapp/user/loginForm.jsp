<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = (String)session.getAttribute("idKey");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<!-- ======= -->
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="../js/script.js"></script>
</head>
<body>
<jsp:include page="header_user.jsp" />
<%
if(id != null){		// 로그인 한 상태
%>
<script type="text/javascript">
	location.href="../main/main.jsp";
</script>

<%
} else {	// 로그인 안 한 상태
%>

<h1>Join In</h1>

<form action="loginProc.jsp" method="post" class="borderbox">
	
	<div class="login_input">
	<input type="text" name="id" placeholder="ID">
	</div>
	<div class="error_message" id="login_id_check"></div>
	<div class="login_input">
	<input type="password" name="pwd" placeholder="Password">
	</div>
	<div class="error_message" id="login_pwd_check"></div>
	
	<div class="login_button">
	<input type="button" class="btnRegister btn-16" value="Join In" id="btnLogin">
	<input type="button"class="btnRegister btn-16" value="Join Up" onclick="location.href='registerForm.html'">
	</div>
</form>

<%
}
%>
</body>
</html>