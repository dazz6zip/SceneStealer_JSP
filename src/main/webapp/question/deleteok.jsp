<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />

<%
String spage = request.getParameter("page");
String num = request.getParameter("num");
boolean b = false;
b = qmgr.delData(num);
if(b){
	%>
	<script>
	alert("a");
	</script>
	<%
}else{
	%>
	<script>
	alert("b");
	</script>
<%		
}
 
response.sendRedirect("questionlist.jsp?page=" + spage);

%>