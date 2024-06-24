<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="udto" class="pack.user.UserDto" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">

//Question 부분
function check(){
	//alert("aaa");
	
	if(qfrm.title.value ==""){
		alert("제목 쓰세요");
		qfrm.title.focus();
	}else if(qfrm.pic.value ==""){
		alert("사진 올리세요");
		qfrm.pic.focus();
	}else if(qfrm.contents.value ==""){
		alert("내용 쓰세요");
		qfrm.contents.focus();
	}else {
		qfrm.submit();
	}
}</script>
<%
String user_id = (String)session.getAttribute("idKey");

%>
</head>
<body>
<jsp:include page="../user/header_user.jsp"></jsp:include>
Question 질문 등록
<form name="qfrm" method="post" action="questionsave.jsp?flag=insert" enctype="multipart/form-data">
<table>
		<tr>
			<td>질문 작성 등록 페이지</td>
		</tr>
		<tr>
		<td>이름</td>
			<td>
				<input name="id" value=<%=user_id %>>
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
				<input type="button" value="작성" onclick="javascript:check()">&nbsp;
				<input type="button" value="목록" onclick="location.href='questionlist.jsp'">
			</td>
		</tr>
		
	</table>
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>