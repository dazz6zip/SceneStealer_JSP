<%@page import="java.text.DecimalFormat"%>
<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="productMgr" class="pack.product.ProductMgr_u" />
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("#,###");
String name = request.getParameter("name");
String id = (String) session.getAttribute("idKey");
boolean ro = false;
if (id != null) {
	ro = productMgr.orderReview(name, id);
}
ProductDto dto = productMgr.getProduct(name);
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
	size: 80%
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

/* 리뷰 테이블 스타일 */
table.review-table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
	margin: 20px 0;
}

table.review-table th, table.review-table td {
	padding: 10px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

table.review-table th {
	background-color: #333;
	color: white;
}

table.review-table tr:hover {
	background-color: #f1f1f1;
}

table.review-table td a {
	color: #007BFF;
	text-decoration: none;
}

table.review-table td a:hover {
	text-decoration: underline;
}
</style>
<script type="text/javascript" src="../js/reviewedit.js"></script>
<script type="text/javascript">
	function addToCart() {
		document.cartFrm.submit();
	}
</script>
</head>
<body>
	<jsp:include page="../shop/header_shop.jsp"></jsp:include>
	<form action="../order/cartproc.jsp" name="cartFrm">
		<table>
			<tr>
				<td style="width: 30%; text-align: center;" >
					<img src="../upload/product/<%=dto.getPic()%>" width="300" />
				</td>
				<td style="width: 50%; vertical-align: top">
					<table style="width: 100%">
						<tr>
							<td><b><%=dto.getName()%></b></td>
						</tr>
						<tr>
							<td><%=df.format(dto.getPrice())%>원</td>
						</tr>

						<tr>
							<td>주문수량 : <input type="number" min="1" value="1"
								name="quantity" style="text-align: center; width: 3cm">
							</td>
						</tr>
					</table>
				</td>
				<td style="vertical-align: top;">

					<h2>상품 설명</h2> <%=dto.getContents()%>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center;"><br> <input
					type="hidden" name="name" value="<%=dto.getName()%>"> <input
					type="button" value="장바구니에 담기" onclick="addToCart()"> <input
					type="button" value="이전 페이지" onclick="history.back()"> <%
 if (ro) {
 %> <input type="button" id="reviewBtn" value="리뷰 등록"
					onclick="location.href='reviewinsert.jsp?pro=<%=dto.getName()%>'">
					<%
					}
					%></td>
			</tr>
			<table>
				<tr>
					<th>닉네임</th>
					<th>상품</th>
					<th>내용</th>
					<th>이미지</th>
					<th>날짜</th>
					<%
					ArrayList<ReviewDto> rlist = reviewMgr.reviewAll(name);
					if (rlist.size() == 0) {
					%>
				
				<tr>
					<td colspan="6" style="text-align: center;">등록된 리뷰가 없습니다.</td>
				</tr>
				<%
				} else {
				for (ReviewDto r : rlist) {
				%>
				<tr style="text-align: center;">
					<td><%=r.getUser()%></td>
					<td><%=r.getProduct()%></td>
					<td><a href="javascript:reviewDetail('<%=r.getNum()%>')"><%=r.getContents()%></a></td>
					<td><%=r.getPic()%></td>
					<td><%=r.getDate()%></td>
					<%
					}
					}
					%>
				</tr>

			</table>
		</table>

	</form>
	<form action="../my/reviewdetail.jsp" name="detailFrm">
		<input type="hidden" name="review_num" />
	</form>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>