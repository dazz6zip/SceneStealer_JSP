//사용자에서 상품 처리

function productDetail_guest(pname){ 
	document.detailFrm.no.value = pname;
	document.detailFrm.submit();
}