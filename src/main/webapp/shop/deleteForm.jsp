<%@page import="pack.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
String id = (String)session.getAttribute("idKey");

UserBean bean = userMgr.getUser(id);

if(bean == null){
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnDelCancel").onclick=btnDelCancel;
	document.getElementById("btnDelete").onclick=btnDelete;
}
</script>
</head>
<body>
<form action="deleteProc.jsp" name="deleteForm" method="post">

<div id="userId">@<%=bean.getId() %></div>
<input type="hidden" id="user_id" value="<%=bean.getId() %>">

<div class="user_info" style="width : 100px; margin:auto;">
<label>Password</label> 
<input type="password" name="user_pwd">
<span></span>
<div class="error_message" id="delete_check"></div>
</div>
</form>
<div class="user_info" id="button">
  <!-- Button to Open the Modal -->

  <button type="button" id="btnDelCancel"class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    취소
  </button>
  <button type="button" id="btnDelete"class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    회원탈퇴
  </button>
</div>
</body>
</html>