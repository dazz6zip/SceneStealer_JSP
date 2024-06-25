<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<%
request.setCharacterEncoding("utf-8");
ProductDto dto = productMgr.getProduct(request.getParameter("name"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/productedit.js"></script> 
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        color: #333;
        text-align: center;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
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

.table-container {
    width: 100%; /* 부모 요소의 전체 너비를 차지하도록 설정 */
    display: flex;
    justify-content: center;
}

form {
    width: 60%; /* 폼의 전체 너비를 60%로 설정 (필요시 조정 가능) */
    display: inline-block;
}

table {
    width: 100%; /* 폼 내부에서 테이블이 전체 너비를 차지하도록 설정 */
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 10px; /* 패딩을 줄여서 테이블 높이를 줄임 */
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

input[type="text"], input[type="file"], textarea {
    width: 80%; /* 입력 필드의 너비를 줄여서 테이블 높이를 줄임 */
    padding: 8px; /* 패딩을 줄여서 입력 필드 높이를 줄임 */
    margin: 5px 0; /* 마진을 줄여서 공간을 줄임 */
    border: 1px solid #ddd;
    border-radius: 5px;
}

input[type="submit"], input[type="button"], input[type="reset"] {
    background-color: #ff69b4;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover, input[type="button"]:hover, input[type="reset"]:hover {
    background-color: #ff1493;
}

.product-image {
    max-width: 100%;
    height: auto;
    border-radius: 5px;
}
</style>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<h2>상품 수정하기</h2>
<div class="table-container">
    <form action="productproc.jsp?flag=update" name="ppfrm" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>상품명</td>
                <td><%=dto.getName()%></td>
            </tr>
            <tr>
                <td>가격</td>
                <td><input type="text" name="price" value="<%=dto.getPrice()%>"></td>
            </tr>
            <tr>
                <td>카테고리</td>
                <td>
                    <select name="category">
                        <option value="상의">상의</option>
                        <option value="하의">하의</option>
                        <option value="신발">신발</option>
                        <option value="잡화">잡화</option>
                    </select>
                    <script type="text/javascript">
                    document.ppfrm.category.value = "<%=dto.getCategory() %>";
                    </script>
                </td>
            </tr>
            <tr>
                <td>상품설명</td>
                <td><textarea rows="5" name="contents"><%=dto.getContents() %></textarea></td>
            </tr>
            <tr>
                <td>재고량</td>
                <td><input type="text" name="stock" value="<%=dto.getStock()%>"></td>
            </tr>
            <tr>
                <td>이미지</td>
                <td>
                    <img src="../upload/<%=dto.getPic()%>" class="product-image">
                    <input type="file" name="pic" size="30">
                </td>
            </tr>
            <tr>
                <td colspan="2" class="center">
                    <input type="hidden" name="name" value="<%=dto.getName()%>">
                    <input type="submit" value="상품 수정">
                    <input type="reset" value="수정 취소" onclick="history.back()">
                </td>
            </tr>
        </table>
    </form>
</div>
<a href="productlist.jsp" class="link">상품 목록으로</a>
</body>
</html>