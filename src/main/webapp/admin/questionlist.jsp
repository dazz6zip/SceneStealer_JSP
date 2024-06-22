<%@page import="pack.question.QuestionDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="questionMgr" class="pack.question.QuestionMgr"/>
<jsp:useBean id="dto" class="pack.question.QuestionDto"/>

<%
ArrayList<QuestionDto> list;
int upage = 1, apage = 1; // 선택한 페이지 수 (미답변/답변)
int unansweredTotalPage = 0, answeredTotalPage = 0; // 전체 페이지 수 (미답변/답변)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문보기</title>
</head>
<body>
<%@ include file = "admin_top.jsp" %>

<h3> 🔥 답변을 기다리는 질문들 🔥</h3>
<table style="width:100%">
   <tr style="background-color: silver;">
   <th>번호</th><th>제  목</th><th>작성자</th><th>작성일</th>
   </tr>
   <%
   try{
      upage= Integer.parseInt(request.getParameter("upage"));
   }catch(Exception e){
      upage=1;
   }
   // 페이징처리
   unansweredTotalPage = questionMgr.getTotalPage("unanswered");
   list = questionMgr.getDataAll("unanswered", upage);
   
   for(int i=0; i<list.size(); i++){
      dto = (QuestionDto)list.get(i);
   %>   
   <tr>
   <td><%=dto.getNum() %></td>
   <td><a href="questiondetail.jsp?num=<%=dto.getNum() %>&upage=<%=i %>&apage=<%=apage %>"><%=dto.getTitle() %></a></td>
   <td><%=dto.getUser() %></td>
   <td><%=dto.getDate() %></td>
   </tr>
   <%
   }
   %>
   </table>
   <br>
   <table style="width: 100%">
   <tr>
   <td style="text-align: center;">
   <%
   for(int i=1; i <= unansweredTotalPage; i++){
      if(i==upage){ //선택페이지 굵은 빨강으로
         out.print("<b style='font-size:12pt;color:red'>[" +i + "]</b>");
      }else{ //선택되지 않은 페이지
         out.print("<a href='questionlist.jsp?upage="+i+ "&apage=" +apage + "'>[" +i + "]</a>");   
      }   
   }
   %>
   </td>
   </tr>
</table>

<h3>✔️ 답변 완료된 질문들 ✔️</h3>
<table style="width:100%">
   <tr style="background-color: silver;">
   <th>번호</th><th>제  목</th><th>작성자</th><th>작성일</th>
   </tr>
   <%
   try{
      apage= Integer.parseInt(request.getParameter("apage"));
   }catch(Exception e){
      apage=1;
   }
   // 페이징처리
   answeredTotalPage = questionMgr.getTotalPage("answered");
   list = questionMgr.getDataAll("answered", apage);
   
   for(int i=0; i<list.size(); i++){
      dto = (QuestionDto)list.get(i);
   %>   
   <tr>
   <td><%=dto.getNum() %></td>
   <td><a href="questiondetail.jsp?num=<%=dto.getNum() %>&upage=<%=upage %>&apage=<%=i %>"><%=dto.getTitle() %></a></td>
   <td><%=dto.getUser() %></td>
   <td><%=dto.getDate() %></td>
   </tr>
   <%
   }
   %>
   </table>
   <br>
   <table style="width: 100%">
   <tr>
   <td style="text-align: center;">
   <%
   for(int i=1; i <= answeredTotalPage; i++){
      if(i==apage){ //선택페이지 굵은 빨강으로
         out.print("<b style='font-size:12pt;color:red'>[" +i + "]</b>");
      }else{ //선택되지 않은 페이지
         out.print("<a href='questionlist.jsp?upage="+upage+ "&apage=" + i + "'>[" +i + "]</a>");   
      }
   }
   %>
   </td>
   </tr>
</table>
</body>
</html>