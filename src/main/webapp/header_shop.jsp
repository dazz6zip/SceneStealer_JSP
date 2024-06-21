<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%


String id = (String)session.getAttribute("idKey");
String log = "";

if (id == null) {
	log = "<a href='login.jsp'>로그인</a>";
} else {
	log = "<a href='logout.jsp'>로그아웃</a>";
}

%>
<script>
window.onload = () => {
	document.querySelector("#searchBtn").onclick = () => {
		const searchWordInput = document.querySelector("input[name='searchword']").value;
		const korOnly = /^[가-힣]+$/;
		
	//	if (!korOnly.test(searchWordInput)) {
	//		alert("한글만 입력 가능합니다.");
	//		document.querySelector("input[name='searchword']").focus();
	//		return;
//		}
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
<img src="../image/logo-01.png" width="5%">
<a href="">HOME</a>
<a href="">SHOP</a>
<form action="../main/main_search.jsp">
<input type="text" name="searchword" placeholder="검색어 입력">
<input type="button" id="searchBtn" value="search">
</form>
<a href="">cart</a>
<a href=""><%= log %></a>
