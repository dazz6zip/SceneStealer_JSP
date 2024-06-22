<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <jsp:useBean id="productMgr" class="pack.product.ProductMgr_u" />
 <jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
 <%
 String name = request.getParameter("no");
 
 ProductDto dto = productMgr.getProduct(name);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 보기</title>


<script type="text/javascript" src="../js/reviewedit.js"></script>
<script type="text/javascript">
function addToCart() {
	if(!confirm("장바구니에 담겼습니다 계속 쇼핑하시겠습니까!")) {
		location.href = 'cart';   	   
	} else {
		location.href = '../order/cartproc.jsp';
	}
}
</script>
</head>
<body>
<h2>**상품 상세 페이지*</h2>
   
<form action="cartproc.jsp">
<table >
	<tr>
		<td style="width: 30%">
			<img src="../upload/<%=dto.getPic()%>" width="150" />
		</td>
		<td style="width: 50%;vertical-align: top">
			<table style="width: 100%">
				<tr><td>이름 : <%=dto.getName() %></td></tr>
				<tr><td>상품명 : <%=dto.getPrice() %></td></tr>
				<tr><td>가격 : <%=dto.getPrice() %></td></tr>
				
				<tr>
				<td>주문수량 :
					<input type="number" min="1" value="1" 
						name="quantity" 
						style="text-align: center; width: 3cm">
				</td>
				</tr>
			</table>
		</td>
		<td style="vertical-align: top;">
		
			<h2>상품 설명</h2>
			<%=dto.getContents() %>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center;">
			<br>
			<input type="hidden" name="product_no" value="<%=dto.getName()%>">
			<input type="button" value="장바구니에 담기" onclick="addToCart()">
			<input type="button" value="이전 페이지" onclick="history.back()">
				[<a href="reviewinsert.jsp?pro=<%= dto.getName() %>">리뷰 등록</a>]
		</td>
	</tr>
	<table>
    	<tr>
        <th>닉네임</th><th>상품</th><th>컨텐츠</th><th>내용</th><th>이미지</th>
        <%
        ArrayList<ReviewDto> rlist = reviewMgr.reviewAll(); 
        if(rlist.size() == 0){
    		%>
    		<tr>
    			<td colspan="6">등록된 리뷰가 없습니다</td>
    		</tr>
    		<% 
    		}else{
    			for(ReviewDto r:rlist){
    		%>
    		<tr style="text-align: center;">
    			<td><%=r.getUser()%></td>
    			<td><%=r.getProduct() %></td>
    			<td><%=r.getContents() %></td>
    			<td><%=r.getPic() %></td>
    			<td><%=r.getDate() %></td>
    			<%
    				}
    			}
    			%>
    </tr>
    
    </table>
</table>

</form>
<hr>


</body>
</html>