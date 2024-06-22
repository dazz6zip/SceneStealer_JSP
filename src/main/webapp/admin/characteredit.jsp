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
</head>
<body>
<%
	String series_num = request.getParameter("series_num"); // 시리즈 번호
	SeriesDto series = seriesMgr.getSeries(series_num);
	CharacterDto[] clist = characterMgr.getAllCharacters(series_num);
	// ** opener인 mainedit에 id가 reselectseries 같은 영역도 숨겨놨다 보이게 해서 
	// ** 캐릭터 편집 중 처음 시리즈 검색으로 다시 돌아갈 수 있는 방법이 필요함
%>
<h2>2️⃣Character & Actor</h2>
<table>
	<tr>
		<td>
			선택된 시리즈: <b>[<%=series.getTitle() %>]</b>
		</td>
	<tr>
	<tr>
		<td>
			<img src="../upload/<%=series.getPic() %>">
		</td>
	<tr>
		<td>	
<%
for(int i=0; i<4; i++){
	CharacterDto c = clist[i];
	if(c==null){
		int newNum = characterMgr.newNum(); // insert 시 저장될 PK character_num;		
%>
		<form action="characterproc.jsp?flag=insert" method="post" enctype="multipart/form-data">
		<table style="width: 100%">
		<tr>
			<td colspan="2"><b>➕<%=i+1 %>번째 캐릭터 추가하기</b></td>
		</tr>
		<tr>
			<td>캐릭터명</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>배우</td>
			<td>
				<input type="text" name="actor" id="connectedActor" readonly>
				<input type="button" onclick="actor_search('<%=series_num %>', '<%=newNum %>')" value="배우 찾기">
			</td>
		</tr>
		<tr>
			<td>캐릭터 대표 사진</td>
			<td><input type="file" name="pic"></td>
		</tr>
		</table>
		<input type="hidden" name="num" value="<%=newNum %>">
		<input type="hidden" name="series" value="seriesNum">
		<input type="submit" value="캐릭터 추가">
		<input type="reset" value="새로 작성">
		</form>
		<hr>
<%
	} else {
		// 캐릭터 수정은 character_name, character_pic만 가능
		ActorDto actor = characterMgr.getActor(c.getNum());
%>
		<form action="characterproc.jsp?flag=update" method="post" enctype="multipart/form-data">
		<table style="width: 100%">
		<tr>
			<td colspan="2">
				<b>✏️<%=i+1 %>번째 캐릭터 수정하기</b>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="text" name="name" value="<%=c.getName() %>"> 역</b>
			</td>
		</tr>
		<tr>
			<td>배우정보:</td>
			<td>
				<b>
				<%=actor.getName() %>&nbsp;
				(<%=actor.getBirth() %>)
				<!-- 배우 다시 선택 버튼 추가해야 할 지 고민-->
				</b>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<img src="../upload/character/<%=c.getPic() %>">
				<input type="file" name="pic">
			</td>
		</tr>
		</table>
		<input type="hidden" name="num" value="<%=c.getNum() %>">
		<input type="submit" value="캐릭터 수정">
		<input type="reset" value="새로 작성">
		</form>
		<hr>
<%
	}
}
%>
		</td>
	</tr>
</table>
</body>
</html>