<%@page import="pack.product.ProductDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrderMgr"></jsp:useBean>
<jsp:useBean id="odto" class="pack.orders.OrdersDto"></jsp:useBean>
<jsp:useBean id="pdto" class="pack.product.ProductDto"></jsp:useBean>
<%

String id = (String)session.getAttribute("idKey");
if (id == null) {
	response.sendRedirect("../user/loginForm.jsp");
}
String stateabout = "";
int spage = 1; // 현재 페이지 번호, 기본값은 1
int pageSu = 0; // 전체 페이지 수

// URL 파라미터에서 page 값을 가져와 현재 페이지 번호 설정
try {   
    spage = Integer.parseInt(request.getParameter("page"));
} catch (Exception e) {
    spage = 1;
}

if (spage <= 0) spage = 1; 

ArrayList<OrdersDto> olist = orderMgr.getorders(id, spage); 
orderMgr.totalList(id); // 전체 레코드 수 계산
pageSu = orderMgr.getPageSu(); // 전체 페이지 수 계산

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
<style>


/* 테이블 스타일 */
table {
    width: 100%;
    border-spacing: 10px;
    margin-bottom: 20px;
    background-color: #fff;
}

th, td {
    padding: 10px;
    text-align: center;
    background-color: #fff;
    border: none;
}

th {
    background-color: #333;
    color: white;
    
}

td img {
    max-width: 100px;
    height: auto;
    border-radius: 10px;
}

/* 링크 스타일 */
a {
    color: #000; /* 검정색 글씨 */
    text-decoration: none; /* 밑줄 제거 */
}

/* 페이지네이션 스타일 */
#pagination {
    text-align: center;
    margin: 20px 0;
}

#pagination b {
    color: black;
    font-weight: bold;
    margin: 0 5px;
}

#pagination a {
    color: gray;
    margin: 0 5px;
    text-decoration: none;
}

#pagination a:hover {
    color: black;
}
</style>
<script type="text/javascript" src="../js/order.js"></script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<table>
	<tr>
		<th>주문번호</th>
		<th>이미지</th>
		<th>주문내역</th>
		<th>주문상태</th>
		<th>취소/환불/반품</th>
	</tr>
	<%
	for (int i = 0; i < olist.size(); i++) {
		odto = olist.get(i);
		pdto = orderMgr.getOPinfo(odto.getNum());
		%>
		<tr>
			<td><%= odto.getNum() %></td>
			<td><img src="..\\upload\\product\\<%= pdto.getPic() %>"></td>
			<td><a href="javascript:orderinfo('<%= odto.getNum() %>', '<%= odto.getState() %>')"><%= pdto.getName() %> 
			<% 
			int count = orderMgr.countprocess(odto.getNum());
			if (count > 1) {
				out.print("외 " + (count - 1) + "건");
			}
			%>
			</a></td>
			<td><%= odto.getState() %></td>
			<%
			if (odto.getState().equals("결제완료") || odto.getState().equals("배송준비중")) {
				stateabout = "<a href=\"javascript:orderDelete('" + odto.getNum() + "','" + pdto.getName() + "')\">취소 신청</a>";
			} else if (odto.getState().equals("배송중")) {			
				stateabout = "<a href=\"javascript:orderRefund('" + odto.getNum() + "','" + pdto.getName() + "')\">환불 신청</a>";
			} else if (odto.getState().equals("배송완료")) {
				stateabout = "<a href=\"javascript:orderReturn('" + odto.getNum() + "','" + pdto.getName() + "')\">반품 신청</a>";
			} else if (odto.getState().equals("취소완료")) {
				stateabout = "";
			}
			%>
			<td><%= stateabout %></td>
		</tr>
		<%
		}
	%>
</table>
<div id="pagination">
    <%
    for (int i = 1; i <= pageSu; i++) {
        if (i == spage) {
            out.print("<b>" + i + "</b>");
        } else {
            out.print("<a href='orderinfo.jsp?page=" + i + "'>" + i + "</a>");
        }
    }
    %>
</div>
<form action="orderinfodetail.jsp" method="post" name="orderFrm">
	<input type="hidden" name="orders_num">
	<input type="hidden" name="orders_state">
</form>
<form action="orderproc.jsp" method="post" name="orderflagFrm">
	<input type="hidden" name="flag">
	<input type="hidden" name="orders_num">
	<input type="hidden" name="product_name">
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>