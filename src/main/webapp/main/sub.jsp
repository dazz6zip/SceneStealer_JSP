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

<style type="text/css">
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

</style>
</head>
<body>
	<jsp:include page="header_main.jsp"></jsp:include>
	<table>
		<tr>
			<td width="40%" id="subpicdiv">
				<table>
					<tr>
						<td colspan="2"><%=series_title%></td>
					</tr>
					<tr>
						<td colspan="2" id="characterName"><%=character_name%></td>
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
								heart = "<img src='../image/heart1.png' id='characterLike' width='20px'>";
								scrapCheck = true;
							}else {
								heart = "<img src='../image/heart2.png' id='characterLike' width='20px'>";
							}
						}
						out.print(heart);
						%>
						</td>
					</tr>
					<tr>
						<td colspan="2" id="characterLikeCount">
						<%= mgr.getLikeCount(cdto.getNum()) %>
						</td>
					</tr>
 
					<tr>
						<%
						for (int i = 0; i < clist.size(); i++) {
							cdto = clist.get(i);
							%>
							<td>
								<button class="character-btn" data-character="<%= cdto.getName() %>">ㅇ</button>
							</td>
							<%
						}
						%>
					</tr>
				</table>
			</td>
			<td>
				<table id="styleItemTable" border="1">
					<%
					for (int i = 0; i < slist.size(); i++) {
						sdto = slist.get(i);
						ArrayList<ItemDto> ilist = mgr.getItemData(sdto.getNum());
					%>
					<tr>
						<td width="30%"><%=sdto.getPic()%></td>
						<%
						for (int j = 0; j < ilist.size(); j++) {
							idto = ilist.get(j);
						%>
						<td class="itemSelect">
							<%=idto.getPic()%>
							<div class="overlay-link">
								<a href="#">유사 상품 보러 가기</a>
								<a href="#">같은 상품 보러 가기</a>
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
	<jsp:include page="../footer.jsp"></jsp:include>
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
                    $('#characterLikeCount').text(response.character.like);

                    let styleItemTable = $('#styleItemTable');
                    styleItemTable.empty();

                    $.each(response.styles, function(index, style) {
                        let row = $('<tr></tr>');
                        row.append('<td width="30%">' + style.pic + '</td>');

                        $.each(style.items, function(i, item) {
                            row.append(
                                '<td class="itemSelect">' +
                                    item.pic +
                                    '<div class="overlay-link">' +
                                        '<a href="#">유사 상품 보러 가기</a>' +
                                        '<a href="#">같은 상품 보러 가기</a>' +
                                    '</div>' +
                                '</td>'
                            );
                        });

                        styleItemTable.append(row);
                    });
                }
            });
        });
        
        $('#characterLike').click(function() {
			if (<%= scrapCheck %>) {
				location.href = "subscrapproc.jsp?flag=delete&cname=<%= character_name %>";
			} else {
				location.href = "subscrapproc.jsp?flag=insert&cname=<%= character_name %>";
			}

        });
        
        $('#logoutscrap').click(function() {
			location.href = '../user/loginForm.jsp';

        });

        $('#styleItemTable').on('mouseover', '.itemSelect', function() {
            $(this).addClass('enlarged');
        });

        $('#styleItemTable').on('click', '.itemSelect', function() {
            $(this).toggleClass('show-overlay');
        });

        $('#styleItemTable').on('mouseout', '.itemSelect', function() {
            $(this).removeClass('enlarged');
            if ($(this).hasClass('show-overlay')) {
                $(this).removeClass('show-overlay');
            }
        });
    });
    </script>
</body>
</html>