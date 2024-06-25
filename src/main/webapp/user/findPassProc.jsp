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