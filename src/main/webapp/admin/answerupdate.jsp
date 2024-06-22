<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="questionMgr" class="pack.question.QuestionMgr" />
<%
int num = Integer.parseInt(request.getParameter("num"));
String answer = request.getParameter("answer");
int result = questionMgr.answerUpdate(num, answer);
if(result == 1){	
%>
	<script>
	alert("답변 등록/수정이 완료되었습니다.");
	location.href = "questionlist.jsp";
	</script>
<%
} else {
%>
	<script>
	alert("오류 발생: 답변 등록이 불가능합니다");
	history.back();
	</script>
<%
}
%>
