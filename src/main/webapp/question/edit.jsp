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
<style>
/* body 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* header 스타일 */
header {
    background-color: #333;
    color: #fff;
    padding: 10px 0;
    text-align: center;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-spacing: 20px;
    margin: 20px 0;
}

/* 입력 필드 스타일 */
input[type="text"], input[type="file"], textarea {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* 버튼 스타일 */
input[type="button"] {
    padding: 10px 20px;
    margin: 10px 5px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="button"]:hover {
    background-color: #444;
}

</style>
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#btnUpOk").onclick = function() {
		if(confirm("정말 수정할까요?")){
			qfrm.submit();
			return;
		}
	}
}

</script>
</head>
<body>
<jsp:include page="../user/header_user.jsp"></jsp:include>
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
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>