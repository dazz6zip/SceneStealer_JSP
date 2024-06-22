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
<title>Insert title here</title>
</head>
<body>
<%@ include file="admin_top.jsp"%>
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
			<td>
				<textarea rows="10" name="contents"><%=dto.getContents()%></textarea>
			</td>
			<td>
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

<a href="noticelist.jsp?page=<%=spage%>">공지글 목록 돌아가기</a>
</body>
</html>