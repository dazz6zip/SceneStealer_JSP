<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<%
request.setCharacterEncoding("utf-8");

//controller 역할
String flag = request.getParameter("flag");
boolean result = false;
if(flag.equals("insert")){
	result = productMgr.insertProduct(request);
}else if(flag.equals("update")){
	result = productMgr.updateProduct(request);  
}else if (flag.equals("delete")){ 
	result = productMgr.deleteProduct(request.getParameter("name"));
}else{
	response.sendRedirect("productlist.jsp");
}

if(result){
%>
 <script>
 	alert("정상 처리되었습니다.");
 	location.href="productlist.jsp";
 </script>	
<% 
} else {
	System.out.println("a");
%>
<script>
	alert("처리에 실패했습니다.");
 	location.href="productlist.jsp";
</script>
<% 	
}
%>
