<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="userBean" class="pack.user.UserBean" scope="page" />
<jsp:setProperty property="*" name="userBean" />
<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
String id = (String)session.getAttribute("idKey");
boolean b = userMgr.userUpdate(userBean, id);

if(b){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
	<body>
	<jsp:include page="header_user.jsp" />
	
  <script>
 alert("정보 수정이 완료되었습니다.");
 location.href = "userInfoSuccess.jsp";
  </script>
	</body>
</html>
<%}else{%>
	<script>
	alert("수정 실패\n관리자에게 문의 바람");
	history.back();
	</script>
<%	
}
%>