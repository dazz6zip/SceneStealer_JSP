<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.scrap.ScrapMrg"></jsp:useBean>
<jsp:useBean id="cdto" class="pack.main.CharacterDto"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<% 
/*
String id = (String)session.getAttribute("idKey");
if (id == null) {
	response.sendRedirect("login.jsp");
	return;
}*/
String id = "user3";
ArrayList<CharacterDto> clist = mgr.getScrapCharacter(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<%
		for (int i = 0; i < clist.size(); i++) {
			cdto = clist.get(i);
			sdto = mgr.getScrapSeries(cdto.getSeries());
			%>
			<td>
				<table>
					<tr><td><%= cdto.getPic() %></td></tr>
					<tr><td><%= sdto.getTitle() %></td></tr>
					<tr><td><%= cdto.getName() %></td></tr>
					<tr><td>하트이미지</td></tr>
				</table>
			</td>
			<%
		}
		%>
	</tr>
</table>
</body>
</html>