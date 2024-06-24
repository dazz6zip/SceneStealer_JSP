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
<title>Insert title here</title>
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
<jsp:include page="../user/header_user.jsp" />s
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
				<td rowspan="4"><a href="javascript:reviewDetail('<%=r.getNum() %>')"><img src="..\\upload\\<%= r.getPic() %>"></a></td>
				
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
<table style="width: 100%">
    <tr>
        <td style="text-align: center;">
            <%
            for (int i = 1; i <= pageSu; i++) {
                if (i == spage) {
                    out.print("<b style='font-size:15pt; color:red'>[" + i + "]</b>");
                } else {
                    out.print("<a href='reviewlist.jsp?page=" + i + "'>[" + i + "]</a>");
                }
            }
            %>
        </td>
    </tr>
</table>
<form action="reviewdelete.jsp" method="post" name="reviewFrm">
<input type="hidden" name="review_num">
</form>
<form action="../my/reviewdetail.jsp" name="detailFrm">
	<input type="hidden" name="review_num" />
</form>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>