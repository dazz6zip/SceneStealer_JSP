<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
Question 질문 등록
<form name="qfrm" method="post" action="questionsave.jsp" >
<table>
		<tr>
			<td>질문 작성 등록 페이지</td>
		</tr>
		<tr>
		<td>이름</td>
			<td>
				<input  name="user" size="15">
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input  name="title" size="15"></td>
		</tr>
		<tr>
			<td>사진</td>
			<td><input type="file" name="pic" size="30"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="contents" cols="50" rows="10"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center" height="30">
				<input type="button" value="메인" onclick="locaion.href='../guest_index.jsp;">&nbsp;
				<input type="button" value="작성" onclick="check()">&nbsp;
				<input type="button" value="목록" onclick="location.href='questionlist.jsp'">
			</td>
		</tr>
		
	</table>
</form>
</body>
</html>