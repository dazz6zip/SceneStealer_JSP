<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String val = request.getParameter("val");
String id = (String)session.getAttribute("idKey");
String log = "";

if (id == null) {
	log = "<a href='../user/loginForm.jsp'>로그인</a>";
} else {
	log = "<a href='../user/logout.jsp'>로그아웃</a>&emsp;<a href=''>프로필사진</a>";
}


%>
<style>
#searchFrm {
<% if (val != null) {%>
	display: block;
	<%} else {%>
	display: none;	
	<%}%>
}

#showSearch {
<% if (val != null) {%>
	display: none;	
	<%} else {%>
	display: block;
	<%}%>
}
</style>
<script>
window.onload = () => {
	document.querySelector("#showSearch").onclick = () => {
		document.querySelector("#searchFrm").style.display = "block";
		document.querySelector("#showSearch").style.display = "none";
		}
	document.querySelector("#searchBtn").onclick = () => {
		const searchWordInput = document.querySelector("input[name='searchword']").value;
		const korOnly = /^[가-힣]+$/;

	//	if (!korOnly.test(searchWordInput)) {
	//		alert("한글만 입력 가능합니다.");
	//		document.querySelector("input[name='searchword']").focus();
	//		return;
	//	}
	//	else 
			if (searchWordInput.length < 2) {
			alert("두 글자 이상 입력해 주세요.");
			document.querySelector("input[name='searchword']").focus();
			return;
		}
		else {
			document.querySelector("form").submit();
		}
	
	}
}
</script>
<table style="height: 10px;">
<tr>
<td><img src="../image/logo-01.png" width="15px"></td>
<td><a href="main.jsp">HOME</a></td>
<td><a href="../shop/productlist.jsp">SHOP</a></td>
<td>
<form action="../main/main_search.jsp">
<div id="searchFrm" align="right">
<select name="searchSelect">
	<option value="series" selected="selected">작품 제목</option>
	<option value="actor">배우</option>
</select>
<input type="text" name="searchword" <%
if (val != null) {
	out.print("value = '" + val + "'");
} else {
	out.print("placeholder='검색어를 입력하세요.'");
}
%>>
<input type="button" id="searchBtn" value="검색하기">
</div>
<input type="button" id="showSearch" value="search">
</form>
</td>
<td><a href=""><%= log %></a></td>
</tr>
</table>