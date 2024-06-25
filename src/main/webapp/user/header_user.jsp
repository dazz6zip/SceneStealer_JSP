<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String)session.getAttribute("idKey");
String log = "";

if (id == null) {
	log = "<a href='../user/loginForm.jsp'>로그인</a>";
} else {
	log = "<a href='../my/mypage.jsp'><img src='../image/profileicon.png' width='20%'></a>";
}
%>

<style>
#headertable a {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 부모 요소의 글씨 색상 상속 */
}

/* 마우스를 올렸을 때 색상 변경 (선택 사항) */
#headertable a:hover {
	font-size: 120%;
}

#headertable {
	top: 0;
	left: 0;
	width: 100%;
	background-color: white; /* 필요에 따라 배경색을 지정 */
	z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
	display: flex;
	align-items: center;
	justify-content: space-between;
}

#logo {
	width: 80px;
	text-align: center;
}
#topSearch {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    height: 100%;
    flex-grow: 1;
}


.top {
	width: 100px;
	text-align: center;
}

.top img {
	width: 50%;
}
</style>

<div id="headertable">
    <div id="logo"><a href="../main/main.jsp"><img src="../image/logo-01.png" width="100%"></a></div>
    <div class="top"><a href="../main/main.jsp">HOME</a></div>
    <div class="top"><a href="../shop/productlist.jsp">SHOP</a></div>
     <div id="topSearch">
    </div>
    <div class="top"><%= log %></div>
</div>