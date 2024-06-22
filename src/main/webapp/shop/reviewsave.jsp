<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="pack.review.ReviewBean"></jsp:useBean>
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="reviewMgr" class="pack.review.ReviewMgr"></jsp:useBean>
<%
 //클라이언트에 아이피 어드레스 등록
int newNum = reviewMgr.newNum();
bean.setNum(newNum);
%>