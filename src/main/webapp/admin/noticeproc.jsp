<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="noticeMgr" class="pack.notice.NoticeMgr"/>
<%
request.setCharacterEncoding("utf-8");
// redirection되는 페이지에서 alert로 메시지를 처리 결과를 표시하도록
// insert,delete 시에는 목록으로, update 시에는 해당 글로 가도록
String msg = "";
String redirectUrl = "noticelist.jsp";

// update 시 해당 글로 갈 때 필요한 num
// 이 파일 호출 시 제출되는 form 태그의 enctype 때문에 파라미터로 직접 받아오게 했음
String num = request.getParameter("num");

switch (request.getParameter("flag")) {
case "insert":
	msg = noticeMgr.insertNotice(request) ? "공지 등록 완료" : "공지 등록 실패 ㅠㅠ";
	break;
case "update":
	msg = noticeMgr.updateNotice(request) ? "공지 수정 완료" : "공지 수정 실패 ㅠㅠ";
	redirectUrl = "noticedetail.jsp?spage=1&num=" + num;
	break;
case "delete":
	msg = noticeMgr.deleteNotice(request.getParameter("num")) ? "삭제 완료" : "삭제 실패";
	break;
}

session.setAttribute("msg", msg);
response.sendRedirect(redirectUrl);
%>