<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.main.SeriesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="seriesMgr" class="pack.main.SeriesMgr" />
<jsp:useBean id="characterMgr" class="pack.main.CharacterMgr" />
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 편집</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/mainedit.js"></script>
</head>
<body>
<%@ include file = "admin_top.jsp" %>
<h4>실행 검사 순서: 1️⃣Series 2️⃣Character & Actor 3️⃣Style 4️⃣Item</h4>
<hr>
<div id="series">
	<h2>1️⃣Series</h2>
	영화/드라마 : <input type="text" id="keywordSeries">
	<div id="suggestSeries" style="display: none; background-color: lavender; position: absolute; left: 110px; top: 280px;">
		<div id="suggestSeriesList"></div>
	</div>
</div>

<!-- 시리즈에서 캐릭터로 -->
<%
	//	시리즈 선택하면 파라미터로 시리즈번호가 넘어옴
	//	시리즈 정보를 보여주고 캐릭터 편집 영역 띄우기
	String series_num = request.getParameter("series_num");
	request.setAttribute("series_num", series_num); // JSTL이나 EL 태그에서 접근할 수 있도록
%>
<c:if test="${series_num != null}">
	 <script>
	 document.addEventListener("DOMContentLoaded", function() {
		 document.getElementById('series').style.display = 'none';
	 });
    </script>
    <jsp:include page="characteredit.jsp">
        <jsp:param name="series_num" value="${series_num}" />
    </jsp:include>
</c:if>

<!-- 캐릭터에서 스타일로 -->
<%
	//	캐릭터 선택하면 파라미터로 캐릭터번호가 넘어옴
	//	캐릭터 정보를 보여주고 스타일 편집 영역 띄우기
	String character_num = request.getParameter("character_num");
	request.setAttribute("character_num", character_num); // JSTL이나 EL 태그에서 접근할 수 있도록
%>
<c:if test="${character_num != null}">
	 <script>
	 document.addEventListener("DOMContentLoaded", function() {
		 document.getElementById('series').style.display = 'none';
	 });
    </script>
    <jsp:include page="styleedit.jsp">
        <jsp:param name="character_num" value="${character_num}" />
    </jsp:include>
</c:if>

<!-- 스타일에서 아이템으로 -->
<%
	//	스타일 선택하면 파라미터로 스타일번호가 넘어옴
	//	스타일 정보를 보여주고 아이템 편집 영역 띄우기
	String style_num = request.getParameter("style_num");
	request.setAttribute("style_num", style_num); // JSTL이나 EL 태그에서 접근할 수 있도록
%>
<c:if test="${style_num != null}">
	 <script>
	 document.addEventListener("DOMContentLoaded", function() {
		 document.getElementById('series').style.display = 'none';
	 });
    </script>
    <jsp:include page="itemedit.jsp">
        <jsp:param name="style_num" value="${style_num}" />
    </jsp:include>
</c:if>

</body>
</html>