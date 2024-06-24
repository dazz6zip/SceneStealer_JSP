<%@page import="pack.main.SeriesMgr"%>
<%@page import="pack.main.CharacterDto"%>
<%@page import="pack.main.StyleDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="styleMgr" class="pack.main.StyleMgr" />
<jsp:useBean id="characterMgr" class="pack.main.CharacterMgr" />
<!-- mainedit에 캐릭터 선택 후 include되는 파일 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String character_num = request.getParameter("character_num");
	CharacterDto character = characterMgr.getCharacter(character_num);
	ArrayList<StyleDto> slist = styleMgr.getAllStyle(character_num);	
	
	// 스타일 목록 마지막에 스타일 추가 테이블
	int newNum = styleMgr.newNum(); // 추가될 스타일의 PK
%>
<h4>2️⃣Character: [<%=character.getName() %>] 선택완료</h4>
<h2>3️⃣Style</h2>
<table>	
<tr>
	<td>
		<b>➕스타일 추가하기</b>
		<form action="styleproc.jsp?flag=insert&style_num=<%=newNum %>" method="post" enctype="multipart/form-data">
			스타일 대표 사진: <input type="file" name="pic">
			<br><br>
			<input type="hidden" name="num" value="<%=newNum %>">
			<input type="hidden" name="character" value="<%=character_num%>">
			<input type="submit" value="스타일 추가">
		</form>
		<hr>
	</td>
	</tr>
<%
for(int i=0; i<slist.size(); i++){
	StyleDto s = slist.get(i);
	StyleDto style = styleMgr.getStyle(s.getNum());
	// 스타일 수정은 style_pic만 가능
%>
	<tr>
	<td>
		<b>✏️<%=i+1 %>번째 스타일 수정하기</b>
		<form action="styleproc.jsp?flag=update&style_num=<%=s.getNum() %>" method="post" enctype="multipart/form-data">
			<img src="../upload/style/<%=s.getPic() %>"><br>
			대표사진 변경➡️<input type="file" name="pic">
			<br><br>
			<input type="hidden" name="num" value="<%=s.getNum() %>">
			<input type="hidden" name="character" value="<%=character_num%>">
			<input type="submit" value="스타일 수정">
		</form>
		<hr>
	</td>
	</tr>
<%
}
%>
	
</table>
</body>
</html>