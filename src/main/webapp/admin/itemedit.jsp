<%@page import="pack.main.ItemDto"%>
<%@page import="pack.main.StyleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 아이템은 수정불가이므로 추가처리만 해주는 파일
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="styleMgr" class="pack.main.StyleMgr" />
<jsp:useBean id="itemMgr" class="pack.main.ItemMgr" />
<!-- mainedit에 스타일 선택 후 include되는 파일 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="../js/mainedit.js"></script>

</head>
<body>
<%
	String style_num = request.getParameter("style_num"); 
	StyleDto style = styleMgr.getStyle(style_num); // 선택한 스타일의 정보를 보여주기 위함
	ItemDto[] ilist = itemMgr.getAllItem(style_num);
%>
<h4>3️⃣Style 선택완료</h4>

<h2>4️⃣Item & Product</h2>
<table>
	<tr>
		<td colspan="3">
		<img src="../upload/style/<%=style.getPic() %>">
		</td>
	</tr>
	<tr>	
<%
for(int i=0; i<3; i++){
	ItemDto item = ilist[i];
	if(item==null){
		int newNum = itemMgr.newNum(); // insert 시 저장될 PK item_num;		
%>
		<td>
		<form name="frm2" action="itemproc.jsp?num=<%=newNum %>" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td colspan="2"><b>➕<%=i+1 %>번째 아이템 추가하기</b></td>
			</tr>
			<tr>
				<td>연결 상품</td>
				<td>
					<input type="text" name="product" id="connectedProduct" readonly>
					<input type="button" onclick="product_search()" value="연결할 상품 찾기">
				</td>
			</tr>
			<tr>
				<td>아이템 사진</td>
				<td><input type="file" name="pic"></td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=newNum %>">
		<input type="hidden" name="style" value="<%=style_num %>">
		<input type="submit" value="아이템 추가">
		</form>
		<hr>
		</td>
<%
	} else {
		// 아이템은 수정 불가. 조회만
%>
		<td>
		<table>
			<tr>
				<td>
					<b>🎁<%=i+1 %>번째 아이템</b>
				</td>
			</tr>
			<tr>
				<td>
					<img src="../upload/item/<%=item.getPic() %>">
				</td>
			</tr>
			<tr>
				<td>
					연결 상품: <a href="productdetail.jsp?str=<%=item.getProduct()%>"><%=item.getProduct() %></a>
				</td>
			</tr>
			</table>
			<hr>
		</td>
<%
	}
}
%>
	</tr>
</table>
</body>
</html>