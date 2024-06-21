<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
  <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 탈퇴 완료!</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          회원 탈퇴 되었습니다.<br>
          이용해주셔서 감사합니다:D
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" id="confirmBtn" class="btn btn-primary">확인</button>
        </div>
      </div>
    </div>
  </div>
  
  <script>
    $(document).ready(function(){
      $("#myModal").modal('show');
      
      $("#confirmBtn").click(function(){
        location.href = "main.jsp";
      });
    });
  </script>
</body>
</html>