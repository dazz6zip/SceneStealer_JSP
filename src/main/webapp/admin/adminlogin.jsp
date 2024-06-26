<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

h2 {
    color: #333;
    text-align: center;
    margin-bottom: 20px;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
    width: 100%;
    border-spacing: 10px;
}

td {
    padding: 10px;
    vertical-align: middle;
}

input[type="text"], input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
}

input[type="submit"] {
    width: 100%;
    padding: 10px;
    border: none;
    background-color: #333;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #ff69b4;
}

input[type="button"] {
    width: 100%;
    padding: 10px;
    border: none;
    background-color: #333;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-align: center;
}

input[type="button"]:hover {
    background-color: #33FFFF; 
}
</style>
</head>
<body>
<form action="adminloginproc.jsp" name="adminLoginform" method="post">
<table>
  <tr>
  	<td>ADMIN ID</td>
  	<td><input type="text" name="adminid"></td>
  </tr>
  <tr>
  	<td>PASSWORD</td>
  	<td><input type="password" name="adminpasswd"></td>
  </tr>
  <tr>
  	<td colspan="2">
  		<input type="submit" value="관리자 로그인">
  	</td>
  </tr>
  <tr>
  	<td colspan="2">
		<input type="button" onclick="location.href='../main/main.jsp'" value="User's Main Page">
  	</td>
  </tr>
</table>	
</form>
</body>
</html>