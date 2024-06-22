<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<%
request.setCharacterEncoding("utf-8");

String name =request.getParameter("name"); 
boolean b = productMgr.idCheckProcess(name);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 이름검사</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>

</head>
<body style="text-align: center; margin-top: 30px">
<b><%=name %></b>
<%
if(b){
%>
 	:이미 사용중인 상품입니다 다른거해~<p/>
 	<a href="#" onclick="opener.document.productForm.productName.focus(); window.close()">닫기</a>
 	

<% }else{%>
	: 사용가능합니다 <p/>
	<a href="#" onclick="opener.document.productForm.price.focus();window.close()">네</a>

<% 	
}

%>

</body>
</html>