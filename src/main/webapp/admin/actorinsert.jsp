<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<%
String name = request.getParameter("name"); // 배우 이름
int num = actorMgr.newNum();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>배우 추가하기</h2>
<form action="actorproc.jsp" method="post">
	<input type="hidden" name="num" value="<%=num %>"> <!-- 새로운 시리즈의 PK값 계산해서 가져가기 -->
	배우이름 <input type="text" name="name" value="<%=name %>" readonly><br>
	생년월일 <input type="date" name="birth"><br><br>
	<input type="submit" value="배우 등록 및 선택하기">
</form>
</body>
</html>