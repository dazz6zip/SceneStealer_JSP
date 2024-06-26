<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<jsp:useBean id="redto" class="pack.review.ReviewDto"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");
if (id == null) {
	id = "user1";
//	response.sendRedirect("login.jsp");
}

int spage = 1; // 현재 페이지 번호, 기본값은 1
int pageSu = 0; // 전체 페이지 수

// URL 파라미터에서 page 값을 가져와 현재 페이지 번호 설정
try {   
    spage = Integer.parseInt(request.getParameter("page"));
} catch (Exception e) {
    spage = 1;
}

if (spage <= 0) spage = 1;
 
ArrayList<ReviewDto> rlist = reviewMgr.getReview(id, spage);
reviewMgr.totalList(id); // 전체 레코드 수 계산
pageSu = reviewMgr.getPageSu(); // 전체 페이지 수 계산

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 리스트</title>
<style>
#selectAllReview, #delReview {
    margin: 10px;
    padding: 10px 20px;
    border: none;
    background-color: #000;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#selectAllReview:hover, #delReview:hover {
    background-color: #444;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-spacing: 10px;
    margin-bottom: 20px;
}

th, td {
    padding: 10px;
    text-align: left;
    border: none;
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

a:hover {
    font-size: 110%; /* 마우스 오버 시 글씨 크기 증가 */
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

.product-card {
	background: #fff;
	padding: 15px;
	margin: 10px;
	text-align: center;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	border-radius: 10px; /* 요소마다 배경에 둥근 모서리 추가 */
	display: inline-block; 
	width: 15%; 
	margin: 1%;
}
.product-card img {
	max-width: 150px;
}
#buttons {
	text-align: right;
}
</style>
<script type="text/javascript" src="../js/reviewedit.js"></script>
<script type="text/javascript">
window.onload = () => {
	document.querySelector("#delReview").onclick = () => {
		const selectArea = document.querySelectorAll('input[name="reviewcheck"]:checked');

		let result = [];
		selectArea.forEach((el) => {
			result.push(el.value);
		});
		document.reviewFrm.review_num.value = result;
		document.reviewFrm.submit();
	}
	document.querySelector("#selectAllReview").onclick = (e) => {
		const selectArea = document.querySelectorAll('input[name="reviewcheck"]');

		if (e.target.checked) {
			selectArea.forEach((el) => {
				el.checked = true;
			});
		} else {
			selectArea.forEach((el) => {
				el.checked = false;
			});
		}
	};
}
</script>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<div id="buttons">
<input type="checkbox" id="selectAllReview"> ALL
<input type="button" value="삭제" id="delReview">
</div>
<div>
<%
int count = 0;
for(ReviewDto r : rlist) {
	if (count % 5 == 0 && count != 0) {
		%>
		</div><div>
		<%
	}
	%>
	<div class="product-card">
		<input type="checkbox" name="reviewcheck" value="<%= r.getNum() %>">
		<p><a href="javascript:reviewDetail('<%=r.getNum() %>')"><img src="..\\upload\\<%= r.getPic() %>"></a></p>
		<p><%= r.getProduct() %></p>
		<p><%
		try{
			out.print(r.getContents().substring(0, 8));					
		}catch(Exception e){
			out.print(r.getContents());										
		}
		%>...</p>
		<p><%= r.getUser() %></p>
	</div>
	<%
	count++;
}
%>
</div>
<div id="pagination">
    <%
    for (int i = 1; i <= pageSu; i++) {
        if (i == spage) {
            out.print("<b>" + i + "</b>");
        } else {
            out.print("<a href='reviewlist.jsp?page=" + i + "'>" + i + "</a>");
        }
    }
    %>
</div>
<form action="reviewdelete.jsp" method="post" name="reviewFrm">
<input type="hidden" name="review_num">
</form>
<form action="../my/reviewdetail.jsp" name="detailFrm">
	<input type="hidden" name="review_num" />
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>