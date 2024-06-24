<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.scrap.ScrapMrg"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");
String character_num = request.getParameter("character_num");

boolean b = mgr.dropScrap(character_num, id);

if (b) {
	%>
	<script>
	alert("스크랩 취소 성공");
	location.href = "scrap.jsp";
	</script>
	<%
} else {
	%>
	<script>
	alert("스크랩 취소 실패");
	location.href = "scrap.jsp";
	</script>
	<%
}
%>