<%@page import="pack.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
String id = (String)session.getAttribute("idKey");

UserBean bean = userMgr.getUser(id);

if(id == null){
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnDelCancel").onclick=btnDelCancel;
	document.getElementById("btnDelete").onclick=btnDelete;
}
</script>
<style>
body {
    font-family: 'Lato', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    box-sizing: border-box;
}

#userId {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
}

.user_info {
    margin-bottom: 15px;
}

.user_info label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.user_info input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

.error_message {
    color: red;
    font-size: 12px;
    height: 15px; /* Ensure space is allocated even if there's no message */
    margin-top: -10px;
    margin-bottom: 10px;
}

#button {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

#button button {
    width: 48%;
    padding: 10px;
    background-color: #333;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#button button:hover {
    background-color: #444;
}
</style>
</head>
<body>
<form action="deleteProc.jsp" name="deleteForm" method="post">

	<div id="userId">@<%=bean.getId() %></div>
	<input type="hidden" id="user_id" value="<%=bean.getId() %>">

	<div class="user_info" style="width: 100%; margin: auto;">
	<label>Password</label> 
	<input type="password" name="user_pwd">
</form>
<div class="user_info" id="button">
	<button type="button" id="btnDelCancel" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    취소
	</button>
	<button type="button" id="btnDelete" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    회원탈퇴
	</button>
</div>
	<span></span>
	<div class="error_message" id="delete_check"></div>
	</div>

</body>
</html>