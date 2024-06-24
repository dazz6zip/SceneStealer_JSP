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
<style>
/* body 스타일 */
body#notice-body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* 테이블 스타일 */
#notice-table {
    width: 100%;
    border-spacing: 20px;
    margin: 20px 0;
}

#notice-table th, #notice-table td {
    padding: 10px;
    background-color: #fff;
    border: 1px solid #ddd;
}

#notice-table td img {
    max-width: 100%;
    height: auto;
    border-radius: 10px;
}

/* 링크 스타일 */
#notice-links a {
    display: inline-block;
    padding: 10px 20px;
    margin: 20px 0;
    background-color: #000;
    color: white;
    text-decoration: none;
    border-radius: 20px;
    transition: background-color 0.3s ease;
}

#notice-links a:hover {
    background-color: #444;
}


</style>
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body id="notice-body">
<jsp:include page="../user/header_user.jsp"></jsp:include>
<table id="notice-table">
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
        <td>
            <img src="C:/HomeWork/scene_stealer/src/main/webapp/upload/<%=notice_pic %>" width="150"/>
        </td>
    </tr>
</table>
<div id="notice-links">
    <a href="questionlist.jsp">목록으로</a>
</div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>