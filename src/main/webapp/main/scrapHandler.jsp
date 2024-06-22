<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%
String id = request.getParameter("user_id");
String characterName = request.getParameter("character_name");
String jsonResponse = "";

if (id == null) {
    jsonResponse = "{\"message\": \"로그인이 필요합니다.\"}";
} else {
    boolean c = mgr.getScrapCheck(id, characterName);
    if (c) { 
        mgr.delScrap(characterName, id);
        jsonResponse = "{\"message\": \"스크랩 취소\"}";
    } else {
        mgr.newScrap(characterName, id);
        jsonResponse = "{\"message\": \"스크랩 성공\"}";
    }
}

response.setContentType("application/json");
response.getWriter().write(jsonResponse);
%>