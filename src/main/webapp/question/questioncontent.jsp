<%@page import="pack.question.QuestionMgr_u"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />    
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />   
<%
String num = request.getParameter("num");
if (num == null) {
	num = "1";
}
String spage = request.getParameter("page");

qdto = qmgr.getData2(num);

String user_id = qdto.getUser();
String question_title = qdto.getTitle();
String question_pic = qdto.getPic();
String question_contents = qdto.getContents();
String question_date = qdto.getDate();
String answer_contents = qdto.getAnswer_contents();

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<style>
/* Question Detail Page Styles */
.question-page h1 {
    color: #333;
    margin-bottom: 20px;
}

.question-page table {
    width: 80%;
    margin: 20px auto;
    border-spacing: 0;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    overflow: hidden;
}

.question-page th, .question-page td {
    padding: 15px;
    text-align: center;
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

.question-page th {
    background-color: #333;
    color: white;
}

.question-page td img {
    max-width: 100%;
    height: auto;
    border-radius: 10px;
}

.question-page .links {
    text-align: center;
    margin: 20px 0;
}

.question-page .links a {
    display: inline-block;
    padding: 10px 20px;
    background-color: #000;
    color: white;
    text-decoration: none;
    border-radius: 20px;
    transition: background-color 0.3s ease;
}

.question-page .links a:hover {
    background-color: #444;
}

.question-page textarea {
    width: 99%;
    border: none;
    resize: none;
}
</style>
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body class="question-page">
<jsp:include page="../user/header_user.jsp"></jsp:include>
<table>
	<tr>
		<td colspan="2"><b><%=question_title %></b></td>
	</tr>
	<tr>
		<td>작성자 : <%=user_id %></td>
		<td><%=question_date %></td>
	</tr>
	<tr>
		<td colspan="2"><img src="../upload/<%=question_pic %>"></td>
	</tr>
	<tr>
		<td colspan="2"><%=question_contents %></td>
	</tr>
</table>
<table>
<tr><!-- 관리자댓글보이기 -->
	<td><div>관리자 : <%=answer_contents != null ? answer_contents : "댓글이 없습니다." %></div></td>
</tr>
<tr>
	<td class="links">
		<a href="edit.jsp?num=<%=num %>&page=<%=spage %>">수정하기</a>
		<a href="delete.jsp?num=<%=num %>&page=<%=spage %>">삭제하기</a>
		<a href="questionlist.jsp?page=<%=spage %>">목록가기</a>
	</td>
</tr>
</table>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>