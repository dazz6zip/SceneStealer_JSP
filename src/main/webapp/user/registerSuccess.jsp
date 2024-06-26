<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<body>
<jsp:include page="header_user.jsp" />
<script type="text/javascript">
	alert("회원가입에 성공했습니다.");
	location.href = "loginForm.jsp";
</script>
</body>
</html>