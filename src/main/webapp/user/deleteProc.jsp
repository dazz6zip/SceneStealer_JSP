<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    String user_id = request.getParameter("user_id");
    String user_pwd = request.getParameter("user_pwd");

    try {
        // JDBC 드라이버 로드
        Class.forName("org.mariadb.jdbc.Driver");

        // 데이터베이스 연결 설정
        String url = "jdbc:mariadb://localhost:3306/ptest";
        conn = DriverManager.getConnection(url, "root", "9112");

        // SQL 쿼리 작성 (아이디 중복 체크)
        String sql = "UPDATE user SET user_pwd = NULL WHERE user_id = ? AND user_pwd = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, user_id);
        pstmt.setString(2, user_pwd);

        // 쿼리 실행
        int rowCount = pstmt.executeUpdate();

        // JSON 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 결과 처리
        if (rowCount > 0) {
            out.print("{\"result\": \"success\"}");
            session.removeAttribute("idKey");
        } else {
            out.print("{\"result\": \"invalid\"}");
        }
    } catch (SQLException e) {
        System.out.println("DB err: " + e);
        out.print("{\"result\": \"error\"}");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e2) {
            // 예외 처리
        }
    }
    out.flush(); // 버퍼를 비우고 데이터를 클라이언트로 즉시 전송
%>