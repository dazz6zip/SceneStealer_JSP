<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userid = (String)session.getAttribute("idKey");

String log = "";

if(userid == null)
	log = "<a href='loginForm.jsp'>로그인</a>";
else 
	log = "<a href='logout.jsp'>로그아웃</a>";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#check_box {
  display: none;
}

#check_box + label {
  position: relative;
  display: block;
  width: 60px;
  height: 40px;
  cursor: pointer;
}

#check_box + label > span {
  position: absolute;
  display: block;
  width: 100%;
  height: 5px;
  background: black;
  border-radius: 5px;
  transition: all 300ms;
}

#check_box:checked + label > span:nth-child(1) {
  top: 50%;
  transform: translate(0, -50%);
  transform: rotate(45deg);
}

#check_box + label > span:nth-child(2) {
  top: 50%;
  transform: translate(0, -50%);
}

#check_box:checked + label > span:nth-child(2) {
  opacity: 0;
}

#check_box + label > span:nth-child(3) {
  bottom: 0;
}

#check_box:checked + label > span:nth-child(3) {
  top: 50%;
  transform: translate(0, -50%);
  transform: rotate(-45deg);
}

#check_box + label {
  position: relative;
  display: block;
  width: 60px;
  height: 40px;
  cursor: pointer;
  /* z-index 추가 */
  z-index: 2;
}

#side_menu {
  position: fixed;
  width: 300px;
  height: 100%;
  background-color: tomato;
  left: -300px;
  transition: all 300ms;
  z-index: 1;
  top: 0px;
  padding: 60px 20px 20px 20px;
  box-sizing: border-box;
}

#check_box:checked + label + #side_menu {
  left: 0;
}
</style>
<title>SceneStealer</title>
</head>
<body>
   <input type="checkbox" id="check_box" />
    <label for="check_box">
      <span></span>
      <span></span>
      <span></span>
    </label>
    <div id="side_menu">
      <ul>
        <li><a href="loginForm.jsp"><%=log %></a></li>
        <li><a href="userInfoForm.jsp">회원정보</a></li>
      </ul>
    </div>

</body>
</html>