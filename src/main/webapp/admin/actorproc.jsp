<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 배우는 수정불가이므로 추가처리만 해주는 파일
// 메인 요소 중 유일하게 사진이 없는 일반 form이므로 setProperty로 바로 받기 -->
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="actorMgr" class="pack.main.ActorMgr" />
<jsp:useBean id="actorBean" class="pack.main.ActorBean" />
<jsp:setProperty property="*" name="actorBean" />

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/mainedit.js"></script>

<%
int num = actorBean.getNum();
String userInfo = actorBean.getName() + " (" + actorBean.getBirth() + ")";

if(actorMgr.insertActor(actorBean)){
	// 성공. actorsearch 창 닫고 opener인 characteredit의 연결된 배우 칸에 값 적히게
%>
	<script>
	alert("배우 추가 완료!\n해당 배우를 연결하여 계속해서 캐릭터 추가 작업을 수행하겠습니다.");
	actor_connect(<%=num%>,"<%=userInfo%>");
	</script>
<%
} else {
	// 실패. 다시 actorsearch 창으로 가야 함
%>
	<script>
	alert("배우 추가를 실패했습니다. 다시 시도해주세요");
	window.close();
	</script>
<%
}
%>