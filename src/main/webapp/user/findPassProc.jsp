<%@page import="pack.user.UserMgr"%>
<%@page import="pack.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="userMgr" class="pack.user.UserMgr" />
<%
request.setCharacterEncoding("UTF-8");

String user_id = request.getParameter("id");     
String user_tel = request.getParameter("tel");

String pwd = userMgr.findPass(user_id, user_tel);
%>
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

h4 {
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

.container {
    text-align: center;
}

.found-success, .found-fail {
    margin: 20px 0;
}

.found-id {
    color: #ff69b4;
    font-size: 18px;
    font-weight: bold;
}

.found-login {
    margin-top: 20px;
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
    margin: 5px;
}

input[type="button"]:hover {
    background-color: #ff69b4;
}
</style>
 <jsp:include page="header_user.jsp" />
<form name="idsearch" method="post">
<%
	if (pwd != null) {
%>
	<div class = "container">
		<div class = "found-success">
			<h4>회원님의 비밀번호는 </h4>  
			<div class ="found-id"> <%=pwd%></div>
			<h4>  입니다 </h4>
	    </div>
	    <div class = "found-login">
			<input type="button" id="btnLogin" value="로그인" onClick = "location.href='loginForm.jsp'"/>
       	</div>
	</div>
<%
} else {
%>
	<div class = "container">
		<div class = "found-fail">
			<h4>  등록된 정보가 없습니다 </h4>  
	    </div>
	    <div class = "found-login">
			<input type="button" id="btnback" value="다시 찾기" onClick="history.back()"/>
 		    <input type="button" id="btnjoin" value="회원가입" onClick="location.href='registerForm.jsp'"/>
       	</div>
	</div>
<%
}
%> 
</form>