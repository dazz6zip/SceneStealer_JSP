<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<%
// 아이템 추가 시 상품 검색
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
<div id="productSuggest">
	<h2>상품 선택</h2>
	상품명 검색 : <input type="text" name="keywordProduct" id="keywordProduct">
	<div id="suggestProduct" style="display: none; background-color: lavender; position: absolute; left: 110px; top: 100px;">
		<div id="suggestProductList"></div>
	</div>
</div>
</body>
</html>