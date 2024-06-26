<%@page import="pack.user.UserBean"%>
<%@page import="pack.user.UserMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");

UserBean bean = userMgr.getUser(id); 

if(bean == null){
	response.sendRedirect("loginForm.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="../js/script.js"></script>
<!-- Daum PostcodeAddress API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
}

#userId {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
}

.user_info {
    margin: 10px auto;
    width: 300px;
}

.user_info label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.user_info input {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

.user_info .error_message {
    color: red;
    font-size: 12px;
    height: 15px; /* Ensure space is allocated even if there's no message */
}

#button {
    text-align: center;
    margin-top: 20px;
}

#button button {
    padding: 10px 20px;
    margin: 5px;
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

textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    resize: none;
}

.flex-row {
    flex-direction: row;
    align-items: center;
}

.flex-row input {
    flex: 1;
    margin-right: 10px;
}
</style>

<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnUpdateCancel").onclick=userUpdateCancel;
	document.getElementById("btnDelete").onclick=userDelete;
}
</script>

</head>
<body>
<jsp:include page="header_user.jsp" />
<form action="userInfoProc.jsp" name="updateForm" id="updateForm" method="post">

<div id="userId">@<%=bean.getId() %></div>

<div class="user_info">
    <label>Password</label> 
    <input type="password" name="pwd" value="<%=bean.getPwd() %>">
    <div class="error_message" id="user_pwd_check"></div>
</div>

<div class="user_info">
    <label>Check</label> 
    <input type="password" name="pwd_chk" value="<%=bean.getPwd() %>">
    <div class="error_message" id="pwd_chk_check"></div>
</div>

<div class="user_info">
    <label>Name</label> 
    <input type="text" name="name" value="<%=bean.getName() %>">
</div>

<div class="user_info">
    <label>Email</label> 
    <input type="text" name="email" value="<%=bean.getEmail() %>">
</div>

<div class="user_info">
    <label>Phone</label> 
    <input type="text" name="tel" value="<%=bean.getTel() %>">
</div>

<div class="user_info flex-row">
    <label>Postcode</label> 
    <input type="text" value="<%=bean.getZipcode() %>" maxlength="6" name="zipcode" id="zipcode_display" disabled="disabled">
    <button type="button" id="btnAddr" onclick="daum_AddressAPI()">Search</button>
</div>
		
<input type="hidden" id="user_zipcode" name="zipcode" value="">

<div class="user_info">
    <label>Address</label> 
    <input type="text" name="current_addr" id="current_addr" value="<%=bean.getAddress() %>" disabled="disabled">
</div>
<div class="user_info">
    <label></label>
    <input type="text" name="addr_start" id="addr_start" placeholder="도로명/지번 주소" disabled="disabled">
</div>
<div class="user_info">
    <label></label>
    <input type="text" name="addr_end" id="addr_end" placeholder="상세 주소">
</div>
<div class="error_message" id="user_addr_check"></div>
<input type="hidden" id="full_addr" name="address" value="">

<div class="user_info" id="button">
  <button type="button" id="btnUpdate" class="btn btn-primary">
    수정완료
  </button>
  
  <button type="button" id="btnUpdateCancel" class="btn btn-primary">
    수정취소
  </button>
  
  <button type="button" id="btnDelete" class="btn btn-primary">
    회원탈퇴
  </button>
</div>
</form>
</body>
</html>