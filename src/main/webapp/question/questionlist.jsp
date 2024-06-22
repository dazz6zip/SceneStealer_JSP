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
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>

</head>
<body>
<table>
<tr>
<td colspan="2">공지사항</td>
</tr>
<tr>
<th>공지번호</th><th>글제목</th>
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
<table>
	
	<tr>
		<td>질문번호</td><td>질문제목</td><td>유저id</td><td>등록날짜</td>
	</tr>

<%
// String id = (String)session.getAttribute("idKey");
//if (id == null) { //연습용 user1 로그인했다고 생각
//	id = "user1";
//}
// page 처리를위한 spage값 얻기
try{
	spage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){
	spage = 1;
}
if(spage <0) spage=1;

qmgr.totalList(id); // 전체 레코드 수 계산
pageSu = qmgr.getPageSu(); // 전체 페이지 수 얻기

ArrayList<QuestionDto> list = qmgr.getData(spage, id); 
 
for (int i = 0; i < list.size(); i++) {
	qdto = list.get(i);
	// 댓글 들여쓰기 안됨(챗으로 수정)
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
		<td>
		<%=tab %><a href="questioncontent.jsp?num=<%=qdto.getNum()%>&page=<%=spage %>"><%=qdto.getTitle()%></a>
		</td>
		<td><%=qdto.getUser()%></td>
		<td><%=qdto.getDate()%></td>
		
	</tr>
<% 
}
%>
<tr> 
	<td>
		<input type="button" value="새글작성" onclick="location.href='questionwrite.jsp'">
	</td>
</tr>
</table>
<br>
<table style="width: 100%">
<tr>
	<td style="text-align: center;">
	<%
	for(int i =1; i<= pageSu; i++){
		if(i == spage){
			out.print("<b style='font-size:14pt;color:red'>["+i+"]</b>");
		}else{
			out.print("<a href='questionlist.jsp?page="+i+"'>["+i+"]</a>");
		}
	}
	
	%>
	
	<br><br>

	
	
	
	</td>
</tr>

</table>
<form action="noticedetail.jsp" method="post" name="noticeForm">
	<input type="hidden" name="num">
</form>
</body>
</html>