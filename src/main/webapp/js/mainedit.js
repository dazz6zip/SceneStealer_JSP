let checkFirst1 = loopSend1 = false; 
let checkFirst2 = loopSend2 = false; 
let sendFunc; // setTimeout 메소드 처리를 위함
let keyWordSeries, keyWordCharacter; // 검색한 키워드
let para; // get 방식으로 jsp 파일 호출 시 추가될 파라미터
let str; // 긴 innerHTML 처리

$(document).ready(function() {
    // 시리즈
    $("#keywordSeries").on("keydown", startSeries);
    
	$("#keywordSeries").click(function() {
        $("#suggestSeries").hide(); // 검색 이후에도 시리즈 키워드 검색창을 다시 클릭하면 검색 결과는 다시 가려줘야 함
    });
    
    // 배우
    $("#keywordActor").on("keydown", startActor);
    
	$("#keywordActor").click(function() {
        $("#suggestActor").hide(); // 검색 이후에도 시리즈 키워드 검색창을 다시 클릭하면 검색 결과는 다시 가려줘야 함
    });
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
// 조그만 창 닫고 선택한 시리즈 정보를 mainedit에 넘겨줌. 캐릭터 편집 영역 보이게하기
function series_select(num){
	opener.location.href = 'mainedit.jsp?num=' + num;
	window.close();
}

// 캐릭터 추가에서 배우 선택 버튼 클릭 시
//<해당 시리즈 번호>, <해당 캐릭터가 insert될 새 번호> 들고 가서 배우 찾기 창 띄우기
function actor_search(series, character){
	let url="actorsearch.jsp?series=" + series + "&character=" + character;
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


// 팝업창에서 배우를 검색하여 추가/편집 완료 후
// 파라미터: actor_num, actor_name()
// 해당 캐릭터 테이블에 들어갈 배우 번호 저장시키기
// 캐릭터 추가/수정 시 characterproc 파일에서 characters 테이블과 actor_series을 같이 처리
// 이때 필요할 actor_num를 <input type="hidden" name="actor">의 value로 저장해주자
function actor_connect(num){ // 파라미터는 캐릭터번호
	
}


function actor_insert(keyword){
	let url="actorinsert.jsp?name=" + keyword;
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=200,left=100,status=yes,scrollbars=yes,menubar=no");
}

function actor_update(num){
	let url="actorupdate.jsp?num=" + num;
	window.open(url, "get", 
	"toolbar=no, width=500,height=400,top=200,left=100,status=yes,scrollbars=yes,menubar=no");	
}



function style_insert(){
	
}

function style_update(){
	
}

function item_insert(){
	
}

function item_update(){
	
}

