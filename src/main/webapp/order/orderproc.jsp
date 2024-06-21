<%@page import="pack.orders.OrdersDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="odto" class="pack.orders.OrdersDto" />
<jsp:useBean id="opdto" class="pack.orders.Order_productDto" />

<%
ArrayList<OrdersDto> list = new ArrayList<OrdersDto>();


%>