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
<title>Insert title here</title>
</head>
<body>
<%@ include file = "admin_top.jsp" %>
<table>
	<tr>
		<td>질문자</td>
		<td>
			<%=dto.getUser()%>
			<form action="orderlist.jsp" method="post">
				<input type="hidden" name="user" value="<%=dto.getUser()%>">
				<input type="submit" value="<%=dto.getUser()%>의 주문 목록 조회">
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
	<textarea rows="5" style="width:90%" name="answer"><%=answer %></textarea>
	<input type="hidden" name="num" value="<%=num %>">
	<input type="submit" value="<%=btnName %>">
</form>
<a href="questionlist.jsp?upage=<%=upage %>&apage=<%=apage %>">질문글 목록으로 돌아가기</a>
</body>
</html>