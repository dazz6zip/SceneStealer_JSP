<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");
String flag = request.getParameter("flag");
String cname = request.getParameter("cname");

boolean success = false;
try {
    if (flag.equals("insert")) {
        mgr.newScrap(cname, id);
        success = true;
    } else if (flag.equals("delete")) {
        mgr.delScrap(cname, id);
        success = true;
    }
} catch (Exception e) {
    success = false;
}

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
out.print("{\"success\": " + success + "}");
out.flush();
%>