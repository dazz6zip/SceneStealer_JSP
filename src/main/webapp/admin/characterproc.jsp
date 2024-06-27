<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="characterMgr" class="pack.main.CharacterMgr"/>
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<%
request.setCharacterEncoding("utf-8");
String msg = "";
String num = request.getParameter("character_num");

switch (request.getParameter("flag")) {
case "insert":
	msg = characterMgr.insertCharacter(request) ? "캐릭터 등록 완료" : "캐릭터 등록 실패 ㅠㅠ";
	// flag 값을 얻기 위해 request.getParameter() 메소드로 request 객체를 사용완료하였으므로, 아래 메소드에서 파라미터로 재사용하면 값을 받지 못함
	// 따라서 파라미터로 받은 캐릭터번호 num과, 위에서 방금 추가된 해당 캐릭터와 시리즈의 관계를 바로 이용하여 배우와 시리즈 관계를 추가 
	msg += actorMgr.connectSeries(num) ? " & 해당 배우와 시리즈 연결 완료" : " & 해당 배우와 시리즈 연결 실패 ㅠㅠ";
	break;
case "update":
	msg = characterMgr.updateCharacter(request) ? "캐릭터 수정 완료" : "캐릭터 수정 실패 ㅠㅠ";
	break;
}

// PK를 통해 반환받은 CharacterDto의 name
// insert, update *처리 이후*에 받아야 함. 위치 중요
// 처리 이전에 받으면 insert에서는 null로, update에서는 수정 전으로 저장되기 때문
String name = characterMgr.getCharacter(num).getName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/mainedit.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</head>
<body>
<h3><%=msg %></h3><br>
<b>🛍️<%=name %></b> 배역의 스타일 목록🛍️‍‍으로 이동하겠습니다.<br>
<input type="button" value="3️단계 스타일 편집 시작" onclick="javascript:character_select('<%=num %>')">
</body>
</html>

