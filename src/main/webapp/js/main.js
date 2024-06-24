function mainreview(review_num) {
	document.mainFrm2.review_num.value = review_num;
	document.mainFrm2.submit();
}

function searchSeriesClick(title, num){
	document.sscFrm.series_title.value = title;
	document.sscFrm.series_num.value = num;
	document.sscFrm.submit();
}