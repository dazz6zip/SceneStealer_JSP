<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="noticeMgr" class="pack.notice.NoticeMgr"></jsp:useBean>
<%
int num = noticeMgr.newNum();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 등록</title>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<form action="noticeproc.jsp?flag=insert" method="post" enctype="multipart/form-data">
<table>
<tr>
	<td>제목</td>
	<td><input type="text" name="title"></td>
</tr>
<tr>
	<td>이미지</td>
	<td><input type="file" name="pic"></td>
</tr>
<tr>
	<td>내용</td>
	<td><textarea rows="5" style="width:99%" name="contents"></textarea></td>
</tr>
<tr>
   <td colspan="2">
   <br>
   <input type="hidden" name="num" value="<%=num %>">
   <input type="submit" value="공지 등록">
   <input type="reset" value="새로 입력">
   </td>
</tr>
</table>
</form>
</body>
</html>