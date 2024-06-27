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
	font-size: 80%;
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
						<td><%=series_title%></td>
					</tr>
					<tr>
						<td id="characterName"><%=cdto.getName()%></td>
					</tr>
					<tr>
						<td>
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
					<td>
						<%
						for (int i = 0; i < clist.size(); i++) {
							cdto = clist.get(i);
							%>
							
								<button class="character-btn" data-character="<%= cdto.getName() %>"></button>&emsp;
							
							<%
						}
						%>
						</td>
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
        $('.character-btn').click(function(e) { // 캐릭터 버튼 클릭 -> 같은 시리즈 다음 캐릭터가 나오고 관련된 정보 출력
            e.preventDefault(); // 이벤트의 기본 동작 제거
            let characterName = $(this).data('character'); // characterName 변수에 
            let seriesNum = '<%= series_num %>'; // seriesNum에 값 치환

            $.ajax({
                url: 'subproc.jsp', // ajax 호출 파일
                type: 'GET',
                data: { // ajax에 보낼 데이터 (캐릭터 이름과 시리즈 번호)
                    character_name: characterName,
                    series_num: seriesNum
                },
                dataType: 'json', // JSON 타입임을 명시
                success: function(response) { // subproc.jsp와 통신이 성공하면 실행 / 반환받은 값 -> response
                    $('#characterName').text(response.character.name); 
                	// 아이디가 characterName인 요소에 반환받은 character.name 부여
                	// 태그를 제외하고 부여하기 때문에 html이 아닌 text인 것
                    $('#subpicdiv').css('background-image', 'url(../upload/character/' + response.character.pic + ')');
                	// 아이디가 subpicdiv인 요소에 css 부여 (배경 이미지를 반환받은 character.pic으로 전환)
                    if (response.character.scrapCheck) { // 스크랩 여부에 따라 아이콘을 다르게 표시, 반환받은 스크랩 여부 (boolean)로 if문
                    	// 스크랩이 되어 있는 상태
                        $('.characterLike').attr('src', '../image/heart1.png');
                    	// 클래스가 characterLike인 요소에 속성 부여 (src 속성 값에 채워진 하트 이미지 경로)
                    } else {
                    	// 스크랩이 되어 있지 않은 상태
                        $('.characterLike').attr('src', '../image/heart2.png');
                     	// 클래스가 characterLike인 요소에 속성 부여 (src 속성 값에 채워 있지 않은 하트 이미지 경로)
                    }

                    let styleItemTable = $('#styleItemTable'); // 아이디가 styleItemTable인 요소를 styleItemTable 변수에 치환
                    styleItemTable.empty(); // styleItemTable를 비움 (새로운 데이터를 받아 출력하기 위해)

                    $.each(response.styles, function(index, style) { // 반환받은 style을 반복 (한 캐릭터에 여러 스타일이 있기 때문)
                        let row = $('<tr></tr>'); // row -> 새로 출력할 html문을 저장할 변수
                        row.append('<td width="30%"><img src="../upload/style/' + style.pic + '"></td>');
                        // append -> row 요소에 뒤에 넣음

                        $.each(style.items, function(i, item) { // 반환받은 item을 반복 (한 스타일에 여러 아이템이 있기 때문)
                            row.append(
                                '<td class="itemSelect"><img src="../upload/item/' + item.pic + '"><div class="overlay-link">' +
                                '<a href="#" class="ahrefproduct">상품 보러 가기</a><br/><a href="../shop/productdetail_g.jsp?name=' + item.product + 
                                '" class="ahrefproduct">이 상품은 어때요?</a></div></td>'
                                // 아이템을 출력할 코드 append
                            );
                        });
                        // 한 캐릭터의 정보를 출력하기 위해 중첩 반복문(each)를 사용하였음
                        styleItemTable.append(row);
                        // 코드를 append 해 둔 row를 비워 뒀던 styleItemTable에 넣음
                    });

                }
            });
        });

        // Like 버튼 클릭 이벤트 처리 (이벤트 위임 사용)
        $(document).on('click', '.characterLike', function() { // characterLike 버튼 클릭 -> 스크랩을 했을 경우 스크랩 취소, 스크랩을 하지 않았을 경우 스크랩
//          alert("안뇽");
            let flag = $(this).attr('src') === '../image/heart1.png' ? "delete" : "insert";
            // subscrapproc.jsp에 가지고 갈 flag를 지정하는 삼항연산자
            // 현재 characterLike 요소의 src 속성이 heart1.png 이미지이면 (이미 스크랩한 상태이면) delete flag
            // 그렇지 않을 경우 insert flag를 가지고 ajax 호출
            let characterName = $('#characterName').text(); 
            // characterName 변수에 아이디가 characterName인 요소의 텍스트 값 치환
            let seriesNum = '<%= series_num %>';
            // sub.jsp 페이지를 접근할 때 가지고 온 series_num
            $.ajax({
                url: 'subscrapproc.jsp', // subscrapproc.jsp 호출
                type: 'POST', // post 방식
                data: { // subscrapproc.jsp에 보낼 데이터 (delete/insert 구분을 위한 flag, 캐릭터 이름, 작품 번호, 작품 제목)
                    flag: flag,
                    cname: characterName,
                    series_num: seriesNum,
                    series_title: '<%= series_title %>',
                    character_name: characterName
                },
                dataType: 'json',
                success: function(scrapResponse) { // 통신 성공 / 반환값 scrapResponse
                    if (scrapResponse.success) { // 반환받은 값이 true면 (insert/delete 작업이 성공했으면)
                    	// 위에서 들고 간 flag를 기반으로 이미지 변경
                        if (flag === "insert") { // insert 작업을 하고 왔을 경우 
                            $('.characterLike').attr('src', '../image/heart1.png');
                        	// characterLike 요소의 src 속성을 heart1.png (채워진 하트) 이미지로 출력
                        } else { // delete 작업을 하고 왔을 경우 
                            $('.characterLike').attr('src', '../image/heart2.png');
                        	 // characterLike 요소의 src 속성을 heart2.png (빈 하트) 이미지로 출력
                        }
                    } else { // 반환받은 값이 false면 (insert/delete 작업이 실패했으면)
                        alert("스크랩에 실패하였습니다.");
                    }
                }
            });
        });

        $('#logoutscrap').click(function() { // 로그인이 되지 않은 상태에서 scrap 버튼 클릭
            location.href = '../user/loginForm.jsp'; // 로그인 페이지로 이동
        });

        $('#styleItemTable').on('mouseover', '.itemSelect', function() { 
        	// styleItemTable 안에 있는 itemSelect 요소에 mouseover 하면
            $(this).addClass('enlarged'); 
        	// 해당 itemSelect에 enlarged 클래스 추가
        	// css에서 enlarged 클래스는 요소를 커지게 함
            $(this).toggleClass('show-overlay');
        	// 해당 itemSelect에 show-overlay 클래스 추가
        	// css에서 show-overlay 클래스는 display 를 block으로 바꿈
        	// toggleClass는 클래스가 있을 경우 제거, 없을 경우 추가
        });

        $('#styleItemTable').on('mouseout', '.itemSelect', function() {
    		// 위에서 mouseover 효과를 부여했기 때문에 mouseout 효과도 부여함
    		// 클래스들을 제거함 (커졌던 효과와 옵션 노출을 제거)
            $(this).removeClass('enlarged');
            $(this).removeClass('show-overlay');
        });
    });
    </script>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>