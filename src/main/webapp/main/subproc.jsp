<%@page import="pack.main.ItemDto"%>
<%@page import="pack.main.StyleDto"%>
<%@page import="pack.main.CharacterDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pack.main.MainMgr"></jsp:useBean>

<%
String series_num = request.getParameter("series_num");
String character_name = request.getParameter("character_name");
String id = (String)session.getAttribute("idKey");

CharacterDto cdto = mgr.getCharacterByName(series_num, character_name);
// 들고 온 작품 번호와 배역 이름을 가지고 관련 정보를 가지고 옴
ArrayList<StyleDto> slist = mgr.getStyleData(cdto.getNum());
// 가지고 온 배역 번호를 가지고 관련 스타일 정보를 가지고 옴
boolean scrapCheck = false;
if (id != null) { 
    scrapCheck = mgr.getScrapCheck(id, character_name);
 	// 로그인된 상태일 경우 기존 DB에서 스크랩 여부를 확인함
}

StringBuilder json = new StringBuilder();
json.append("{\"character\": {");
json.append("\"name\": \"").append(cdto.getName()).append("\",");
json.append("\"pic\": \"").append(cdto.getPic()).append("\",");
json.append("\"like\": \"").append(cdto.getLike()).append("\",");
json.append("\"scrapCheck\": ").append(scrapCheck);
json.append("},");

json.append("\"styles\": [");
for (int i = 0; i < slist.size(); i++) {
	// 가지고 온 스타일 정보를 반복문으로 돌리면서
    StyleDto sdto = slist.get(i);
    ArrayList<ItemDto> ilist = mgr.getItemData(sdto.getNum());
    // 해당 스타일에 대한 아이템 정보를 받아옴

    json.append("{");
    json.append("\"pic\": \"").append(sdto.getPic()).append("\",");
    json.append("\"items\": [");
    for (int j = 0; j < ilist.size(); j++) {
        ItemDto idto = ilist.get(j);
        // 받아온 아이템 정보를 json 형식으로 출력하기 위한 구문들
        json.append("{");
        json.append("\"num\": \"").append(idto.getNum()).append("\",");
        json.append("\"pic\": \"").append(idto.getPic()).append("\",");
        json.append("\"product\": \"").append(idto.getProduct()).append("\"");
        json.append("}");
        if (j < ilist.size() - 1) {
            json.append(",");
        }
    }
    json.append("]");
    json.append("}");
    if (i < slist.size() - 1) {
        json.append(",");
    }
}
json.append("]");
json.append("}");

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
out.print(json.toString());
out.flush();
%>