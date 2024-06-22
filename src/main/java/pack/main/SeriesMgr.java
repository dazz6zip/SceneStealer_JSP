package pack.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SeriesMgr {
	private Connection conn;
	private PreparedStatement pstmt, pstmt1, pstmt2;
	private ResultSet rs, rs1, rs2;
	private DataSource ds;
	private String sql;
	
	public SeriesMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB connect fail: " + e);
		}
	}
	
	// 입력 키워드 기반 검색 결과 추천
	public String series_suggest(String keyword){
		String str = "";
		try {
			conn = ds.getConnection();
			// 입력 키워드와 정확히 일치하는 검색 결과가 없다면, 새로 만들기 옵션 제시
			sql = "select series_title from series where series_title = ?";
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, keyword);
			rs1 = pstmt1.executeQuery();
			if(!rs1.next()) str += keyword + " <a href=\"javascript:series_insert('" + keyword + "')\">새로 만들기</a><hr>";
			
			// 입력 키워드가 포함된 검색 결과가 있다면, 해당 결과들 편집 옵션 제시
			sql = "select series_title, series_num from series where series_title like ?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, "%" + keyword + "%");
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				str += rs2.getString(1) + " <a href=\"javascript:series_update('" + rs2.getInt(2) + "')\">편집하기</a><hr>";
			}
			// 띄어쓰기 해결 필요
		} catch (Exception e) {
			System.out.println("series_suggest err: " + e);
		} finally {
			try {
				if(rs1 != null) rs1.close();
				if(rs2 != null) rs2.close();
				if(pstmt1 != null) pstmt1.close();
				if(pstmt2 != null) pstmt2.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				System.out.println("cannot close: " + e);
			}
		}
		return str;
	}
	
	// 시리즈 반환
	public SeriesDto getSeries(String num) {
		SeriesDto s = new SeriesDto();
		try {
			conn = ds.getConnection();
			sql = "select * from series where series_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				s.setNum(rs.getInt(1));
				s.setTitle(rs.getString(2));
				s.setDate(rs.getString(3));
				s.setPic(rs.getString(4));
			}
		} catch (Exception e) {
			System.out.println("getSeries err: " + e);
		} finally {
			try {
				if (rs != null) rs.close();
		        if (pstmt != null) pstmt.close();
		        if (conn != null) conn.close();
			} catch (Exception e) {
				System.out.println("cannot close: " + e);
			}
		}
		return s;
	}
	
	// 시리즈 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		try {
			conn = ds.getConnection();
			sql = "select max(series_num) from series";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) num = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("newNum err: " + e);
		} finally {
			try {
				if (rs != null) rs.close();
		        if (pstmt != null) pstmt.close();
		        if (conn != null) conn.close();
			} catch (Exception e) {
				System.out.println("cannot close: " + e);
			}
		}
		return num + 1;
	}
	
	
	// 시리즈 추가
	public boolean insertSeries(HttpServletRequest request) {
	      boolean b = false;
	      try {
	         String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/series";
	         MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
	         String sql = "INSERT INTO series values(?,?,?,?)";
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, multi.getParameter("num"));
	         pstmt.setString(2, multi.getParameter("title"));
	         pstmt.setString(3, multi.getParameter("date"));
	         
	         if (multi.getFilesystemName("pic") == null) { // 이미지를 선택하지 않은 경우
	            pstmt.setString(4, "ready.jpg");
	         } else { // 선택한 경우
	            pstmt.setString(4, multi.getFilesystemName("pic"));
	         }

	         if (pstmt.executeUpdate() == 1) b = true;
	      } catch (Exception e) {
	         System.out.println("insertSeries err : " + e);
	      } finally {
	         try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	         } catch (Exception e2) {}
	      }
	      return b;
	}
	
	// 시리즈 수정
	public boolean updateSeries(HttpServletRequest request) {
		boolean b = false;
		try {
			String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/series";
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			conn = ds.getConnection();
			
			if (multi.getFilesystemName("pic") == null) {
				String sql = "update series set series_title=?,series_date=? where series_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("title"));
				pstmt.setString(2, multi.getParameter("date"));
				pstmt.setString(3, multi.getParameter("num"));
			} else {
				String sql = "update series set series_title=?,series_date=?,series_pic=? where series_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("title"));
				pstmt.setString(2, multi.getParameter("date"));
				if (multi.getFilesystemName("pic") == null) { // 이미지를 선택하지 않은 경우
					pstmt.setString(3, "ready.jpg");
				} else { // 선택한 경우
					pstmt.setString(3, multi.getFilesystemName("pic"));
				}
				pstmt.setString(4, multi.getParameter("num"));
			}
			if (pstmt.executeUpdate() == 1) b = true;
		} catch (Exception e) {
			System.out.println("updateSeries() err : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return b;
	}
}
