<%@page import="java.text.DecimalFormat"%>
<%@page import="pack.review.ReviewMgr"%>
<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.Comparator"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="productMgr" class="pack.product.ProductMgr_u" />
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>

<%
DecimalFormat df = new DecimalFormat("#,###");
int spage = 1, pageSu = 0;
int start, end;

try {
	spage = Integer.parseInt(request.getParameter("page"));
} catch (Exception e) {
	spage = 1;
}
if (spage <= 0) {
	spage = 1;
}
String category = request.getParameter("category"); // 카테고리 파라미터 가져오기
if (category == null) {
	category = "all";
}

String price = request.getParameter("price");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<style>
#paging {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}

#paging b {
	color: black;
	font-weight: bold;
	margin: 0 5px;
}

#paging a {
	color: gray;
	margin: 0 5px;
	text-decoration: none;
}

#paging a:hover {
	color: black;
}

/* body 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.product-card {
	background: #fff;
	padding: 15px;
	margin: 10px;
	text-align: center;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	width: 200px; /* 고정 너비 */
	height: 300px; /* 고정 높이 */
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.product-card .image-container {
	width: 100%;
	height: 200px; /* 이미지 영역 고정 높이 */
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden; /* 이미지가 영역을 벗어나지 않도록 설정 */
}

.product-card img {
	width: 100%;
	height: 100%;
	object-fit: contain; /* 이미지 비율 유지 및 잘리지 않게 설정 */
	transition: transform 0.3s ease;
}

.product-card img:hover {
	transform: scale(1.1);
}

.product-card p {
	margin: 10px 0;
}

.product-card a {
	display: block;
	margin: 10px 0;
	color: #333;
	text-decoration: none;
}

.product-card a:hover {
	color: #007BFF;
}

form#sortForm {
	display: flex;
	justify-content: flex-end;
	margin: 20px;
}

form#sortForm select {
	padding: 5px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

table {
	width: 100%;
	border-spacing: 30px;
}

#categorytable th {
	background-color: black;
	color: white;
	border-radius: 80px;
	padding: 10px;
	width: 15%
}

#categorytable a {
	display: block;
	margin: 10px 0;
	color: white;
	text-decoration: none;
}

#categorytable a:hover {
	font-size: 110%;
}
</style>
<script type="text/javascript" src="../js/reviewedit.js"></script>
<script type="text/javascript">
	// 특정 카테고리를 클릭하면 해당 카테고리에 대한 제품 목록을 볼 수 있는 페이지로 자동으로 이동함
	function showCategory(category) {
		window.location.href = 'productlist.jsp?category=' + category;
	}

	function sortBy(option) {
		document.getElementById('sortForm').submit();
	}
</script>
</head>
<body>
	<jsp:include page="header_shop.jsp"></jsp:include>

	<form action="productlist.jsp" method="get" id="sortForm">
		<!--  value가 get방식으로 호출됨 -->
		<input type="hidden" name="category" value="<%=category%>"> 
		<select name="sort" onchange="sortBy(this.value)">
			<option value="0">정렬순서</option>
			<option value="1">높은 가격 순</option>
			<option value="2">낮은 가격 순</option>
			<option value="3">판매 순</option>
			<option value="4">최신 순</option>
		</select>
	</form>
	<table id="categorytable">
		<tr style="text-align: center;">
			<!--  클릭하면 함수가 호출됨 -->
			<th><a href="javascript:showCategory('all')">ALL</a></th>
			<th><a href="javascript:showCategory('상의')">TOP</a></th>
			<th><a href="javascript:showCategory('하의')">BOTTOM</a></th>
			<th><a href="javascript:showCategory('신발')">SHOES</a></th>
			<th><a href="javascript:showCategory('잡화')">ETC</a></th>
		</tr>
		<%
		ArrayList<ProductDto> plist = new ArrayList<>();
		if (category == null || category.equals("all")) {
			plist = productMgr.getProductAll(spage); // 전체 상품 목록 가져오기
		} else {
			plist = productMgr.getProductAll(spage, category); // 카테고리별 제품 가져오기
		}

		String sort = request.getParameter("sort");
		// Comparator라는 인터페이스는 객체 정렬때 이용가능 comparin은 람다식or메서드 참조를 인자로받아 해당키 추출
		//reversed 정렬순서를 역순으로 바꿈
		if (sort != null) {
			switch (sort) {
			case "1":
				plist.sort(Comparator.comparing(ProductDto::getPrice).reversed());
				break;
			case "2":
				plist.sort(Comparator.comparing(ProductDto::getPrice));
				break;
			case "3":
				plist.sort(Comparator.comparing(ProductDto::getCount).reversed());
				break;
			case "4":
				plist.sort(Comparator.comparing(ProductDto::getDate).reversed());
				break;
			default:

				break;
			}
		}
		int count = 0;
		for (ProductDto p : plist) {
			if (count % 5 == 0 && count != 0) {
		%>
		<tr>
			<%
			}
			%>
			<td style="text-align: center;">
				<div class="product-card">
					<a href="javascript:productDetail_guest('<%=p.getName()%>')" class="product-link">
						<div class="image-container">
							<img src="../upload/product/<%=p.getPic()%>" />
						</div>
					</a>
					<p><%=p.getName()%></p>
					<p><%=df.format(p.getPrice())%>원</p>
				</div>
			</td>
			<%
			count++;
			}
			if (count % 5 != 0) {
			%>
		</tr>
		<%
		}
		%>
	</table>

	<%
	if (category != null && !category.equals("all")) {
	    productMgr.totalcList(category);
	    pageSu = productMgr.getcPageSu();
	} else if (category == null || category.equals("all")) {
	    productMgr.totalList(); // 전체 레코드 수계산
	    pageSu = productMgr.getPageSu(); // 페이지수 받기
	}
	%>
	
	<div id="paging">
		<%
	    for (int i = 1; i <= pageSu; i++) {
	   
	    if (i == spage) {
	        out.print("<b>" + i + "</b>");
	    } else {
	        String queryString = "";
	        if (category != null) {
	            queryString += "&category=" + category;
	        }
	        if (sort != null) {
	            queryString += "&sort=" + sort;
	        }
	        if (category != null && sort != null) {
	            queryString += "&category=" + category + "&sort=" + sort;
	        }
	        out.print("<a href='productlist.jsp?page=" + i + queryString + "'>" + i + "</a>");
	    }
	    }
	    %>
	</div>

	<form action="productdetail_g.jsp" name="detailFrm">
		<input type="hidden" name="name" />
	</form>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>