<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
    <%
    String str = request.getParameter("str"); 
    ProductDto dto = productMgr.getProduct(str);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<script type="text/javascript" src="../js/productedit.js"></script>
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

    input[type="submit"], input[type="button"] {
        background-color: #ff69b4;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    input[type="submit"]:hover, input[type="button"]:hover {
        background-color: #ff1493;
    }

    form {
        display: inline-block;
    }

    .center {
        text-align: center;
    }

    .link {
        margin-top: 20px;
        display: inline-block;
    }
</style>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<h2>상품 상세 보기</h2>
<table>
    <tr>
        <td style="width: 20%">
            <img src="../upload/product/<%=dto.getPic()%>" width="150" />
        </td>
        <td style="vertical-align: top;">
            <table style="width: 100%">
                <tr>
                    <td><strong>상품명 :</strong></td>
                    <td><%=dto.getName() %></td>
                </tr>
                <tr>
                    <td><strong>가격 :</strong></td>
                    <td><%=dto.getPrice() %></td>
                </tr>
                <tr>
                    <td><strong>카테고리 :</strong></td>
                    <td><%=dto.getCategory() %></td>
                </tr>
                <tr>
                    <td><strong>상품설명 :</strong></td>
                    <td><%=dto.getContents() %></td>
                </tr>
                <tr>
                    <td><strong>재고량 :</strong></td>
                    <td><%=dto.getStock() %></td>
                </tr>
                <tr>
                    <td><strong>등록일 :</strong></td>
                    <td><%=dto.getDate() %></td>
                </tr>
            </table>
        </td>

    </tr>
    <tr>
        <td colspan="3" class="center">
         <form action="productstockupdate.jsp" method="post">
            <a href="javascript:productUpdate('<%=dto.getName() %>')">수정 하기</a>&nbsp;&nbsp;
                <input type="hidden" name="productName" value="<%=dto.getName() %>">
                <input type="submit" value="Sold Out">
             </form>
        </td>
    </tr>
</table>

<form action="productupdate.jsp" name="updateForm" method="post">
<input type="hidden" name="name">
</form>

<form action="productproc.jsp?flag=delete" name="delForm" method="post">
<input type="hidden" name="name">
</form>

<a href="productlist.jsp" class="link">상품 목록으로</a>

</body>
</html>