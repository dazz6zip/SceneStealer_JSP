<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="styleMgr" class="pack.main.StyleMgr" />

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/mainedit.js"></script>

<%
request.setCharacterEncoding("utf-8");
String msg = "";
String num = request.getParameter("style_num");

switch(request.getParameter("flag")){
case "insert":
	msg = styleMgr.insertStyle(request) ? "스타일 등록 완료" : "스타일 등록 실패 ㅠㅠ";
	break;
case "update":
	msg = styleMgr.updateStyle(request) ? "스타일 수정 완료" : "스타일 수정 실패 ㅠㅠ";
	break;	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><%=msg %></h3><br>
<b>🛍️아이템 목록🛍️‍으로 이동하겠습니다.<br>
<input type="button" value="4️⃣단계 아이템 편집 시작" onclick="style_select('<%=num %>')">
</body>
</html>