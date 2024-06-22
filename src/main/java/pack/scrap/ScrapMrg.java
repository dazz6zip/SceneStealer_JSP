package pack.scrap;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.main.CharacterDto;
import pack.main.SeriesDto;

public class ScrapMrg {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;


	// DB 연결을 위한 생성자
	public ScrapMrg() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB CONNECT ERROR : " + e.getMessage());
		}
	}
	
	// 특정 유저의 스크랩한 캐릭터 불러오기
	public ArrayList<CharacterDto> getScrapCharacter(String id) {
		ArrayList<CharacterDto> list = new ArrayList<CharacterDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM characters WHERE character_num = (SELECT character_num FROM scrap WHERE user_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			
			while (rs.next()) {
				CharacterDto dto = new CharacterDto();
				dto.setName(rs.getString("character_name"));
				dto.setPic(rs.getString("character_pic"));
				dto.setSeries(rs.getInt("series_num"));
				list.add(dto);
			}
		}catch (Exception e) {
			System.out.println("getScrapCharacter() ERROR : " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				System.out.println("getScrapCharacter() - finally ERROR : " + e2.getMessage());
			}
		}
		
		return list;
	}
	
	// 특정 시리즈 정보 가져오기
	public SeriesDto getScrapSeries(int series_num) {
		SeriesDto dto = null;
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM series WHERE series_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, series_num);
			rs = pstmt.executeQuery();

			
			if (rs.next()) {
				dto = new SeriesDto();
				dto.setTitle(rs.getString("series_title"));
			}
		}catch (Exception e) {
			System.out.println("getScrapSersies() ERROR : " + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e2) {
				System.out.println("getScrapSeries() - finally ERROR : " + e2.getMessage());
			}
		}
		
		return dto;
	}
	
}
