<%@page import="pack.notice.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="noticeMgr" class="pack.notice.NoticeMgr" />

<%
// 목록에서가 아니라 수정 후 접근 시(noticeproc.jsp - update)
// 처리 결과를 먼저 alert 해주기
String msg = (String)session.getAttribute("msg");
if(msg != null) {
    session.removeAttribute("msg"); // 메시지 한 번 표시 후 제거되어야 하므로
%>
    <script type="text/javascript">
        alert("<%=msg %>");
    </script>
<%
}
String num = request.getParameter("num"); // notice_num
String spage = request.getParameter("spage");
NoticeDto dto = noticeMgr.getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        color: #333;
        text-align: center;
        margin: 0;
        padding: 0;
    }

    h2 {
        color: #ff69b4;
        margin: 20px 0;
    }

    a {
        color: #ff69b4;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    table {
        width: 90%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #ff69b4;
        color: white;
    }

    td {
        background-color: #fff;
    }
    input[type="text"], textarea {
        width: 95%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin: 5px 0;
    }

    input[type="file"] {
        padding: 10px;
        margin: 5px 0;
    }

    input[type="submit"], input[type="button"] {
        background-color: #ff69b4;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        margin: 10px;
    }

    input[type="submit"]:hover, input[type="button"]:hover {
        background-color: #ff1493;
    }

    .center {
        text-align: center;
    }

    .link {
        display: block;
        margin: 20px 0;
        color: #ff69b4;
        text-decoration: none;
        font-weight: bold;
    }

    .link:hover {
        text-decoration: underline;
    }

    img {
        max-width: 100%;
        height: auto;
        border-radius: 5px;
        margin-top: 10px;
    }
</style>
</head>
<body>
<%@ include file="admin_top.jsp"%>
<h2>공지사항 수정</h2>
<form action="noticeproc.jsp?flag=update&num=<%=num %>&spage=<%=spage %>" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>제목</td>
            <td><input type="text" name="title" value="<%=dto.getTitle()%>"></td>
        </tr>
        <tr>
            <td>작성일</td>
            <td><%=dto.getDate()%></td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea rows="10" name="contents"><%=dto.getContents()%></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="center">
                <img src="../upload/<%=dto.getPic() %>">
                <input type="file" name="pic">
            </td>
        </tr>
    </table>
    <input type="hidden" name="num" value="<%=dto.getNum() %>">
    <input type="submit" value="수정하기">
</form>

<form action="noticeproc.jsp?flag=delete" method="post">
    <input type="hidden" name="num" value="<%=dto.getNum()%>"> 
    <input type="submit" value="삭제하기">
</form>

<a href="noticelist.jsp?page=<%=spage%>" class="link">공지글 목록 돌아가기</a>
</body>
</html>