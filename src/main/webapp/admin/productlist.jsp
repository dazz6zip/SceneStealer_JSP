<%@page import="pack.product.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pack.admin.AdminMgr"%>
<%@page import="pack.product.ProductDto"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<jsp:useBean id="dto" class="pack.product.ProductDto"></jsp:useBean>

<%
int spage = 1, pageSu = 0; //spage: 현재 페이지 번호를 저장. 기본값은 1
int start, end;   //pageSu: 전체 페이지 수를 저장

try {   //URL 파라미터에서 page 값을 가져와서 현재 페이지 번호를 설정합니다. 잘못된 값이 입력되면 기본값 1을 사용
    spage = Integer.parseInt(request.getParameter("page"));
} catch (Exception e) {
    spage = 1;
}
if (spage <= 0) spage = 1;

productMgr.totalList(); // 전체 레코드 수 계산
pageSu = productMgr.getPageSu(); // 전체 페이지 수 받기

ArrayList<ProductDto> plist = productMgr.getProductAll(spage); 
//현재 페이지에 해당하는 상품 목록을 가져옵니다.

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/productedit.js"></script>
<script type="text/javascript">
function productDetail(ss){
    document.detailForm.str.value = ss;
    document.detailForm.submit();
}
</script>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        color: #333;
        text-align: center;
        margin: 0;
        padding: 0;
    }

    h2 {
        color: #ff69b4;
        margin: 20px 0;
    }

    a {
        color: #ff69b4;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    table {
        width: 90%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #ff69b4;
        color: white;
    }

    td {
        background-color: #fff;
    }

    .pagination {
        width: 100%;
        text-align: center;
        margin: 20px 0;
    }

    .pagination b {
        font-size: 15pt;
        color: red;
    }

    .pagination a {
        color: #ff69b4;
        text-decoration: none;
        margin: 0 5px;
    }

    .pagination a:hover {
        text-decoration: underline;
    }
    
      input[type="button"] {
        background-color: #ff69b4;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="button"]:hover {
        background-color: #ff1493;
    }
</style>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<h2>전체 상품 목록</h2>
<table>
    <tr>
        <th>상품명</th>
        <th>가격</th>
        <th>등록일</th>
        <th>재고량</th>
        <th>카테고리</th>
    </tr>
    <%
    if (plist.size() == 0) {
    %>
    <tr>
        <td colspan="7">등록된 상품이 없습니다</td>
    </tr>
    <%
    } else {
        for (ProductDto p : plist) {
    %>
    <tr>
        <td><a href="javascript:productDetail('<%= p.getName() %>')"><%= p.getName() %></a></td>
        <td><%= p.getPrice() %></td>
        <td><%= p.getDate() %></td>
        <td><%= p.getStock() %></td>
        <td><%= p.getCategory() %></td>
    </tr>
    <%
        }
    }
    %>
</table>
<input type="button" value="상품 등록" onclick="location.href='productinsert.jsp'">
<div class="pagination">
    <%
    for (int i = 1; i <= pageSu; i++) {
        if (i == spage) {
            out.print("<b>" + i + "</b>");
        } else {
            out.print("<a href='productlist.jsp?page=" + i + "'>" + i + "</a>");
        }
    }
    %>
</div>

<form action="productdetail.jsp" id="detailForm" name="detailForm" method="get">
    <input type="hidden" name="str">
</form>
</body>
</html>