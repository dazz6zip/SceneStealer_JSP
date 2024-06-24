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
	private PreparedStatement pstmt;
	private ResultSet rs;
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
		// 시리즈명 중복 가능하므로 검색 결과 여부와 무관하게 무조건 새로 만들기 가능
		String str = keyword + " <a href=\"javascript:series_insert('" + keyword + "')\">새로 만들기 ➕</a><hr>";
		String sql = "select series_title, series_date, series_num from series where series_title like ?";
		// 입력 키워드가 포함된 검색 결과가 있다면, 해당 결과들 편집 옵션 제시
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword.replaceAll(" ", "") + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String seriesInfo = rs.getString(1) + " (" + rs.getString(2) +")"; // 같은 이름의 시리즈 구분하도록 공개일 옆에 적기
				str += seriesInfo + " <a href=\"javascript:series_update('" + rs.getInt(3) + "')\">편집하기 ✏️</a><hr>";
			}
			// 띄어쓰기 해결 필요
		} catch (Exception e) {
			System.out.println("series_suggest err: " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
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
