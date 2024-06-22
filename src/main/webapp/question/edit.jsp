<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />

<%
String num = request.getParameter("num");

String spage = request.getParameter("page");

qdto = qmgr.getData2(num); //수정할 자료 읽기

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 수정 페이지</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#btnUpOk").onclick = function() {
		//alert("a");
		if(confirm("정말 수정할까요?")){
			qfrm.submit();
			return;
		}
	}
}

</script>
</head>
<body>
	<h2>질문 글 수정 부분</h2>
	<form action="editsave.jsp" method="post" name="qfrm">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="page" value="<%=spage %>">
	
	<table>
		<tr>
		<td>이름</td>
			<td>
				<input type="text" name="user" value="<%=qdto.getUser() %>">
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text"  name="title" value="<%=qdto.getTitle() %>" ></td>
		</tr>
		<tr>
			<td>사진</td>
			<td><input type="file" name="pic" size="30"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="contents" cols="50" rows="10"><%=qdto.getContents() %></textarea></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="수정완료" id="btnUpOk">&nbsp;&nbsp;
				<input type="button" value="목록보기" onclick="location.href='questionlist.jsp?page=<%=spage %>'">
			</td>
		</tr>
		
	</table>
	</form>
	
</body>
</html>