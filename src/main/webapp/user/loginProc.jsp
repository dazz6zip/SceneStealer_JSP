<%@page import="pack.user.UserMgr"%>
<%@page import="pack.user.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>

<%
// ajax가 전송한 아이디와 비밀번호 받아오기
String user_id = request.getParameter("user_id");
String user_pwd = request.getParameter("user_pwd");

//데이터베이스 연결을 위한 객체 생성
UserMgr connPool = new UserMgr();

try{
	//데이터베이스에서 해당 사용자 정보 조회
	UserBean log = connPool.userAccess(user_id);
	
	if (log != null && log.getPwd() == null) {
	    out.print("none"); // 비밀번호가 null인 경우 (탈퇴한 아이디 등)
	} else if (log != null && log.getPwd() != null && log.getPwd().equals(user_pwd)) {
	    // 로그인에 성공한 경우 세션에 사용자 정보 저장
	    session.setAttribute("idKey", user_id);
	    out.print("success"); // 아이디와 비밀번호가 모두 일치하는 경우
	} else if (log != null) {
	    out.print("invalid_pwd"); // 비밀번호가 틀린 경우
	} else {
	    out.print("invalid_id"); // 조회된 사용자가 없는 경우
	}
} catch (Exception e) {
    e.printStackTrace();
    out.print("error");
} finally {
}
%>