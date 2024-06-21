<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<%
String[] delReviewNum = request.getParameterValues("review_num");
boolean b = false;
for (String s : delReviewNum) {
	b = reviewMgr.delReview(s);
	if (!b) {
		return;
	}
}
if (b) {
	%>
	<script>
	alert("삭제가 완료되었습니다.");
	location.href = "reviewlist.jsp";
	</script>
	<%
} else {
	%>
	<script>
	alert("삭제 실패");
	location.href = "reviewlist.jsp";
	</script>
	<%
}
%>