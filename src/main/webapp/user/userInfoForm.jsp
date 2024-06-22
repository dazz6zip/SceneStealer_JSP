<%@page import="pack.user.UserBean"%>
<%@page import="pack.user.UserMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<link href="css/style.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/script.js"></script>
<!-- button bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- Daum PostcodeAddress API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

<div class="user_info" style="width : 100px; margin:auto;">
<label>Password</label> 
<input type="password" name="pwd" value="<%=bean.getPwd() %>">
<div class="error_message" id="user_pwd_check"></div>
</div>


<div class="user_info" style="width : 100px; margin:auto;">
<label>Check</label> 
<input type="password" name="pwd_chk" value="<%=bean.getPwd() %>">
<span></span>
</div>
<div class="error_message" id="pwd_chk_check"></div>

<div class="user_info" style="width : 100px; margin:auto;">
<label>Name</label> 
<input type="text" name="name" value="<%=bean.getName() %>">
<span></span>
</div>

<div class="user_info" style="width : 100px; margin:auto;">
<label>Email</label> 
<input type="text" name="email" value="<%=bean.getEmail() %>">
<span></span>
</div>

<div class="user_info" style="width : 100px; margin:auto;">
<label>Phone</label> 
<input type="text" name="tel" value="<%=bean.getTel() %>">
<span></span>
</div>

<div class="user_info" style="width: 400px; margin: auto;">
    <label>Postcode</label> 
    <div style="display: flex; align-items: center;">
        <input type="text" value="<%=bean.getZipcode() %>" maxlength="6" name="zipcode" id="zipcode_display" disabled="disabled">
        <button type="button" id="btnAddr" onclick="daum_AddressAPI()">Search</button>
    </div>
    <span></span>
</div>
		
<input type="hidden" id="user_zipcode" name="zipcode" value="">

<div class="user_info" style="width : 100px; margin:auto;">
<label>Address</label> 
<input type="text" name="current_addr" id="current_addr" value="<%=bean.getAddress() %>" disabled="disabled">
<span></span>
</div>
<div class="user_info" style="width : 100px; margin:auto;">
<label></label>
<input type="text" name="addr_start" id="addr_start" placeholder="도로명/지번 주소" disabled="disabled">
<span></span>

<label></label>
<input type="text" name="addr_end" id="addr_end" placeholder="상세 주소">
<span></span>
</div>
<div class="error_message" id="user_addr_check"></div>
<input type="hidden" id="full_addr" name="address" value="">

<div class="user_info" id="button">
  <!-- Button to Open the Modal -->
  <button type="button" id="btnUpdate" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    수정완료
  </button>
  
  <!-- Button to Open the Modal -->
  <button type="button" id="btnUpdateCancel"class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    수정취소
  </button>
  <!-- Button to Open the Modal -->
  <button type="button" id="btnDelete"class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    회원탈퇴
  </button>
</div>
</form>
</body>
</html>