<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr" />
<!-- 입력자료 검사 없이, 바로 진행 후 오류 발생하므로 관리자가 알아서 잘 하길 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<script type="text/javascript">
function nameCheck(){
	if(productForm.productName.value === ""){
		confirm("상품 이름을 해주세요?")
	}else{
		url = "productnamecheck.jsp?name=" + productForm.productName.value;
		window.open(url,"id","width=550,height=300,top=200,left=100");
	}
}
</script>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<form name="productForm" action="productproc.jsp?flag=insert" method="post"  enctype="multipart/form-data">

<table>

<tr>
		<td colspan="2">**상품 등록**</td>
		
	</tr>
	<tr>
		<td>상품명</td>
		<td><input type="text" name="name" id="productName"><input type="button" value="중복확인" onclick="nameCheck()"></td>
		
		
	</tr>
	<tr>
		<td>가 격</td>
		<td><input type="text" name="price"></td>
	</tr>
	<tr>
		<td>상품 설명</td>
		<td><textarea rows="5" style="width: 99%" name="contents"></textarea></td>
	</tr>
	<tr>
		<td>재고량</td>
		<td><input type="text" name="stock"></td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
		<select name="category">
			<option value="상의">상의</option>
			<option value="하의">하의</option>
			<option value="신발">신발</option>
			<option value="잡화" selected="selected">잡화</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>이미지</td>
		<td><input type="file" name="pic" size="30"></td>
	</tr>
	<tr>
		<td colspan="2">
			<br><br><br><br>
			<input type="submit" value="상품 등록">
			<input type="reset" value="새로 입력">
		</td>
	<tr>
</table>
</form>

</body>
</html>