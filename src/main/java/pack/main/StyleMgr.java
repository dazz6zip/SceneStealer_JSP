package pack.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class StyleMgr {
private DataSource ds;
	
	public StyleMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB connect fail: " + e);
		}
	}
	
	// 캐릭터 번호 받아서 해당 캐릭터의 스타일 목록 반환
	public ArrayList<StyleDto> getAllStyle(String num){
		ArrayList<StyleDto> list = new ArrayList<StyleDto>();
		String sql = "select * from style where character_num = ?";
		try(Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, num);
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()){
					StyleDto dto = new StyleDto();
					dto.setNum(rs.getInt(1));
					dto.setCharacter(rs.getInt(2));
					dto.setPic(rs.getString(3));
					list.add(dto);
				}
			}			
		} catch (Exception e) {
			System.out.println("getAllStyle err: " + e);
		}
		return list;
	}
	
	// 스타일 번호 받아서 해당 스타일 정보 반환
	public StyleDto getStyle(int num){
		StyleDto s = new StyleDto();
		String sql = "select * from style where style_num = ?";
		try(Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, num);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()){
					s.setNum(rs.getInt(1));
					s.setCharacter(rs.getInt(2));
					s.setPic(rs.getString(3));
				}
			}			
		} catch (Exception e) {
			System.out.println("getStyle err: " + e);
		}
		return s;
	}
	
	// style 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		String sql = "select max(style_num) from style";
		try (Connection conn = ds.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rs = pstmt.executeQuery()) {
			 if (rs.next()) num = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("newNum err: " + e);
		}
		return num + 1;
	}
	
	// style 추가
	public boolean insertStyle(HttpServletRequest request) {
		boolean b = false;
		String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/style";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8",
					new DefaultFileRenamePolicy());
			String sql = "INSERT INTO style values(?,?,?)";
			try (Connection conn = ds.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, multi.getParameter("num"));
				pstmt.setString(2, multi.getParameter("character"));
				if (multi.getFilesystemName("pic") == null) pstmt.setString(3, "ready.jpg");
				else pstmt.setString(3, multi.getFilesystemName("pic"));
				if (pstmt.executeUpdate() == 1) b = true;
			}
		} catch (Exception e) {
			System.out.println("insertStyle err : " + e);
		}
		return b;
	}
	
	// style 수정
	// character 수정 (대표사진)
	public boolean updateStyle(HttpServletRequest request) {
		boolean b = false;
		String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/style";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8",
					new DefaultFileRenamePolicy());
			if (multi.getFilesystemName("pic") == null) {
				b = true; // 수정할 사진 선택 안했으면 업데이트 처리 완료로 바로 처리
			} else {
				String sql = "update style set style_pic=? where style_num=?";
				try (Connection conn = ds.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
					pstmt.setString(1, multi.getFilesystemName("pic"));
					pstmt.setString(2, multi.getParameter("num"));
					if (pstmt.executeUpdate() == 1)
						b = true;
				}
			}
		} catch (Exception e) {
			System.out.println("updateStyle err : " + e);
		}
		return b;
	}
	
	// 스타일 반환
	public StyleDto getStyle(String num) {
		StyleDto s = new StyleDto();
		String sql = "select * from style where style_num = ?";
		try(Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					s.setNum(rs.getInt(1));
					s.setCharacter(rs.getInt(2));
					s.setPic(rs.getString(3));
				}
			}
		} catch (Exception e) {
			System.out.println("getStyle err: " + e);
		}
		return s;
	}
}
