
//관리자에서 상품처리
function productDetail(ss){
	//alert(ss);
	document.detailForm.str.value = ss;
	document.detailForm.submit();
	
}
function productUpdate(name){
	if(confirm("정말 수정할까요?")){
		document.updateForm.name.value = name;
		document.updateForm.submit();
	}
}
function productDelete(name){
	if(confirm("정말 삭제할까요?")){
		document.delForm.name.value = name;
		document.delForm.submit();		
	}
}


