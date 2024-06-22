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

public class CharacterMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public CharacterMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB connect fail: " + e);
		}
	}
	
	// 시리즈 번호 받아서 해당 시리즈의 캐릭터들 반환
	// 한 시리즈 내의 캐릭터는 4개로 고정
	// 존재하는 캐릭터 수만큼 CharacterDto를 담아주고, 나머지는 null이 저장됨
	// (ArrayList가 아닌 Array를 해야 크기가 고정돼서 null이 담김)
	public CharacterDto[] getAllCharacters(String num){
		CharacterDto[] array = new CharacterDto[4];
		String sql = "select * from characters where series_num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			for(int i=0; i<4; i++) {
				if(rs.next()){
					CharacterDto dto = new CharacterDto();
					dto.setNum(rs.getInt(1));
					dto.setName(rs.getString(2));
					dto.setLike(rs.getInt(3));
					dto.setPic(rs.getString(4));
					dto.setActor(rs.getInt(5));
					dto.setSeries(rs.getInt(6));
					array[i] = dto;
				}
			}
		} catch (Exception e) {
			System.out.println("getAllCharacters err: " + e);
		} finally {
			try {
				if (rs != null) rs.close();
		        if (pstmt != null) pstmt.close();
		        if (conn != null) conn.close();
			} catch (Exception e) {
				System.out.println("cannot close: " + e);
			}
		}
		return array;
	}
	
	// 이미 존재하는 캐릭터의 번호를 통해 해당 actor의 데이터 정보를 넘겨주기
	public ActorDto getActor(int num) {
		String sql = "select actor.actor_num, actor_name, actor_birth from characters inner join actor"
				+ " on characters.actor_num = actor.actor_num where character_num=?";
		ActorDto actor = new ActorDto();
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				actor.setNum(rs.getInt(1));
				actor.setName(rs.getString(2));
				actor.setBirth(rs.getString(3));
			}
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
		return actor;
	}
	
	
	// characters 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		String sql = "select max(character_num) from characters";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) num = rs.getInt(1);
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
	
	// character 추가
	public boolean insertCharacter(HttpServletRequest request) {
	      boolean b = false;
	      try {
	         String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/character";
	         MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
	         String sql = "INSERT INTO characters(character_num, character_name, character_pic, actor_num, series_num) values(?,?,?,?,?)";
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, multi.getParameter("num"));
	         pstmt.setString(2, multi.getParameter("name"));
	         
	         if (multi.getFilesystemName("pic") == null) pstmt.setString(3, "ready.jpg");
	         else pstmt.setString(3, multi.getFilesystemName("pic"));
	         
	         pstmt.setString(4, multi.getParameter("actor"));
	         pstmt.setString(5, multi.getParameter("series"));

	         if (pstmt.executeUpdate() == 1) b = true;
	      } catch (Exception e) {
	         System.out.println("insertCharacter err : " + e);
	      } finally {
	         try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	         } catch (Exception e2) {}
	      }
	      return b;
	}
	
	// character 수정
	public boolean updateCharacter(HttpServletRequest request) {
		boolean b = false;
		try {
			String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/character";
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8",
					new DefaultFileRenamePolicy());
			conn = ds.getConnection();

			if (multi.getFilesystemName("pic") == null) {
				String sql = "update characters set character_name=? where character_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("num"));
			} else {
				String sql = "update characters set character_name=?,character_pic=? where character_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				if (multi.getFilesystemName("pic") == null) { // 이미지를 선택하지 않은 경우
					pstmt.setString(2, "ready.jpg");
				} else { // 선택한 경우
					pstmt.setString(2, multi.getFilesystemName("pic"));
				}
				pstmt.setString(3, multi.getParameter("num"));
			}
			if (pstmt.executeUpdate() == 1) b = true;
		} catch (Exception e) {
			System.out.println("updateCharacter err : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
		}
		return b;
	}

}
