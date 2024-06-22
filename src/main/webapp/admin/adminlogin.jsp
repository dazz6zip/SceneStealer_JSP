<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<h2>Scene Stealer 관리자 로그인하기</h2>
<form action="adminloginproc.jsp" name="adminLoginform" method="post">
<table>
  <tr>
  	<td>관리자 id : </td>
  	<td><input type="text" name="adminid"></td>
  </tr>
  <tr>
  	<td>password : </td>
  	<td><input type="password" name="adminpasswd"></td>
  </tr>
  <tr>
  	<td colspan="2">
  		<input type="submit" value="관리자 로그인">
  	</td>
  </tr>
</table>	
</form>
<br><br>
<a href="../main/main.jsp">User's Main Page</a>
</body>
</html>





