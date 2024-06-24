//사용자에서 상품 처리

function productDetail_guest(pname){ 
	document.detailFrm.name.value = pname;
	document.detailFrm.submit();
}

// 리뷰 상세 보기 - 6월 23일 추가
function reviewDetail(pname){
    document.detailFrm.review_num.value = pname;
    document.detailFrm.submit();
}

