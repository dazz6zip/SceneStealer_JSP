<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String val = request.getParameter("val");
String id = (String)session.getAttribute("idKey");
String log = "";

if (id == null) {
	log = "<a href='../user/loginForm.jsp'>로그인</a>"; // 세션에 로그인 정보가 없을 때 로그인 페이지로 이동할 수 있도록 설정
} else {
	log = "<a href='../my/mypage.jsp'><img src='../image/profileicon.png' width='100%'></a>"; // 세션에 로그인 정보가 있을 때 마이페이지로 이동할 수 있도록 설정
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

.top{
	width: 100px;
	text-align: center;
}

.top img {
	width: 50%;
}

#topSearch {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    height: 100%;
    flex-grow: 1;
}

.search {
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.search__select {
  font-family: inherit;
  font-size: inherit;
  background-color: #f4f2f2;
  border: none;
  color: #646464;
  padding: 0.7rem 1rem;
  border-radius: 30px;
  margin-right: 0.5rem;
  transition: all ease-in-out .5s;
}

.search__input {
  font-family: inherit;
  font-size: inherit;
  background-color: #f4f2f2;
  border: none;
  color: #646464;
  padding: 0.7rem 1rem;
  border-radius: 30px;
  width: 12em;
  transition: all ease-in-out .5s;
  margin-right: 0.5rem;
}

.search__input:hover, .search__input:focus {
  box-shadow: 0 0 1em #00000013;
}

.search__input:focus {
  outline: none;
  background-color: #f0eeee;
}

.search__input::-webkit-input-placeholder {
  font-weight: 100;
  color: #ccc;
}

.search__button {
  font-family: inherit;
  font-size: inherit;
  background-color: #323232;
  color: #fff;
  border: none;
  padding: 0.7rem 1rem;
  border-radius: 30px;
  transition: background-color 0.3s;
}

.search__button:hover {
  background-color: #505050;
  cursor: pointer;
}
</style>

<script>
window.onload = () => {
	document.querySelector("#searchBtn").onclick = () => {
		const searchWordInput = document.querySelector("input[name='searchword']").value;
		// const korOnly = /^[가-힣]+$/; // 정규표현식 (주석 처리)
		/*
		if (!korOnly.test(searchWordInput)) {
			alert("한글만 입력 가능합니다.");
			document.querySelector("input[name='searchword']").focus();
			return;
		}else 
		*/
		if (searchWordInput.length < 2) {
			alert("두 글자 이상 입력해 주세요.");
			document.querySelector("input[name='searchword']").focus();
			return;
		} else {
			document.querySelector("#searchForm").submit(); // 폼 제출
		}
	}
}
</script>

<div id="headertable">
    <div id="logo"><a href="main.jsp"><img src="../image/logo-01.png" width="100%"></a></div>
    <div class="top"><a href="main.jsp">HOME</a></div>
    <div class="top"><a href="../shop/productlist.jsp">SHOP</a></div>
    <div id="topSearch">
        <form id="searchForm" action="../main/main_search.jsp" method="GET">
            <div class="search">
                <select name="searchSelect" class="search__select">
                    <option value="series" selected="selected">작품 제목</option>
                    <option value="actor">배우</option>
                </select>
                <input type="text" name="searchword" class="search__input" <%
                if (val != null) {
                    out.print("value='" + val + "'");
                } else {
                    out.print("placeholder='검색어를 입력하세요.'");
                }
                %>>
                <button type="button" id="searchBtn" class="search__button">search</button>	
			</div>
        </form>
    </div>
    <div class="top"><%= log %></div>
</div>