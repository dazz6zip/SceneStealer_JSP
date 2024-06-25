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
<style>
/* 테이블 스타일 */
#notice-table {
    width: 80%;
    margin: 20px auto;
    border-spacing: 0;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    overflow: hidden;
}

#notice-table th, #notice-table td {
    padding: 15px;
   text-align: center;
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

#notice-table th {
	
    background-color: #333;
    color: white;
}

#notice-table td img {
    max-width: 100%;
    height: auto;
    border-radius: 10px;
}

/* 링크 스타일 */
#notice-links {
    text-align: center;
    margin: 20px 0;
}

#notice-links a {
    display: inline-block;
    padding: 10px 20px;
    background-color: #000;
    color: white;
    text-decoration: none;
    border-radius: 20px;
    transition: background-color 0.3s ease;
}

#notice-links a:hover {
    background-color: #444;
}

textarea {
	border: none;
}
</style>
<script type="text/javascript" src="../js/reviewedit.js"></script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<table id="notice-table">
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
        	<td colspan="3"><img src="../upload/<%=pic %>"></td>
        </tr>
        <tr>
        	<td colspan="3">
        		<textarea rows="10" style="width: 99%" readonly><%=content %></textarea>
        	</td>
        </tr>
    </tbody>
</table>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>