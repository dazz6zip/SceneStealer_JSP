<%@page import="pack.main.ActorDto"%>
<%@page import="pack.main.SeriesDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String searchword = request.getParameter("searchword");
String searchSelect = request.getParameter("searchSelect");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<style>
/* Series Picture Styles */
.series-pic {
    width: 200px; /* 고정 너비 */
    height: 300px; /* 고정 높이 */
    object-fit: cover;
    object-position: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
}

.series-pic.enlarged {
    transform: scale(1.3);
    z-index: 10;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

body {
    margin: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    height: 100vh;
}

#maindiv {
    display: flex;
    justify-content: center;
    align-items: center;
    background: url(../image/mainphoto-01.png) no-repeat;
    background-size: cover;
    height: 120vh;
    width: 100%;
    overflow: hidden;
}

.main {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.main table {
    width: 100%;
    border-collapse: collapse;
}

.main table td {
    text-align: center;
    padding: 10px;
}

#main_rv img {
    width: 200px; /* 고정 너비 */
    height: 200px; /* 고정 높이 */
    object-fit: cover;
    object-position: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
}

td img {
    width: 200px; /* 고정 너비 */
    height: 300px; /* 고정 높이 */
    object-fit: cover;
    object-position: center;
}
</style>
<script type="text/javascript" src="../js/main.js"></script>
</head>
<body>
<jsp:include page="../main/header_main.jsp">
<jsp:param value="<%= searchword %>" name="val"/>
</jsp:include>

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
			<table onclick="javascript:searchSeriesClick('<%= sdto.getTitle() %>', '<%= sdto.getNum() %>')">
				<tr>
					<td><img src="..\upload\series\<%= sdto.getPic() %>" class="series-pic"></td>
				</tr>
				<tr>
					<td style="text-align: center;"><%= sdto.getTitle() %>(<%= sdto.getDate().substring(0, 4) %>)</td>
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
<form action="sub.jsp" method="post" name="sscFrm">
<input type="hidden" name="series_num">
<input type="hidden" name="series_title">
</form>
</body>
</html>