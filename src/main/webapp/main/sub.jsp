<%@page import="pack.main.ItemDto"%>
<%@page import="pack.main.StyleDto"%>
<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<jsp:useBean id="cdto" class="pack.main.CharacterDto"></jsp:useBean>
<jsp:useBean id="sdto" class="pack.main.StyleDto"></jsp:useBean>
<jsp:useBean id="idto" class="pack.main.ItemDto"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");


String series_num = request.getParameter("series_num");
if (series_num == null) {
	series_num = "1";
}
String series_title = request.getParameter("series_title");
if (series_title == null) {
	series_title = "series1";
}


String character_name = request.getParameter("character_name");
ArrayList<CharacterDto> clist = mgr.getCharacterData(series_num);
if (character_name == null) {
	character_name = clist.get(0).getName();
}

cdto = mgr.getCharacterByName(series_num, character_name);
ArrayList<StyleDto> slist = mgr.getStyleData(cdto.getNum());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<link rel="stylesheet" type="text/css" href="substyle.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../js/sub.js"></script>

<style>
/* 기존 스타일 그대로 유지 */
body {
	width: 100%;
	height: 100vh;
	margin: 0;
	display: flex;
	flex-direction: column;
}

table {
	width: 100%;
	height: 100%;
	border-collapse: collapse;
}

#infotable td {
	text-align: center;
	vertical-align: middle;
}

.itemSelect {
	position: relative;
	transition: transform 0.3s ease;
}

.itemSelect.enlarged {
	transform: scale(1.3);
	z-index: 10;
}

.itemSelect .overlay-link {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	background: rgba(255, 255, 255, 0.8);
	padding: 5px;
	border-radius: 5px;
	text-align: center;
}

.itemSelect.show-overlay .overlay-link {
	display: block;
}

.character-btn {
	background: none;
	color: inherit;
	font: inherit;
	cursor: pointer;
	padding: 8px;
	margin: 0;
	outline: none;
	border-radius: 10px;
	height: 1px;
	width: 10px;
}

#infotable #info {
	color: white;
}

#infotable #info button {
	border-color: white;
}

.ahrefproduct {
	color: gray;
	text-decoration: none;
}

.ahrefproduct:hover {
	color: #000;
}

#styleItemTable img {
	width: 200px; /* 고정 너비 */
	height: 200px; /* 고정 높이 */
	object-fit: cover;
	object-position: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer;
}

#styleItemTable .itemSelect img {
	width: 200px; /* 고정 너비 */
	height: 200px; /* 고정 높이 */
	object-fit: cover;
	object-position: center;
}

#subpicdiv {
	background-repeat: no-repeat;
	background-size: cover;
	height: 100%; /* 부모 td의 높이에 맞춤 */
}
</style>
</head>
<body>
	<jsp:include page="header_main.jsp"></jsp:include>
	<table id="infotable">
		<tr>
			<td width="30%" id="subpicdiv" style="background-image: url('../upload/character/<%= cdto.getPic() %>')">
				<table id="info">
					<tr style="height: 60%"></tr>
					<tr>
						<td colspan="2"><%=series_title%></td>
					</tr>
					<tr>
						<td colspan="2" id="characterName"><%=cdto.getName()%></td>
					</tr>
					<tr>
						<td colspan="2">
						<%
						String heart = "";
						boolean scrapCheck = false;
						if (id == null) {
							heart = "<img src='../image/heart2.png' id='logoutscrap' width='20px'>";
						} else {							
							if(mgr.getScrapCheck(id, character_name)){
								heart = "<img src='../image/heart1.png' class='characterLike' width='20px'>";
								scrapCheck = true;
							}else {
								heart = "<img src='../image/heart2.png' class='characterLike' width='20px'>";
							}
						}
						out.print(heart);
						%>
						</td>
					</tr>
 
					<tr>
						<%
						for (int i = 0; i < clist.size(); i++) {
							cdto = clist.get(i);
							%>
							<td>
								<button class="character-btn" data-character="<%= cdto.getName() %>"></button>
							</td>
							<%
						}
						%>
					</tr>
				</table>
			</td>
			<td>
				<table id="styleItemTable">
					<%
					for (int i = 0; i < slist.size(); i++) {
						sdto = slist.get(i);
						ArrayList<ItemDto> ilist = mgr.getItemData(sdto.getNum());
					%>
					<tr>
						<td>
							<img src="../upload/style/<%=sdto.getPic()%>">
						</td>
						<%
						for (int j = 0; j < ilist.size(); j++) {
							idto = ilist.get(j);
						%>
						<td class="itemSelect">
							<img src="../upload/item/<%=idto.getPic()%>">
							<div class="overlay-link">
								<a href="#" class="ahrefproduct">상품 보러 가기</a><br/><br/>
								<a href="../shop/productdetail_g.jsp?name=<%= idto.getProduct() %>" class="ahrefproduct">이 상품은 어때요?</a>
							</div>
						</td>
						<%
						}
						%>
					</tr>
					<%
					}
					%>
				</table>
			</td>
		</tr>
	</table>
	<form action="sub.jsp" name="characterFrm" method="post">
		<input type="hidden" name="character_name"> 
		<input type="hidden" name="series_num" value="<%=series_num%>">
		<input type="hidden" name="series_title" value="<%=series_title%>">
	</form>

	<script>
	$(document).ready(function() {
        $('.character-btn').click(function(e) {
            e.preventDefault();
            let characterName = $(this).data('character');
            let seriesNum = '<%= series_num %>'; 

            $.ajax({
                url: 'subproc.jsp',
                type: 'GET',
                data: {
                    character_name: characterName,
                    series_num: seriesNum
                },
                dataType: 'json',
                success: function(response) {
                    $('#characterName').text(response.character.name);
                    $('#subpicdiv').css('background-image', 'url(../upload/character/' + response.character.pic + ')');
                    if (response.character.scrapCheck) {
                        $('.characterLike').attr('src', '../image/heart1.png');
                    } else {
                        $('.characterLike').attr('src', '../image/heart2.png');
                    }

                    let styleItemTable = $('#styleItemTable');
                    styleItemTable.empty();

                    $.each(response.styles, function(index, style) {
                        let row = $('<tr></tr>');
                        row.append('<td width="30%"><img src="../upload/style/' + style.pic + '"></td>');

                        $.each(style.items, function(i, item) {
                            row.append(
                                '<td class="itemSelect">' +
                                    '<img src="../upload/item/' + item.pic + '">' +
                                    '<div class="overlay-link">' +
                                    '<a href="#" class="ahrefproduct">상품 보러 가기</a><br/>' +
                                    '<a href="../shop/productdetail_g.jsp?name=' + item.product + '" class="ahrefproduct">이 상품은 어때요?</a>' +
                                    '</div>' +
                                '</td>'
                            );
                        });

                        styleItemTable.append(row);
                    });

                }
            });
        });

        // Like 버튼 클릭 이벤트 처리 (이벤트 위임 사용)
        $(document).on('click', '.characterLike', function() {
//          alert("안뇽");
            let flag = $(this).attr('src') === '../image/heart1.png' ? "delete" : "insert";
            let characterName = $('#characterName').text();
            let seriesNum = '<%= series_num %>';
            $.ajax({
                url: 'subscrapproc.jsp',
                type: 'POST',
                data: {
                    flag: flag,
                    cname: characterName,
                    series_num: seriesNum,
                    series_title: '<%= series_title %>',
                    character_name: characterName
                },
                dataType: 'json',
                success: function(scrapResponse) {
                    if (scrapResponse.success) {
                        if (flag === "insert") {
                            $('.characterLike').attr('src', '../image/heart1.png');
                        } else {
                            $('.characterLike').attr('src', '../image/heart2.png');
                        }
                    } else {
                        alert("스크랩에 실패하였습니다.");
                    }
                }
            });
        });

        $('#logoutscrap').click(function() {
            location.href = '../user/loginForm.jsp';
        });

        $('#styleItemTable').on('mouseover', '.itemSelect', function() {
            $(this).addClass('enlarged');
            $(this).toggleClass('show-overlay');
        });

        $('#styleItemTable').on('mouseout', '.itemSelect', function() {
            $(this).removeClass('enlarged');
            $(this).removeClass('show-overlay');
        });
    });
    </script>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>