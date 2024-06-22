<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="csmgr" class="pack.orders.CartSessionMgr" scope="session"/>
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />
<jsp:setProperty property="*" name="opdto"/>
<jsp:useBean id="odto" class="pack.orders.OrdersDto"></jsp:useBean>

<% 
request.setCharacterEncoding("utf-8");
String flag = request.getParameter("flag");
// 구매 목록을 보기위한 변수 설정 : 보기, 수정, 삭제 판단용 변수

String id = (String)session.getAttribute("idKey");

// 로그인을 해야지 들어갈수 있게 함
// System.out.print(orders);
if(id == null){ //로그인을 안했다면 로그인페이지로 가세요
    response.sendRedirect("../user/loginForm.jsp");
} else {
  
        if (flag == null) {
        	
            csmgr.addCart(opdto);
%>
            <script>
                alert("장바구니에 담았습니다");
                location.href="cartlist.jsp"; // cart에 등록된 주문 상품 목록 보기
            </script>
<%
        } else if (flag.equals("update")) {
           
            csmgr.updateCart(opdto);
%>
            <script>
                alert("장바구니의 내용을 수정했습니다.");
                location.href="cartlist.jsp"; // cart에 등록된 주문 상품 목록 보기
            </script>
<%
        } else if (flag.equals("del")) {
            csmgr.deleteCart(opdto);
%>
            <script>
                alert("해당 상품의 주문을 삭제했습니다.");
                location.href="cartlist.jsp"; // cart에 등록된 주문 상품 목록 보기
            </script>
<%
        }
    }

%>
