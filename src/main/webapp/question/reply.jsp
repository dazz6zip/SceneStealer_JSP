<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />

<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
qdto = qmgr.getReplyData(num); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자가 댓글달기</title>
</head>
<body>

</body>
</html>