<%@page import="pack.notice.NoticeDto"%>
<%@page import="pack.question.QuestionMgr_u"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />
<jsp:useBean id="ndto" class="pack.notice.NoticeDto" />

<%
String num = request.getParameter("num");

if (num == null) {
    out.println("잘못된 접근입니다.");
    return;
}

ndto = qmgr.getNotice(num);

String notice_title = ndto.getTitle();
String notice_pic = ndto.getPic();
String notice_contents = ndto.getContents();
String notice_date = ndto.getDate();


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 보기</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h1>공지사항 상세 보기</h1>
<table>
    <tr>
        <th>제목</th>
        <td><%= notice_title %></td>
    </tr>
    <tr>
        <th>작성일</th>
        <td><%= notice_date %></td>
    </tr>
    <tr>
        <th>내용</th>
        <td><%= notice_contents %></td>
    </tr>
     <tr>
        <th>사진</th>
        <td><%= notice_pic %></td>
    </tr>
</table>
<a href="questionlist.jsp">목록으로</a>
</body>
</html>
