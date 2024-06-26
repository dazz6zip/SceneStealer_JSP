<%@page import="pack.review.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.main.SeriesDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.SeriesDto"></jsp:useBean>
<jsp:useBean id="rdto" class="pack.review.ReviewDto"></jsp:useBean>

<%
ArrayList<SeriesDto> slist = mgr.getSeriesDataforMain();
// 메인에 보일 시리즈 정보 (시리즈별 스크랩 추 합산하여 내림차순)
ArrayList<ReviewDto> rlist = mgr.getReviewDataAll();
// 메인에 보일 리뷰 정보 (review_num 내림차순으로 최신순 3개)
String searchword = request.getParameter("searchword");
// 검색시 받아옴
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
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
    height: 300px; /* 원하는 고정 높이 */
    object-fit: cover;
    object-position: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
}

.series-pic.enlarged {
    transform: scale(1.3);
    z-index: 10;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

body {
    margin: 0;
}

#maindiv {
    display: flex;
    justify-content: center;
    align-items: center;
    background: url(../image/mainphoto-01.png) no-repeat;
    background-size: cover;
    height: 120vh;
    width: 100%;
    overflow: hidden;
}

.main {
    width: 100%;
}

.main table {
    width: 100%;
}

.main table td {
    text-align: center;
}

#main_rv img {
    width: 30%;
    height: 200px; /* 원하는 고정 높이 */
    object-fit: cover;
    object-position: center;
}
</style>
</head>
<body>
	<jsp:include page="../main/header_main.jsp"></jsp:include>
	<div id="maindiv">
		<table>
			<tr>
				<th></th>
			</tr>
		</table>
	</div>
	<div class="main">
		<form name="mainFrm1">
			<table>
				<tr>
					<th colspan="4" height="200px">CHOOSE YOUR SCENE!</th>
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
								<th>
									<a href="sub.jsp?series_num=<%=sdto.getNum()%>&series_title=<%=sdto.getTitle()%>">
										<img src="..\\upload\\series\\<%=sdto.getPic()%>" class="series-pic">
									</a>
								</th>
							</tr>
							<tr>
								<td><%=sdto.getTitle()%>(<%= sdto.getDate().substring(0, 4) %>)</td>
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
	<div class="main">
		<form action="../my/reviewdetail.jsp" method="get" name="mainFrm2">
			<table id="main_rv">
			    <tr>
			        <th colspan="3" height="200px">NEW REVIEW</th>
			    </tr>
			    <tr>
			        <td>
			            <%
			            for (ReviewDto r : rlist) {
							out.print("<a href=\"javascript:mainreview('" + r.getNum() + "')\">" + "<img src='..\\upload\\" +r.getPic()  +"'>" +"</a>");
							%>
								<br>
							<%
							out.print(r.getProduct() + "<br/>");
						}
						%>
			        </td>
			    </tr>
			</table>
			<input type="hidden" name="review_num" value="<%=rdto.getProduct()%>">
		</form>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	<a href="../admin/admin_index.jsp" style="opacity: 20%">admin</a>
</body>
</html>