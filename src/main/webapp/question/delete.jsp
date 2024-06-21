<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String num = request.getParameter("num");
String spage = request.getParameter("page");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 페이지 삭제</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
function check(){
	//alert("a");
	if(confirm("정말 삭제할까요?")){
		qfrm.submit();
	}
}
</script>
</head>
<body>
질문 글 삭제
<br>
<form action="deleteok.jsp" method="post" name="qfrm"> 
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="page" value="<%=spage %>">

<input type="button" onclick="check()" value="삭제 확인">

<input type="button" 
onclick="location.href='questionlist.jsp?page=<%=spage %>'" value="목록보기">

</form>
</body>
</html>