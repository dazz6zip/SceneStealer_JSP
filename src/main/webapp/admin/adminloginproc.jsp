<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adminMgr" class="pack.admin.AdminMgr" />

<%
request.setCharacterEncoding("utf-8");
String adminid = request.getParameter("adminid");
String adminpasswd = request.getParameter("adminpasswd");

boolean b = adminMgr.adminLoginCheck(adminid, adminpasswd);

if(b){
   session.setAttribute("adminOk", adminid);  //관리자 세션 설정 //세션값설정
   response.sendRedirect("admin_index.jsp");
}else{
%>
   <script>
   alert("관리자 로그인 입력 오류!!!");
   location.href = "adminlogin.jsp";
   </script>
<%   
}
%>