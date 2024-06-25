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
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        color: #333;
        text-align: center;
        margin: 0;
        padding: 0;
    }

    h3 {
        color: #ff69b4;
        margin: 20px 0;
    }

    a {
        color: #ff69b4;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    table {
        width: 90%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #ff69b4;
        color: white;
    }

    td {
        background-color: #fff;
    }

    .pagination {
        width: 100%;
        text-align: center;
        margin: 20px 0;
    }

    .pagination b {
        font-size: 12pt;
        color: red;
    }

    .pagination a {
        color: #ff69b4;
        text-decoration: none;
        margin: 0 5px;
    }

    .pagination a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<%@ include file="admin_top.jsp" %>

<h3> 🔥 답변을 기다리는 질문들 🔥</h3>
<table>
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
   <div class="pagination">
   <%
   for(int i=1; i <= unansweredTotalPage; i++){
      if(i==upage){ //선택페이지 굵은 빨강으로
         out.print("<b>[" +i + "]</b>");
      }else{ //선택되지 않은 페이지
         out.print("<a href='questionlist.jsp?upage="+i+ "&apage=" +apage + "'>[" +i + "]</a>");   
      }   
   }
   %>
   </div>

<h3>✔️ 답변 완료된 질문들 ✔️</h3>
<table>
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
   <div class="pagination">
   <%
   for(int i=1; i <= answeredTotalPage; i++){
      if(i==apage){ //선택페이지 굵은 빨강으로
         out.print("<b>" +i + "</b>");
      }else{ //선택되지 않은 페이지
         out.print("<a href='questionlist.jsp?upage="+upage+ "&apage=" + i + "'>" +i + "</a>");   
      }
   }
   %>
   </div>
</body>
</html>