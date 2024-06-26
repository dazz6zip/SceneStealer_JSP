<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	if(qfrm.title.value ==""){
		alert("제목을 입력해 주세요.");
		qfrm.title.focus();
	}else if(qfrm.contents.value ==""){
		alert("내용을 입력해 주세요.");
		qfrm.contents.focus();
	}else {
		qfrm.submit();
	}
}
</script>
<%
String user_id = (String)session.getAttribute("idKey");
%>
<style>

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

/* 텍스트 스타일 */
td {
    vertical-align: top;
    padding: 10px;
}

td h2 {
    margin-top: 0;
}

td p {
    margin: 10px 0;
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
input[type="button"], input[type="submit"], input[type="reset"] {
    padding: 10px 20px;
    margin: 10px 5px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="button"]:hover, input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #444;
}
</style>
</head>
<body>
<jsp:include page="../user/header_user.jsp"></jsp:include>
<form name="qfrm" method="post" action="questionsave.jsp?flag=insert" enctype="multipart/form-data">
<table>
    <tr>
        <td>이름</td>
        <td><input type="hidden" name="id" value="<%=user_id %>"><%=user_id %></td>
    </tr>
    <tr>
        <td>제목</td>
        <td><input name="title" size="15"></td>
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
        <td colspan="2" style="text-align: center;">
            <input type="button" value="메인" onclick="location.href='../guest_index.jsp';">
            <input type="button" value="작성" onclick="javascript:check()">
            <input type="button" value="목록" onclick="location.href='questionlist.jsp'">
        </td>
    </tr>
</table>
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>