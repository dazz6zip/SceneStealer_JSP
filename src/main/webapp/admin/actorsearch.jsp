<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<%
// 캐릭터 추가 시 배우 검색할 때, 캐릭터와 시리즈에 연결해주기 위해 값 받기
String series = request.getParameter("series");
String character = request.getParameter("character");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/mainedit.js"></script>
</head>
<body>
<div id="actorSuggest">
	<h2>배우 선택</h2>
	배우명 검색 : <input type="text" name="keywordActor" id="keywordActor">
	<div id="suggestActor" style="display: none; background-color: lavender; position: absolute; left: 110px; top: 100px;">
		<div id="suggestActorList"></div>
	</div>
</div>
</body>
</html>