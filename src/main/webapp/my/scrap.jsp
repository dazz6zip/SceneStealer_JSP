<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.scrap.ScrapMrg"></jsp:useBean>
<jsp:useBean id="cdto" class="pack.main.CharacterDto"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<% 
int spage = 1;
int pageSu = 0;

int start, end;

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
<title>Insert title here</title>
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
<table>
	<tr>
		<%		
		mgr.totalList(id); // 전체 레코드 수 계산
		pageSu = mgr.getPageSu(); // 전체 페이지 수 얻기
		
		for (int i = 0; i < clist.size(); i++) {
			cdto = clist.get(i);
			sdto = mgr.getScrapSeries(cdto.getSeries());
			%>
			<td>
				<table style="background-color: gray">
					<tr><td><img src="..\\upload\\character\\<%= cdto.getPic() %>"></td></tr>
					<tr><td><%= sdto.getTitle() %></td></tr>
					<tr><td><%= cdto.getName() %></td></tr>
					<tr><td><a href="javascript:dropScrap('<%= cdto.getNum() %>')"><img src="../image/heart1.png" width="20px"></a></td></tr>
				</table>
			</td>
			<%
		}
		%>
	</tr>
</table>
<table style="width: 100%; font-size: 80%">
				<tr>
					<td style="text-align: center;">
					<%
						for (int i = 1; i <= pageSu; i++) {
							if (i == spage) { // 현재 페이지
								out.print("<b style='font-size: 110%'>" + i + "</b>&emsp;");
							} else {
								out.print("<a href='scrap.jsp?page=" + i + "'>" + i + "</a>&emsp;");								
							}
						}
					%>
					
					</td>
				</tr>
			</table>
<form action="dropScrap.jsp" method="post" name="dsFrm">
<input type="hidden" name="character_num">
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>