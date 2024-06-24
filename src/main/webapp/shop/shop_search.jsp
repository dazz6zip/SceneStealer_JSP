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

/* 이미지 스타일 */
img {
    max-width: 150px;
    height: auto;
    transition: transform 0.3s ease;
}

img:hover {
    transform: scale(1.1);
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

/* 검색 결과 테이블 스타일 */
table.search-results {
    width: 100%;
    border-spacing: 0;
    border-collapse: collapse;
    margin: 20px 0;
}

table.search-results th, table.search-results td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

table.search-results th {
    background-color: #333;
    color: white;
}

table.search-results tr:hover {
    background-color: #f1f1f1;
}

table.search-results td a {
    color: #007BFF;
    text-decoration: none;
}

table.search-results td a:hover {
    text-decoration: underline;
}

/* 검색 결과 없을 때 스타일 */
.no-results {
    text-align: center;
    padding: 20px;
    font-size: 18px;
    color: #666;
}
</style>
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
					<td><img src="../upload/product/<%= pdto.getPic() %>"></td>
				</tr>
				<tr>
					<td><%= pdto.getName() %></td>
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