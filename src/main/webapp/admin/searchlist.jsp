<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="seriesMgr" class="pack.main.SeriesMgr" />
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<%
// series나 actor에서 키워드 검색 시 suggest 목록 값을 반환해주는 비즈니스 로직용 파일
String option = request.getParameter("option");
String keyword = request.getParameter("keyword");
String str = "";
if(option.equals("series")){	
	str = seriesMgr.series_suggest(keyword);
} else if(option.equals("actor")){
	str = actorMgr.actor_suggest(keyword);
}
response.setContentType("text/plain");
response.getWriter().write(str);
%>