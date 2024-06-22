<%@page import="pack.main.SeriesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="seriesMgr" class="pack.main.SeriesMgr"></jsp:useBean>
<%
// 작게 뜨는 창
String title = request.getParameter("title");
int num = seriesMgr.newNum(); // series 추가 시 들어갈 PK 번호 (max+1)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시리즈 추가</title>
</head>
<body>
<h2>시리즈 추가하기</h2>
<form action="seriesproc.jsp?flag=insert&num=<%=num %>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="<%=num %>"> <!-- 새로운 시리즈의 PK값 계산해서 가져가기 -->
	시리즈명 <input type="text" name="title" value="<%=title %>" readonly>
	공개일자 <input type="date" name="date">
	시리즈 대표사진 <input type="file" name="pic">
	<input type="submit" value="등록하기">
</form>
<a href="#" onclick="window.close()">닫기</a>
</body>
</html>