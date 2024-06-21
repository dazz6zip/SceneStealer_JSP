<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	
    
    String user_id = request.getParameter("user_id");

    try {
        // JDBC 드라이버 로드
        Class.forName("org.mariadb.jdbc.Driver");

        // 데이터베이스 연결 설정
        String url = "jdbc:mariadb://localhost:3306/sample";
        conn = DriverManager.getConnection(url, "root", "0205");

        // SQL 쿼리 작성 (아이디 중복 체크)
        String checkSql = "SELECT COUNT(*) FROM user WHERE user_id = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, user_id);
        rs = pstmt.executeQuery();

        // JSON 응답 설정
        response.setContentType("application/json");

        // 결과 처리
        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                out.print("{\"result\": \"duplicate\"}");
            } else {
                out.print("{\"result\": \"not_duplicate\"}");
            }
        }
    } catch (SQLException e) {
    	System.out.println("DB err: " + e);
    } finally {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e2) {
			// TODO: handle exception
		}
	}
    out.flush();	// 버퍼를 비우고 데이터를 클라이언트로 즉시 전송
%>