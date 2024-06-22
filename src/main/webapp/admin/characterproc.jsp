<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="characterMgr" class="pack.main.CharacterMgr"/>
<%
request.setCharacterEncoding("utf-8");
String msg = "";
String num = request.getParameter("num");

switch (request.getParameter("flag")) {
case "insert":
	msg = characterMgr.insertCharacter(request) ? "시리즈 등록 완료" : "시리즈 등록 실패 ㅠㅠ";
	break;
case "update":
	msg = characterMgr.updateCharacter(request) ? "시리즈 수정 완료" : "시리즈 수정 실패 ㅠㅠ";
	break;
}
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
<b><%=msg %></b><br>
<input type="button" value="3️⃣Style 편집 시작" onclick="charcter_select('<%=num %>')">

</body>
</html>

