<%@page import="pack.product.ProductMgr_u"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr" />
<%
request.setCharacterEncoding("utf-8");

//controller 역할
String flag = request.getParameter("flag");
boolean result = false;
if(flag.equals("insert")){
	result = reviewMgr.insertProduct(request);
}else if(flag.equals("update")){ 
	result = reviewMgr.updateProduct(request);  
}else{
	response.sendRedirect("productdetail_g.jsp");
}
if(result){
%>
 <script>
 	alert("정상 처리되었습니다.");
 	location.href="../my/reviewlist.jsp";
 </script>	
<% }else{%>
	<script>
		alert("처리 실패되었습니다.");
 		location.href="../my/reviewlist.jsp";
	</script>
<% 	
}
%>
