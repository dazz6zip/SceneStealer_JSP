<%@page import="java.util.ArrayList"%>
<%@page import="pack.review.ReviewDto"%>
<%@page import="pack.review.ReviewMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<jsp:useBean id="reviewDto" class="pack.review.ReviewDto" scope="page"/>

<%
String num = request.getParameter("review_num");

ReviewDto reviewList = reviewMgr.getDetailReview(num);

//System.out.println(num); 
String id = reviewList.getUser();
String product = reviewList.getProduct();
String content = reviewList.getContents();
String pic = reviewList.getPic();
String date = reviewList.getDate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 보기</title>
<script type="text/javascript" src="../js/reviewedit.js"></script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<h2>리뷰 상세 보기</h2>

<table>
    <thead>
        <tr style="text-align: center;">
            <th>사용자</th>
            <th>상품</th>
            <th>날짜</th>
        </tr>
    </thead>
    <tbody>
        <tr style="text-align: center;">
            <td><%=id %></td>
            <td><%=product %></td>
            <td><%=date %></td>
        </tr>
        <tr style="text-align: center;">
        	<td colspan="3"><%=pic %></td>
        </tr>
        <tr>
        	<td colspan="3">
        		<textarea rows="10" style="width: 99%" readonly><%=content %></textarea>
        	</td>
        </tr>
    </tbody>
</table>
<hr>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>