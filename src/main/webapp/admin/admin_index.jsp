<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>
<style>
body {
    margin: 0;
    width: 100%;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
#adminmain {
    position: relative;
    width: 100%;
    height: 100%;
}
img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
</style>
</head>
<body>

	<div id="adminmain">
		<img id="adminImg" src="../image/adminmainphoto-01.png" usemap="#admin">
		<map id="admin" name="admin">
			<!-- Main Edit -->
			<area shape="rect" coords="25,110,615,420" href="../admin/mainedit.jsp" alt="Main Edit">
			<!-- Product Management (Product Upload, Inventory, Edit) -->
			<area shape="rect" coords="620,110,1870,420" href="../admin/productlist.jsp" alt="Product Management">
			<!-- Order Management -->
			<area shape="rect" coords="25,425,615,740" href="../admin/orderlist.jsp" alt="Order Management">
			<!-- Notice Upload -->
			<area shape="rect" coords="630,425,1235,740" href="../admin/noticelist.jsp" alt="Notice Upload">
			<!-- Q&A Answer -->
			<area shape="rect" coords="1235,425,1870,740" href="../admin/questionlist.jsp" alt="Q&A Answer">
		</map>
	</div>

    <script>
    window.onload = function() {
        const img = document.getElementById('adminImg');
        const areas = document.querySelectorAll('area');

        const originalWidth = 1920;  // 원본 이미지의 너비
        const originalHeight = 1080;  // 원본 이미지의 높이

        function resizeMap() {
            const currentWidth = img.clientWidth;
            const currentHeight = img.clientHeight;

            const widthRatio = currentWidth / originalWidth;
            const heightRatio = currentHeight / originalHeight;

            areas.forEach(area => {
                const coords = area.coords.split(',').map(coord => parseInt(coord));
                const resizedCoords = coords.map((coord, index) => {
                    return index % 2 === 0 ? coord * widthRatio : coord * heightRatio;
                });
                area.coords = resizedCoords.join(',');
            });
        }

        window.addEventListener('resize', resizeMap);
        resizeMap();
    };
    </script>
</body>
</html>