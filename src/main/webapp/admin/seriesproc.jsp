<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="seriesMgr" class="pack.main.SeriesMgr"/>
<%
request.setCharacterEncoding("utf-8");
String msg = "";
String num = request.getParameter("num");

switch (request.getParameter("flag")) {
case "insert":
	msg = seriesMgr.insertSeries(request) ? "시리즈 등록 완료" : "시리즈 등록 실패 ㅠㅠ";
	break;
case "update":
	msg = seriesMgr.updateSeries(request) ? "시리즈 수정 완료" : "시리즈 수정 실패 ㅠㅠ";
	break;
}

//PK를 통해 반환받은 SeriesDto의 title
//insert, update *처리 이후*에 받아야 함. 위치 중요
//처리 이전에 받으면 insert에서는 null로, update에서는 수정 전으로 저장되기 때문
String title = seriesMgr.getSeries(num).getTitle(); 
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
<h3><%=msg %></h3><br>
<b><%=title %></b>의 👨‍👩‍👧‍👦‍캐릭터 목록👨‍👩‍👧‍👦‍으로 이동하겠습니다.<br><br>
<input type="button" value="2️⃣단계 캐릭터 편집 시작" onclick="series_select('<%=num %>')">
</body>
</html>

