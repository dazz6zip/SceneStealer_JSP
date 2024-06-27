<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");
String flag = request.getParameter("flag");
String cname = request.getParameter("cname");
// ajax 호출시 넘긴 데이터를 받음

boolean success = false;
try {
    if (flag.equals("insert")) { 
        mgr.newScrap(cname, id);
        success = true;
    	// insert 작업에 성공하면 success (true) 반환
    } else if (flag.equals("delete")) {
        mgr.delScrap(cname, id);
        success = true;
        // delete 작업에 성공하면 success (true) 반환
    }
} catch (Exception e) {
    success = false;
}

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
out.print("{\"success\": " + success + "}");

out.flush(); // 버퍼와 스트림 지우기
%>