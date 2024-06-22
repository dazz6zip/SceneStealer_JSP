<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pack.question.QuestionMgr_u"%>
<%@page import="pack.question.QuestionDto"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />

<%
String role = (String)session.getAttribute("role");
if (!"admin".equals(role)) {
    // 관리자가 아니면 접근 금지
    out.println("<script>alert('관리자만 댓글을 달 수 있습니다.'); history.back();</script>");
    return;
}

int num = Integer.parseInt(request.getParameter("num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>댓글 작성</h2>
<form action="commentwriteprocess.jsp" method="post">
    <input type="hidden" name="num" value="<%=num%>">
    <table>
        <tr>
            <td>댓글 내용</td>
            <td><textarea name="content" rows="5" cols="40"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="submit" value="댓글 작성">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
