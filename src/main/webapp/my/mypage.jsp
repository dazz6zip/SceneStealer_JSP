<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    
}

#mypage {
    display: flex;
    justify-content: center;
    align-items: center;
    background: url(../image/mypagephoto.png) no-repeat;
    background-size: cover;
    height: 110vh;
    width: 100%;
    overflow: hidden;
}

#mypage table {
    text-align: center;
    border-spacing: 20px;
    border-collapse: separate;
}

#mypage td {
    background-color: black;
    padding: 50px;
    border-radius: 100px;
    color: #FFFFEA;
    text-align: center;
    width: 120px;
    opacity: 0;
    animation: fadeInUp 2s ease-in-out forwards;
}

#mypage a {
    text-decoration: none;
    color: inherit;
}

#mypage a:hover {
    font-size: 110%;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

body {
    margin: 0;
}



.main {
	width: 100%;
}
</style>
</head>
<body>
<jsp:include page="../user/header_user.jsp" />
<br/>
<div id="mypage">
    <table>
        <tr>
            <td><a href="../user/userInfoForm.jsp">회원 정보 수정</a></td>
            <td><a href="scrap.jsp">마이스크랩</a></td>
        </tr>
        <tr>
            <td><a href="orderinfo.jsp">주문정보</a></td>
            <td><a href="reviewlist.jsp">리뷰관리</a></td>
            <td><a href="../question/questionlist.jsp">Q&amp;A</a></td>
        </tr>
        <tr>
            <td><a href="../user/logout.jsp">로그아웃</a></td>
        </tr>
    </table>
</div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>