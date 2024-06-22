<%@page import="pack.notice.NoticeDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="noticeMgr" class="pack.notice.NoticeMgr"/>
<jsp:useBean id="dto" class="pack.notice.NoticeDto"/>

<%
// 공지글 추가/삭제 후 접근 시(noticeproc.jsp - insert/delete)
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
int spage = 1, totalPage = 0; // 선택한 페이지 수, 전체 페이지 수
// int start, end; 페이지블럭: https://cafe.daum.net/flowlife/HqLp/13 코드참조
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<%@ include file = "admin_top.jsp" %>
<h2>공지사항</h2>
<input type="button" value="공지 등록" onclick="location.href='noticeinsert.jsp'">
<br><br>
<table style="width:100%">
	<tr style="background-color: silver;">
	<th>번호</th><th>제  목</th><th>작성 일자</th>
	</tr>
	<%
	try{
		spage= Integer.parseInt(request.getParameter("page"));
	}catch(Exception e){
		spage=1;
	}
	// 페이징처리
	totalPage = noticeMgr.getTotalPage();
	ArrayList<NoticeDto> list = noticeMgr.getDataAll(spage);
	
	for(int i=0; i<list.size(); i++){
		dto = (NoticeDto)list.get(i);
	%>	
	<tr>
	<td><%=dto.getNum() %></td>
	<td><a href="noticedetail.jsp?spage=<%=spage %>&num=<%=dto.getNum() %>"><%=dto.getTitle() %></a></td>
	<!-- noticedetail에서 noticelist돌아올떄 해당 spage를 들고 가도록 -->
	<td><%=dto.getDate() %></td>
	</tr>
	<%
	}
	%>
	</table>
	<br>
	<table style="width: 100%">
	<tr>
	<td style="text-align: center;">
	<%
	for(int i=1; i <= totalPage; i++){
		if(i==spage){ //선택페이지 굵은 빨강으로
			out.print("<b style='font-size:12pt;color:red'>[" +i + "]</b>");
		}else{ //선택되지 않은 페이지
			out.print("<a href='noticelist.jsp?page=" +i + "'>[" +i + "]</a>");	
		}	
	}
	%>
	</td>
	</tr>
</table>
</body>
</html>