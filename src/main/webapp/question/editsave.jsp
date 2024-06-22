<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="qdto" class="pack.question.QuestionDto" />
<jsp:setProperty property="*" name="qdto"/>
<jsp:useBean id="qmgr" class="pack.question.QuestionMgr_u" />

<%

// 질문 수정 부분
String spage = request.getParameter("page");


qmgr.saveEdit(qdto); 
response.sendRedirect("questionlist.jsp?page="+spage);
%>