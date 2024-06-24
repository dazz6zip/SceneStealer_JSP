<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="itemMgr" class="pack.main.ItemMgr" />
<%
request.setCharacterEncoding("utf-8");
String num = request.getParameter("num");
String msg = (itemMgr.insertItem(request)) ? "아이템 추가 완료" : "아이템 추가 실패";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><%=msg %></h3><br>
메인 Style Stealer 작업이 모두 완료되었습니다.
</body>
</html>