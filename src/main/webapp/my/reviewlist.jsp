<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<jsp:useBean id="redto" class="pack.review.ReviewDto"></jsp:useBean>
<%
String id = (String)session.getAttribute("idKey");
if (id == null) {
	id = "user1";
//	response.sendRedirect("login.jsp");
}
ArrayList<ReviewDto> rlist = reviewMgr.getReview(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<input type="checkbox" id="selectAllReview"> 전체 선택
<input type="button" value="삭제" id="delReview">

<table border="1">
<tr>
<%
for(ReviewDto r : rlist) {
	%>
	<td>
		<table border="1">
			<tr>
				<td><input type="checkbox" name="reviewcheck" value="<%= r.getNum() %>"></td>
				<td rowspan="4"><%= r.getPic() %></td>
			</tr>
			<tr>
				<td><%= r.getProduct() %></td>
			</tr>
			<tr>
				<td><%= r.getContents().substring(0, 8)%>...</td>
			</tr>
			<tr>
				<td><%= r.getUser() %></td>
			</tr>
		</table>
	</td>
	<%
}
%>
	
</tr>
</table>
<form action="reviewdelete.jsp" method="post" name="reviewFrm">
<input type="hidden" name="review_num">
</form>
</body>
</html>