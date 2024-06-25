<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="userBean" class="pack.user.UserBean" scope="page" />
<jsp:setProperty property="*" name="userBean" />
<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
boolean b = userMgr.userInsert(userBean);

if (b) {
    response.sendRedirect("registerSuccess.jsp");
} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
  <script>
    alert("회원가입 실패");
    history.back();
  </script>
</body>
</html>
<%	
}
%>