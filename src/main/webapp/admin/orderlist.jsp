<%@page import="pack.orders.Order_productDto"%>
<%@page import="pack.orders.OrdersInfoDto"%>
<%@page import="pack.orders.OrdersDto"%>
<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.orders.OrdersMgr" />
<%
// 부모 list: 주문목록(olist), 자식 list: 각각의 주문에서 주문한 상품목록(plist)

// 이 파일에 접근 방법은 두 가지
// 1. 상단메뉴 클릭해서 <전체 주문 목록> 보기
// 2. 질문글에서 유저 아이디 클릭해서 <해당 유저의 주문 목록> 보기

// 두 가지 방법에 따라 목록을 가져오는 메소드와 해당 페이지의 제목을 다르게 설정
// 주문목록은 olist, 각각의 주문에서 주문한 상품목록은 plist가 받음

request.setCharacterEncoding("utf-8");
// 페이징 처리
int spage = 1;
int totalPage = 0;
try{
	spage= Integer.parseInt(request.getParameter("page"));
}catch(Exception e){
	spage=1;
}

String user = request.getParameter("user"); // 1번 방법으로 접근 시 null, 2번 방법으로 접근 시 user_id
ArrayList<OrdersInfoDto> olist; // 목록
String top_element; // 페이지 제목
String formName; // for문에서 반복해서 생성되는 form태그의 이름을 다르게 설정하여 구분해야 select옵션 처리 가능

if(user==null){
	totalPage = orderMgr.getTotalPage();
	olist = orderMgr.getOrderAll(spage);
	top_element = "<h2>전체 주문 목록</h2>";
} else {
	totalPage = orderMgr.getTotalPage(user); // 전체 페이지 수 얻기
	olist = orderMgr.getUserOrder(user, spage);
	top_element = "<h2>" + user + "의 주문 목록</h2>";
	top_element += "<button onclick='history.back()'>뒤로 가기</button>";
	// Q&A 상세보기에서 유저 클릭하여 넘어왔을 때는, 뒤로 가기 버튼으로 다시 해당 글로 갈 수 있어야 함
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>
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

    button {
        background-color: #ff69b4;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #ff1493;
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
        font-size: 12pt;
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
    
    .userInfo {
    	text-align: left;
    }
</style>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<%=top_element %>
<%
if(olist.size()==0){
%>
	<b>주문 내역이 없습니다.</b>
<% 	
}else{
%>	
<table style="width: 90%">
	<tr style="background-color: lavender;">
		<th>주문번호</th><th>주문자 정보</th><th>주문내역</th><th>주문상태</th>
	</tr>
	<% 
	for(OrdersInfoDto oi : olist){
		formName = "frm" + oi.getOrders();
	%>
	<tr>
		<td><b><%=oi.getOrders() %></b></td>
		<td class="userInfo">
			ID: <b><%=oi.getId()%></b><br>
			NAME: <b><%=oi.getName()%></b><br>
			EMAIL: <b><%=oi.getEmail()%></b><br>
			ADDRESS: <b><%=oi.getAddress()%></b><br>
		</td>
		<td>
			<table style="width: 100%">
				<tr style="background-color: lavenderblush;">
					<th>상품명</th><th>주문수량</th>
				</tr>
			<%
			ArrayList<Order_productDto> plist = orderMgr.getOrder(oi.getOrders());
			for(Order_productDto op : plist){			
			%>
				<tr>
					<td><%=op.getName() %></td>
					<td><%=op.getQuantity() %></td>
				</tr>
			<%
			}	
			%>
			</table>
		</td>
		<td style="text-align: center">
		<form action="orderupdate.jsp" name="<%=formName %>" method="post">
			<input type="hidden" name="num" value="<%=oi.getOrders() %>">
			<input type="hidden" name="user" value="<%=oi.getId() %>">
			<select name="state" id="selectedstate">
    			<option value="결제완료">결제완료</option>
    			<option value="배송준비중">배송준비중</option>
    			<option value="배송중">배송중</option>
    			<option value="배송완료">배송완료</option>
    			<option value="취소처리중">취소처리중</option>
    			<option value="취소완료">취소완료</option>
			</select>
			<script type="text/javascript">
    			// 현재 주문 상태와 일치하는 옵션을 선택 상태로 설정
    			document.<%=formName %>.state.value = '<%=oi.getState() %>';

    			// '취소완료' 상태일 경우 select 태그를 비활성화
   				if (document.<%=formName %>.state.value === "취소완료") {
        			document.<%=formName %>.state.disabled = true;
    			}
			</script>
			<input type="submit" value="주문상태 수정">
		</form>
		</td>
	</tr>
	<tr>
		<td colspan="4"><hr></td>
	</tr>
<%
	}
}
%>
</table>	


<table>
	<tr>
	<td style="text-align: center;">
	<%
	for(int i=1; i <= totalPage; i++){
		if(i==spage){ //선택페이지 굵은 빨강으로
			out.print("<b style='font-size:12pt;color:red'>[" +i + "]</b>");
		}else{ //선택되지 않은 페이지
			out.print("<a href='orderlist.jsp?page=" +i + "'>[" +i + "]</a>");	
		}	
	}
	%>
	</td>
	</tr>
</table>
</body>
</html>