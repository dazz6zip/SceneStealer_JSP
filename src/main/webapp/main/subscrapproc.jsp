<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%
String flag = request.getParameter("flag");
String cname = request.getParameter("cname");
String id = (String)session.getAttribute("idKey");
if (flag.equals("insert")) {
	mgr.newScrap(cname, id);
	response.sendRedirect("sub.jsp");
} else if (flag.equals("delete")) {
	mgr.delScrap(cname, id);
	response.sendRedirect("sub.jsp");
} else {
	%>
	<script>
		alert("scrap error");
	</script>
	<%
}
%>