<%@page import="pack.main.ActorDto"%>
<%@page import="pack.main.SeriesDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%

String searchword = request.getParameter("searchword");
String searchSelect = request.getParameter("searchSelect");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="mainstyle.css">
</head>
<body>
<jsp:include page="../main/header_main.jsp">
<jsp:param value="<%= searchword %>" name="val"/>
</jsp:include>
<script>
window.onload = () => {
	document.querySelector("#searchFrm").style.display = "block";
}
</script>
<%
if (searchword == null && searchSelect == null) {
	%>
	<table>
		<tr>
			<th>키워드를 입력하세요</th>
		</tr>
	</table>
	<%
	return;
}

ArrayList<SeriesDto> list = mgr.searchSeries(searchword.replaceAll(" ", ""), searchSelect.replaceAll(" ", ""));	
if (list != null && !list.isEmpty()) {
%>

<table>
	<tr>
	<%
	for (int i = 0; i < list.size(); i++) {
		if (i > 0 && i % 4 == 0) {
			%></tr><tr><%
		}
		sdto = list.get(i);
	%>
		<td>
			<table>
				<tr>
					<td><%= sdto.getPic() %></td>
				</tr>
				<tr>
					<td><%= sdto.getTitle() %></td>
				</tr>
			</table>
		</td>
	<%
	}
%>
	</tr>
</table>
<%
} else {
	%>
	<table>
		<tr>
			<td>검색 결과가 없습니다!</td>
		</tr>
	</table>
	<%
}
%>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>