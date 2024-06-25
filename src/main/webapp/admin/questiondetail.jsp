<%@page import="pack.question.QuestionDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="questionMgr" class="pack.question.QuestionMgr" />
<%
// 맨 아래 questionlist로 돌아갈 때 받아온 upage, apage 유지되도록 들고 가기 위해
String upage = request.getParameter("upage");
String apage = request.getParameter("apage");

// question_num
int num = Integer.parseInt(request.getParameter("num"));
QuestionDto dto = questionMgr.getData(num);

// 답변 작성 완료 여부에 따라 답변란과 답변 업로드 버튼의 이름을 다르게 설정
String answer = (dto.getAnswer_contents() == null) ? "" : dto.getAnswer_contents();
String btnName = (dto.getAnswer_contents() == null) ? "✔️답변 등록" : "✏️답변 수정";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 상세 보기</title>
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
        text-align: left;
        border: 1px solid #ddd;
    }

    th {
        background-color: #ff69b4;
        color: white;
    }

    td img {
        max-width: 60%;
        height: auto;
        border-radius: 5px;
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

    textarea {
        width: 95%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin: 5px 0;
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
</style>
</head>
<body>
<%@ include file = "admin_top.jsp" %>
<h2>질문 상세 보기</h2>
<table>
    <tr>
        <td>질문자</td>
        <td>
            <form action="orderlist.jsp" method="post">
                <input type="hidden" name="user" value="<%=dto.getUser()%>">
            <%=dto.getUser()%><input type="submit" value="<%=dto.getUser()%>의 주문 목록 조회">
            </form>
        </td>    
    </tr>
    <tr>
        <td>작성일</td>
        <td><%=dto.getDate()%></td>
    </tr>
    <tr>
        <td>제목</td>
        <td><%=dto.getTitle()%></td>
    </tr>
    <tr>
        <td>
            <textarea rows="10" readonly><%=dto.getContents()%></textarea>
        </td>
        <td colspan="2">
            <img src="../upload/<%=dto.getPic()%>">
        </td>
    </tr>
</table>
<hr>
답변<br>
<form action="answerupdate.jsp" method="post">
    <textarea rows="5" name="answer"><%=answer %></textarea>
    <input type="hidden" name="num" value="<%=num %>">
    <input type="submit" value="<%=btnName %>">
</form>
<a href="questionlist.jsp?upage=<%=upage %>&apage=<%=apage %>" class="link">질문글 목록으로 돌아가기</a>
</body>
</html>