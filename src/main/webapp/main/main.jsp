<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.main.SeriesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<jsp:useBean id="rdto" class="pack.review.ReviewDto"></jsp:useBean>

<%
ArrayList<SeriesDto> slist = mgr.getSeriesDataforMain();
ArrayList<ReviewDto> rlist = mgr.getReviewDataAll();
String searchword = request.getParameter("searchword");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<link rel="stylesheet" type="text/css" href="mainstyle.css">
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.series-pic').on('mouseover', function() { // series-pic 클래스에 mouseover
			$(this).addClass('enlarged'); // this(seried-pic) 에 enlarged 클래스 추가 (enlarged -> css 적용을 위함)
		});

		$('.series-pic').on('mouseout', function() { // series-pic 클래스에 mouseout
			$(this).removeClass('enlarged'); // this(seried-pic) 에 enlarged 클래스 제거
		});
	});
</script>
<style>
/* Series Picture Styles */
.series-pic {
	width: 100%;
	max-width: 200px;
	height: auto;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer;
}

.series-pic.enlarged {
	transform: scale(1.3);
	z-index: 10;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>
	<%
	request.setAttribute("val", searchword);
	%>
	<jsp:include page="../main/header_main.jsp"></jsp:include>
	<div id="maindiv">
		<table>
			<tr style="height: 800px"></tr>
			<tr>
				<th><h2>SceneStealer</h2></th>
			</tr>
			<tr>
				<td>페이지 설명하는 글 어쩌구 저쩌구...</td>
			</tr>
		</table>
	</div>
	<div>
		<form name="mainFrm1">
			<table>
				<tr>
					<th colspan="4">CHOOSE YOUR SCENE!</th>
				</tr>
				<%
				if (slist.isEmpty()) {
				%>
				<tr>
					<td>작품이 등록되지 않았습니다.</td>
				</tr>
				<%
				} else {
				for (int i = 0; i < slist.size(); i++) {
					if (i % 4 == 0) {
				%>
				<tr>
					<%
					}
					sdto = slist.get(i);
					%>
					<td>
						<table class="cysSelect">
							<tr>
								<th><a
									href="sub.jsp?series_num=<%=sdto.getNum()%>&series_title=<%=sdto.getTitle()%>"><img
										src="<%=sdto.getPic()%>" class="series-pic"></a></th>
							</tr>
							<tr>
								<td><%=sdto.getTitle()%></td>
							</tr>
						</table>
					</td>
					<%
					if ((i + 1) % 4 == 0 || i == slist.size() - 1) { // End the row after 4 items or if it's the last item
					%>
				</tr>
				<%
				}
				}
				}
				%>
			</table>
			<input type="hidden" name="series_num" value="<%=sdto.getNum()%>">
			<input type="hidden" name="series_title" value="<%=sdto.getTitle()%>">
		</form>
	</div>
	<div>
		<form action="../shop/review.jsp" method="get" name="mainFrm2">
			<table id="main_rv">
			    <tr>
			        <th colspan="2">NEW REVIEW</th>
			    </tr>
			    <tr>
			        <td rowspan="2">
			            <%
			            rdto = rlist.get(0);
			            out.print("<a href=\"javascript:mainreview('" + rdto.getNum() + "')\">" + rdto.getPic() + "</a>");
			            %>
			            <br>
			            <%
			            out.print(rdto.getProduct());
			            %>
			        </td>
			        <td>
			            <%
			            rdto = rlist.get(1);
			            out.print("<a href=\"javascript:mainreview('" + rdto.getNum() + "')\">" + rdto.getPic() + "</a>");
			            %>
			            <br>
			            <%
			            out.print(rdto.getProduct());
			            %>
			        </td>
			    </tr>
			    <tr>
			        <td>
			            <%
			            rdto = rlist.get(2);
			            out.print("<a href=\"javascript:mainreview('" + rdto.getNum() + "')\">" + rdto.getPic() + "</a>");
			            %>
			            <br>
			            <%
			            out.print(rdto.getProduct());
			            %>
			        </td>
			    </tr>
			</table>
			<input type="hidden" name="review_num" value="<%=rdto.getProduct()%>">
		</form>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>