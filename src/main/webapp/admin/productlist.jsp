<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pack.admin.AdminMgr"%>
<%@page import="pack.product.ProductDto"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<jsp:useBean id="dto" class="pack.product.ProductDto"></jsp:useBean>

<%
int spage = 1, pageSu = 0;

%>
<!DOCTYPE html>
<html>
<head>
<title>상품관리</title>
<script type="text/javascript" src="../js/productedit.js"></script>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<h2>상품 관리</h2>
<table style="width: 90%">
	<tr style="background-color: silver;">
	
			<th>상품명</th><th>가격</th><th>등록일</th><th>재고량</th><th>횟수</th><th>카테고리</th><th>상세보기</th>
		
		<%
		ArrayList<ProductDto> plist = productMgr.getProductAll();
		
		if(plist.size() == 0){
		%>
		<tr>
			<td colspan="6">등록된 상품이 없습니다</td>
		</tr>
		<% 
		}else{
			for(ProductDto p:plist){
		%>
		<tr style="text-align: center;">
			<td><%=p.getName()%></td>
			<td><%=p.getPrice() %></td>
			<td><%=p.getDate() %></td>
			<td><%=p.getStock() %></td>
			<td><%=p.getCount() %></td>
			<td><%=p.getCategory() %></td>
			<td>
				<a href="javascript:productDetail('<%=p.getName() %>')"><%=p.getName() %></a>
			</td>
			
		</tr>
		<% 
			}
		}
			
		%>
	
	<tr>
		<td colspan="6">
			[<a href="productinsert.jsp">상품 등록</a>]
		</td>
	</tr>
</table>


<form action="productdetail.jsp" id="detailForm" name="detailForm" method="get">
<input type="hidden" name="str">

</form>
</body>
</html>

