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
int spage = 1, pageSu = 0;
int start, end;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/reviewedit.js"></script>

<script type="text/javascript">
	// 특정 카테고리를 클릭하면 해당 카테고리에 대한 제품 목록을 볼 수 있는 페이지로 자동으로 이동함
	function showCategory(category) {
		window.location.href = 'productlist.jsp?category=' + category;
	}
</script>


</head>
<body>
	<h1>*SS쇼핑*</h1>

	<table>
		<tr style="text-align: center;">
			<!--  클릭하면 함수가 호출됨 -->
			<td><a href="javascript:showCategory('all')">전체 상품</a></td>
			<td><a href="javascript:showCategory('category1')">상의</a></td>
			<td><a href="javascript:showCategory('category10')">하의</a></td>
			<td><a href="javascript:showCategory('category19')">신발</a></td>
			<td><a href="javascript:showCategory('category9')">기타</a></td>

			<td colspan="4" style="text-align: right;"><script
					type="text/javascript">
				function sortBy(option) {
					document.getElementById('sortForm').submit();
				}
			</script>

				<form action="productlist.jsp" method="get" id="sortForm">
					<!--  value가 get방식으로 호출됨 -->
					<select name="sort" onchange="sortBy(this.value)">
						<option value="0">정렬순서</option>
						<option value="1">높은 가격 순</option>
						<option value="2">낮은 가격 순</option>
						<option value="3">판매 순</option>
						<option value="4">최신 순</option>
					</select>
				</form></td>
		</tr>
		<tr>
			<th>상품명</th>
			<th>가격</th>
			<th>재고량</th>
			<th>상세보기</th>
			<th>등록날짜</th>
		</tr>


		<%
		try {
			spage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			spage = 1;
		}
		if(spage <= 0 ){
			spage = 1;
		}
		String category = request.getParameter("category"); // 카테고리 파라미터 가져오기
		String price = request.getParameter("price");

		ArrayList<ProductDto> plist = new ArrayList<>();
		if (category == null || category.equals("all")) {
			plist = productMgr.getProductAll(spage); // 전체 상품 목록 가져오기
		} else {
			plist = productMgr.getProductAll(spage,category); // 카테고리별 제품 가져오기
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

		for (ProductDto p : plist) {
		%>
		<tr style="text-align: center;">
			<td><img src="../upload/<%=p.getPic()%>" width="150" /> <%=p.getName()%>
			</td>
			<td><%=p.getPrice()%></td>
			<td><%=p.getStock()%></td>


			<td><a href="javascript:productDetail_guest('<%=p.getName()%>')">보기</a></td>
			<td><%=p.getDate()%></td>
		</tr>
		<%
		}
		%>
		<%
		
		productMgr.totalList(); //전체 레코드 수계산
		pageSu = productMgr.getPageSu(); //페이지수 받기
		if(category != null){
			
		}
		%>
		<table style="width: 100%">
				<tr>
					<td style="text-align: center;">
		<%
		
		for (int i = 1; i <= pageSu; i++) {
		    if (i == spage) {
		        out.print("<b style='font-size:15pt; color:red'>[" + i + "]</b>");
		    } else {
		        String queryString = "";
		        if (category != null) {
		            queryString += "&category=" + category;
		        }
		        if (sort != null) {
		            queryString += "&sort=" + sort;
		        }
		        out.print("<a href='productlist.jsp?page=" + i + queryString + "'>[" + i + "]</a>");
		    }
		}

		%>
		</td>
		</tr>
		
		</table>
	</table>
	<br>


	<form action="productdetail_g.jsp" name="detailFrm">
		<input type="hidden" name="no" />
	</form>
</body>
</html>
