<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.scrap.ScrapMrg"></jsp:useBean>
<jsp:useBean id="cdto" class="pack.main.CharacterDto"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<% 
int spage = 1;
int pageSu = 0;

String id = (String)session.getAttribute("idKey");
if (id == null) {
	response.sendRedirect("../user/loginForm.jsp");
	return;
}
try {
	spage = Integer.parseInt(request.getParameter("page"));
} catch(Exception e) {
	spage = 1;
}

if (spage <= 0) {
	spage = 1;
}
ArrayList<CharacterDto> clist = mgr.getScrapCharacter(id, spage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Scrap Characters</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    margin-top: 20px;
}

.character-table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
}

.character-card-container {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
}

.character-card {
    width: 200px;
    height: 300px;
    background-size: cover;
    background-position: center;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    color: white;
    font-weight: bold;
    margin: 10px;
    padding: 10px;
    text-align: center;
}

.character-card td {
    background: rgba(0, 0, 0, 0.5);
    padding: 5px;
    border: none;
}

.character-card a {
    color: white;
    text-decoration: none;
}

.pagination {
    text-align: center;
    margin: 20px 0;
}

.pagination a, .pagination b {
    margin: 0 5px;
    text-decoration: none;
    color: #333;
}

.pagination b {
    font-size: 110%;
}

.pagination a:hover {
    color: #007bff;
}
</style>
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
function dropScrap(num) {
	document.dsFrm.character_num.value = num;
	document.dsFrm.submit();
}
</script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<h1>Scrap Characters</h1>
<div class="character-card-container">
	<%		
	mgr.totalList(id); // 전체 레코드 수 계산
	pageSu = mgr.getPageSu(); // 전체 페이지 수 얻기
	
	for (int i = 0; i < clist.size(); i++) {
		cdto = clist.get(i);
		sdto = mgr.getScrapSeries(cdto.getSeries());
		%>
		<div class="character-card" style="background-image: url('..\\upload\\character\\<%= cdto.getPic() %>')">
			<div style="height: 60%"></div>
			<div><%= sdto.getTitle() %></div>
			<div><%= cdto.getName() %></div>
			<div><a href="javascript:dropScrap('<%= cdto.getNum() %>')"><img src="../image/heart1.png" width="20px"></a></div>
		</div>
		<%
	}
	%>
</div>
<div class="pagination">
	<%
		for (int i = 1; i <= pageSu; i++) {
			if (i == spage) { // 현재 페이지
				out.print("<b>" + i + "</b>");
			} else {
				out.print("<a href='scrap.jsp?page=" + i + "'>" + i + "</a>");								
			}
		}
	%>
</div>
<form action="dropScrap.jsp" method="post" name="dsFrm">
<input type="hidden" name="character_num">
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>