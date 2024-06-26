<%@page import="pack.main.ActorDto"%>
<%@page import="pack.main.CharacterDto"%>
<%@page import="pack.main.SeriesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="seriesMgr" class="pack.main.SeriesMgr" />
<jsp:useBean id="characterMgr" class="pack.main.CharacterMgr" />
<!-- mainedit에 시리즈 선택 후 include되는 파일 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
img {
	width: 100px;
}

#selectedSeries {
	width: 200px;
}
</style>
</head>
<body>
<%
	String series_num = request.getParameter("series_num"); // 시리즈 번호
	SeriesDto series = seriesMgr.getSeries(series_num); // 선택한 시리즈의 정보를 보여주기 위함
	CharacterDto[] clist = characterMgr.getAllCharacters(series_num);
%>
<h2>2️⃣Character & Actor</h2>

<img id="selectedSeries" src="../upload/series/<%=series.getPic() %>"><br>		

<table>
	<tr>

<%
for(int i=0; i<4; i++){
	CharacterDto c = clist[i];
	if(c==null){
		int newNum = characterMgr.newNum(); // insert 시 저장될 PK character_num;		
%>
	
	<td>
		<form name="frm" action="characterproc.jsp?flag=insert&character_num=<%=newNum %>&" method="post" enctype="multipart/form-data">
		<table>
		<tr>
			<td colspan="2"><b>➕<%=i+1 %>번째 캐릭터 추가하기</b></td>
		</tr>
		<tr>
			<td>배역 이름</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>배우</td>
			<td>
				<input type="button" onclick="actor_search()" value="배우 찾기">
				선택배우정보<input type="text" name="selectedActorInfo" readonly>
				선택배우번호<input type="text" name="actor" id="selectedActorNum" readonly>
			</td>
		</tr>
		<tr>
			<td>캐릭터 대표 사진</td>
			<td><input type="file" name="pic"></td>
		</tr>
		</table>
		<input type="hidden" name="num" value="<%=newNum %>">
		<input type="hidden" name="character">
		<input type="hidden" name="series" value=<%=series_num %>>
		<input type="submit" value="캐릭터 추가 및 선택하기">
		<input type="reset" value="새로 작성">
		</form>
		<hr>
	</td>
	
<%
	} else {
		// 캐릭터 수정은 character_name, character_pic만 가능
		ActorDto actor = characterMgr.getActor(c.getNum());
%>
	
	<td>
		<form action="characterproc.jsp?flag=update&character_num=<%=c.getNum() %>" method="post" enctype="multipart/form-data">
		<table>
		<tr>
			<td>
				<b>✏️<%=i+1 %>번째 캐릭터 수정하기</b>
			</td>
		</tr>
		<tr>
			<td>
				<b><%=c.getName() %></b> 역
				<b>
				: 배우 <%=actor.getName() %>&nbsp;
				(<%=actor.getBirth() %>)
				</b>
			</td>
		</tr>
		<tr>
			<td>
				<img src="../upload/character/<%=c.getPic() %>"><br>
				🔽대표사진 변경🔽<br>
				<input type="file" name="pic">
			</td>
		</tr>
		</table>
		<input type="hidden" name="num" value="<%=c.getNum() %>">
		<input type="submit" value="캐릭터 수정 및 선택하기">
		</form>
	</td>
	
<%
	}
}
%>
</tr>
</table>
</body>
</html>