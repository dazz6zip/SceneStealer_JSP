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
ArrayList<StyleDto> slist = mgr.getStyleData(cdto.getNum());
boolean scrapCheck = false;
if (id != null) {
    scrapCheck = mgr.getScrapCheck(id, character_name);
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
    StyleDto sdto = slist.get(i);
    ArrayList<ItemDto> ilist = mgr.getItemData(sdto.getNum());

    json.append("{");
    json.append("\"pic\": \"").append(sdto.getPic()).append("\",");
    json.append("\"items\": [");
    for (int j = 0; j < ilist.size(); j++) {
        ItemDto idto = ilist.get(j);
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