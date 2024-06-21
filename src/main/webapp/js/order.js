function orderinfo (num, state) {
	document.orderFrm.orders_num.value = num;
	document.orderFrm.orders_state.value = state;
	document.orderFrm.submit();
}

function newReview (name) {
	document.detailFrm.product_name.value = name;
	document.detailFrm.submit();
}

function orderDelete(num, name) {
	document.orderflagFrm.flag.value = 'delete';
	document.orderflagFrm.orders_num.value = num;
	document.orderflagFrm.product_name.value = name;
	document.orderflagFrm.submit();
	
}
function orderRefund(num, name) {
	document.orderflagFrm.flag.value = 'refund';
	document.orderflagFrm.orders_num.value = num;
	document.orderflagFrm.product_name.value = name;
	document.orderflagFrm.submit();
}

function orderReturn(num, name) {
	document.orderflagFrm.flag.value = 'return';
	document.orderflagFrm.orders_num.value = num;
	document.orderflagFrm.product_name.value = name;
	document.orderflagFrm.submit();
}

