let checkFirst1 = loopSend1 = false; 
let checkFirst2 = loopSend2 = false; 
let checkFirst3 = loopSend3 = false; 
let sendFunc; // setTimeout 메소드 처리를 위함
let keyWordSeries, keyWordCharacter; // 검색한 키워드
let para; // get 방식으로 jsp 파일 호출 시 추가될 파라미터
let str; // 긴 innerHTML 처리

$(document).ready(function() {
    // 시리즈
    $("#keywordSeries").on("keydown", startSeries);
    
    // 배우
    $("#keywordActor").on("keydown", startActor);
    
	// 상품
	$("#keywordProduct").on("keydown", startProduct);
});

// 시리즈 검색창 키보드 누를 때마다 호출됨
function startSeries() {
	if (checkFirst1 === false) { // input에서 입력이 시작되고 있다는 것을 의미(빈 상태에서 한 글자 입력)
		sendSeriesFunc = setTimeout("sendSeriesKeyword()", 100); // 0.1초 후 sendkeyword를 호출
		loopSend1 = true;
	}
}

// 시리즈 검색어 추천
function sendSeriesKeyword() {
	keyWordSeries = $("#keywordSeries").val();
	if (keyWordSeries === "") $("#suggestSeries").hide(); 
	else {
		axios.get('searchlist.jsp',{
			params: {option:'series', keyword: keyWordSeries}
		})
		.then(function(response) {
			$("#suggestSeriesList").html(response.data);
        	$("#suggestSeries").show();
		})
		.catch(function(error) {
			console.log("sendSeriesKeyword err: " + error);
		})
	}
	clearTimeout(sendSeriesFunc);
}

// 시리즈 새로 추가
function series_insert(title){
	let url="seriesinsert.jsp?title=" + title;
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=200,left=100,status=yes,scrollbars=yes,menubar=no");	
}

// 시리즈 편집
function series_update(num){
	let url="seriesupdate.jsp?num=" + num;
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=200,left=100,status=yes,scrollbars=yes,menubar=no");
}

// 시리즈 선택
// 조그만 창 닫고 선택한 시리즈 정보를 mainedit에 넘겨줌
// series_num 들고 mainedit 접근 시 캐릭터 편집 페이지 보이게 됨
function series_select(seriesNum){
	opener.location.href = 'mainedit.jsp?series_num=' + seriesNum;
	window.close();
}


// 캐릭터 추가에서 배우 선택 버튼 클릭 시 배우 찾기 창 띄우기
function actor_search(){
	let url="actorsearch.jsp";
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=220,left=100,status=yes,scrollbars=yes,menubar=no");
}

// 배우 검색창 키보드 누를 때마다 호출됨
function startActor() {
	if (checkFirst2 === false) { // input에서 입력이 시작되고 있다는 것을 의미(빈 상태에서 한 글자 입력)
		sendActorFunc = setTimeout("sendActorKeyword()", 100); // 0.1초 후 sendkeyword를 호출
		loopSend2 = true;
	}
}

// 배우 검색어 추천
function sendActorKeyword() {
	keyWordActor = $("#keywordActor").val();
	if (keyWordActor === "") $("#suggestActor").hide(); 
	else {
		axios.get('searchlist.jsp',{
			params: {option:'actor', keyword: keyWordActor}
		})
		.then(function(response) {
			$("#suggestActorList").html(response.data);
        		$("#suggestActor").show();
		})
		.catch(function(error) {
			console.log("sendActorKeyword err: " + error);
		})
	}
	clearTimeout(sendActorFunc);
}

// 배우 추가
function actor_insert(keyword){
	location.href="actorinsert.jsp?name=" + keyword;
}

// 팝업창에서 배우를 검색하여 추가/선택(수정안됨) 완료 후
// 해당 캐릭터 테이블에 들어갈 배우 번호 저장시키기
// 캐릭터 추가 시 characterproc 파일에서 characters 테이블과 *actor_series*을 같이 처리
// 이때 필요할 actor_num를 <input type="hidden" name="actor">의 value로 저장해주자
function actor_connect(num, actorInfo){ // 파라미터는 배우 번호
	// 해당 캐릭터 폼 태그의 배우번호 요소에 num주고, 연결된배우 val에 actorInfo 들어가게 하기
	console.log("ok");
	opener.document.forms["frm"].elements["selectedActorInfo"].value = actorInfo;
	opener.document.forms["frm"].elements["actor"].value = num;
	window.close();
}


// 캐릭터 선택
// 선택한 캐릭터 정보를 mainedit에 넘겨줌
// character_num 들고 mainedit 접근 시 스타일 편집 페이지 보이게 됨
function character_select(characterNum){
	if(opener!==null){ // 캐릭터 추가 시엔 팝업 창으로 작업했으므로 오프너 존재
		opener.location.href = 'mainedit.jsp?character_num=' + characterNum;
		window.close();
	} else { // 캐릭터 수정 시엔 현재 창에서
		location.href = 'mainedit.jsp?character_num=' + characterNum;
	}
}

// 스타일 선택
// 선택한 스타일 정보를 mainedit에 넘겨줌
// style_num 들고 mainedit 접근 시 아이템 편집 페이지 보이게 됨
function style_select(styleNum){
	location.href = 'mainedit.jsp?style_num=' + styleNum;
}

// 아이템 추가에서 상품 선택 버튼 클릭 시 상품 찾기 창 띄우기
function product_search(){
	let url="productsearch.jsp";
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=220,left=100,status=yes,scrollbars=yes,menubar=no");
}

// 상품 검색창 키보드 누를 때마다 호출됨
function startProduct() {
	if (checkFirst3 === false) { // input에서 입력이 시작되고 있다는 것을 의미(빈 상태에서 한 글자 입력)
		sendProductFunc = setTimeout("sendProductKeyword()", 100); // 0.1초 후 sendkeyword를 호출
		loopSend3 = true;
	}
}

// 상품 검색어 추천
function sendProductKeyword() {
	keyWordProduct = $("#keywordProduct").val();
	if (keyWordProduct === "") $("#suggestProduct").hide(); 
	else {
		axios.get('searchlist.jsp',{
			params: {option:'product', keyword: keyWordProduct}
		})
		.then(function(response) {
			$("#suggestProductList").html(response.data);
        		$("#suggestProduct").show();
		})
		.catch(function(error) {
			console.log("sendProductKeyword err: " + error);
		})
	}
	clearTimeout(sendProductFunc);
}


// 팝업창에서 상품을 검색하여 선택 완료 후
// 해당 아이템 테이블에 들어갈 상품명 저장시키기
function product_connect(productName){ // 파라미터는 상품명
	// 해당 아이템 폼 태그의 상품명 요소에 productName주기
	opener.document.forms["frm2"].elements["product"].value = productName;
	window.close();
}

function item_insert(){
	
}

