<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SceneStealer</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    font-size: 24px;
    font-weight: bold;
    margin-top: 20px;
    margin-bottom: 10px;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 700px;
    box-sizing: border-box;
}

.user_input, .email_input {
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
}

.user_input input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
}

.email_input {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.email_input input[type="text"],
.email_input select {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 10px; /* Space between elements */
    box-sizing: border-box;
}

#user_email {
    flex: 1; /* Allow it to grow and take available space */
}

#middle {
    margin: 0 10px; /* Adjust spacing between elements */
}

#email_domain {
    flex: 1; /* Allow it to grow and take available space */
}

#email_select {
    flex: 1; /* Allow it to grow and take available space */
}
button, .btnRegister {
    background-color: #333;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    width: 100%;
    font-size: 16px;
    margin-top: 10px;
}

button:hover, .btnRegister:hover {
    background-color: #444;
}

.error_message {
    color: red;
    font-size: 12px;
    height: 15px; /* Ensure space is allocated even if there's no message */
    margin-top: -10px;
    margin-bottom: 10px;
}

#zipcode_display, #addr_start, #current_addr {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
}

.flex-row {
    display: flex;
    flex-direction: row;
    align-items: center;
}

.flex-row input {
    flex: 1;
    margin-right: 10px;
}
</style>
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
    <span id="middle">@</span>
    <input type="text" name="email_domain" id="email_domain" placeholder="도메인" disabled>
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
	
	<input type="button" class="btnRegister btn-16" value="Join Up" id="btnRegister">
</form>
</body>
</html>