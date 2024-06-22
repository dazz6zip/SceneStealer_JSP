<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="userBean" class="pack.user.UserBean" scope="page" />
<jsp:setProperty property="*" name="userBean" />
<jsp:useBean id="userMgr" class="pack.user.UserMgr" />

<%
String id = (String)session.getAttribute("idKey");
boolean b = userMgr.userUpdate(userBean, id);

if(b){
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


</head>
	<body>
	<jsp:include page="header_user.jsp" />
	  <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">수정 성공!</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          수정이 완료되었습니다.
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" id="closeBtn" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
  <script>
    // 페이지 로드 시 모달 표시
    $(document).ready(function(){
      $("#myModal").modal('show');
      //location.href="main.jsp";
    });
    
    // close 버튼 클릭 시 main.jsp로 이동
    $("#closeBtn").click(function(){
    	location.href = "main.jsp";
    })
  </script>
	</body>
</html>
<%}else{%>
	<script>
	alert("수정 실패\n관리자에게 문의 바람");
	history.back();
	</script>
<%	
}
%>