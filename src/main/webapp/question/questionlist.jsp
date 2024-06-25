<%@page import="pack.notice.NoticeDto"%>
<%@page import="pack.question.QuestionDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />
<jsp:useBean id="ndto" class="pack.notice.NoticeDto" />

<%
int spage = 1, pageSu = 0; //페이징을 하기 위한 변수
int start, end;
String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 Question 페이지</title>
<style>
/* 공지사항 테이블 스타일 */
#mypage-notice-table {
    width: 100%;
    border-spacing: 10px;
    margin-bottom: 30px;
    background-color: #fff;
}

#mypage-notice-table th, #mypage-notice-table td {
    padding: 10px;
    text-align: left;
}

#mypage-notice-table th {
    background-color: #333;
    color: white;
}

#mypage-notice-table a {
    color: #000; /* 검정색 글씨 */
    text-decoration: none; /* 밑줄 제거 */
}

#mypage-notice-table a:hover {
    font-size: 110%; /* 마우스 오버 시 글씨 크기 증가 */
}

/* 질문 테이블 스타일 */
#mypage-table {
    width: 100%;
    border-spacing: 10px;
    background-color: #fff;
}

#mypage-table th, #mypage-table td {
    padding: 10px;
    text-align: left;
}

#mypage-table th {
    background-color: #333;
    color: white;
}

/* 링크 스타일 */
#mypage-table a {
    color: #000; /* 검정색 글씨 */
    text-decoration: none; /* 밑줄 제거 */
}

#mypage-table a:hover {
    font-size: 110%; /* 마우스 오버 시 글씨 크기 증가 */
}

/* 새글작성 버튼 스타일 */
#mypage-table input[type="button"] {
    padding: 10px 20px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#mypage-table input[type="button"]:hover {
    background-color: #444;
}

/* 페이지네이션 스타일 */
#mypage-pagination {
    text-align: center;
    margin: 20px 0;
}

#mypage-pagination b {
    color: black;
    font-weight: bold;
    margin: 0 5px;
}

#mypage-pagination a {
    color: gray;
    margin: 0 5px;
    text-decoration: none;
}

#mypage-pagination a:hover {
    color: black;
}
</style>
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body id="mypage">
<jsp:include page="../user/header_user.jsp"></jsp:include>
<table id="mypage-notice-table">
<tr>
<th>공지번호</th><th width="90%">글제목</th>
</tr>
<%
ArrayList<NoticeDto> nlist = qmgr.getNoticeAll();
for(NoticeDto n:nlist){ 
%>
<tr>
	<td><%=n.getNum() %></td>
	<td><a href="javascript:noticeget('<%= n.getNum() %>')"><%=n.getTitle()%></a></td>
</tr>
<%	
}
%>
</table>
<table id="mypage-table">
<tr>
	<th>질문번호</th><th>질문제목</th><th>유저id</th><th>등록날짜</th>
</tr>

<%
try{
	spage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){
	spage = 1;
}
if(spage < 0) spage = 1;

qmgr.totalList(id); // 전체 레코드 수 계산
pageSu = qmgr.getPageSu(); // 전체 페이지 수 얻기

ArrayList<QuestionDto> list = qmgr.getData(spage, id); 

for (int i = 0; i < list.size(); i++) {
	qdto = list.get(i);
	int nst = 0;
	try {
		nst = Integer.parseInt(qdto.getAnswer_contents());
	} catch (NumberFormatException e) {
		nst = 0;
	}
	String tab = "&nbsp;&nbsp;";
%>
<tr>
	<td><%=qdto.getNum()%></td>
	<td><%=tab %><a href="questioncontent.jsp?num=<%=qdto.getNum()%>&page=<%=spage %>"><%=qdto.getTitle()%></a></td>
	<td><%=qdto.getUser()%></td>
	<td><%=qdto.getDate()%></td>
</tr>
<% 
}
%>
<tr> 
	<td colspan="4" style="text-align:center;">
		<input type="button" value="새글작성" onclick="location.href='questionwrite.jsp'">
	</td>
</tr>
</table>
<br>
<div id="mypage-pagination">
<%
for(int i = 1; i <= pageSu; i++){
	if(i == spage){
		out.print("<b>"+i+"</b>");
	}else{
		out.print("<a href='questionlist.jsp?page="+i+"'>"+i+"</a>");
	}
}
%>
</div>
<form action="noticedetail.jsp" method="post" name="noticeForm">
	<input type="hidden" name="num">
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>