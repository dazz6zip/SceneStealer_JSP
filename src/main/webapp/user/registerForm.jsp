<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<!-- ======= -->

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="../js/script.js"></script>

<!-- Daum PostcodeAddress API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<jsp:include page="header_user.jsp" />
<h1>Create Account</h1> 
가입을 통해 더 다양한 서비스를 만나보세요!

<br><br>

<form action="registerProc.jsp" method="post" id="registerForm" name="registerForm">
	<!-- 아이디 -->
	<div class="user_input">
		<input type="text" name="id" placeholder="아이디">
		<button type="button" id="idCheck">중복체크</button>
	</div>
	<div class="error_message" id="user_id_check"></div>
	
	<!-- 비밀번호 -->
	<div class="user_input">
		<input type="password" name="pwd" placeholder="비밀번호">
	</div>
	<div class="error_message" id="user_pwd_check"></div>
	<div class="user_input">
		<input type="password" name="pwd_chk" placeholder="비밀번호 재입력">
	</div>
	<div class="error_message" id="pwd_chk_check"></div>
	
	<!-- 이름 -->
	<div class="user_input">
		<input type="text" name="name" placeholder="이름">
	</div>
	<div class="error_message" id="name_check"></div>
	
	<!-- 이메일 -->
	<div class="email_input">
		<input type="text" name="user_email" id="user_email" placeholder="이메일">
		<span id="middle" style="margin: 7px;">@</span>
		<input type="text" name="email_domain" id="email_domain" value="" disabled list="email_select">
	    <select name="email_select" id="email_select" onchange="email_change()">
	    	<option value="0">선택하세요</option>
	    	<option value="9">직접입력</option>
	        <option value="naver.com">naver.com</option>
	        <option value="google.com">google.com</option>
	        <option value="hanmail.net">hanmail.net</option>
	        <option value="nate.com">nate.com</option>
	        <option value="kakao.com">kakao.com</option>
	    </select>
	</div>
	<div class="error_message" id="user_email_check"></div>
	<input type="hidden" id="full_email" name="email" value="">
	
	<!-- 전화번호 -->
	<div class="user_input">
		<input type="text" name="tel" id="user_tel" placeholder="휴대폰번호(&quot; - &quot; 제외)">
	</div>
	<div class="error_message" id="tel_check"></div>
	
	<!-- 주소 -->
	<div class="user_input">
		<input type="text" placeholder="우편번호" maxlength="6" name="zipcode" id="zipcode_display" disabled="disabled">
		<button type="button" onclick="daum_AddressAPI()">Search</button>
	</div>
	<input type="hidden" id="user_zipcode" name="zipcode" value="">
	
	<div class="user_input">
		<input type="text" name="addr_start" id="addr_start" placeholder="도로명/지번 주소" disabled="disabled">
	</div>
	<div class="user_input">
		<input type="text" name="addr_end" id="addr_end" placeholder="상세 주소">
	</div>
	<div class="error_message" id="user_addr_check"></div>
	<input type="hidden" id="full_addr" name="address" value="">
	
	<input type="button"class="btnRegister btn-16" value="Join Up" id="btnRegister">
</form>
</body>
</html>