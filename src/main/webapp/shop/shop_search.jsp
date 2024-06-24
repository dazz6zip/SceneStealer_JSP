<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.product.ProductMgr_u"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.product.ProductDto"></jsp:useBean>
<%
String searchword = request.getParameter("searchword");
ArrayList<ProductDto> plist = mgr.productSeacrh(searchword.replaceAll(" ", ""));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
</head>
<body>
<script type="text/javascript" src="../js/order.js"></script>
<jsp:include page="header_shop.jsp">
<jsp:param value="<%= searchword %>" name="val"/>
</jsp:include>

<%
if (plist != null && !plist.isEmpty()) {
%>
<table>
	<tr>
	<%
	for (int i = 0; i < plist.size(); i++) {
		if (i > 0 && i % 4 == 0) {
			%></tr><tr><%
		}
		pdto = plist.get(i);
	%>
		<td>
			<table onclick="javascript:searchProductClick('<%= pdto.getName() %>')">
				<tr>
					<td><%= pdto.getPic() %></td>
				</tr>
				<tr>
					<td><%= pdto.getName() %></td>
				</tr>
				<tr>
					<td><%= pdto.getPrice()%></td>
				</tr>
			</table>
		</td>
	<%
	}
%>
	</tr>
</table>
<%
} else {
	%>
	<table>
		<tr>
			<td>검색 결과가 없습니다!</td>
		</tr>
	</table>
	<%
}
%>
<jsp:include page="../footer.jsp"></jsp:include>
<form action="productdetail_g.jsp" name="spcFrm" method="post">
<input type="hidden" name="name">
</form>
</body>
</html>