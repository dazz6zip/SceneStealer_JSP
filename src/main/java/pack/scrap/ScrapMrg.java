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
	
	private int recTot; // 전체 레코드 수
	private int pList = 4; // 페이지당 출력할 레코드 수
	private int pageSu; // 전체 페이지 수


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
	public ArrayList<CharacterDto> getScrapCharacter(String id, int page) {
		ArrayList<CharacterDto> list = new ArrayList<CharacterDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM characters WHERE character_num in (SELECT character_num FROM scrap WHERE user_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			for (int i = 0; i < (page - 1) * pList; i++) {
				rs.next(); // 레코드 포인터 이동
			}

			int k = 0;
			while (rs.next() && k < pList) {
				CharacterDto dto = new CharacterDto();
				dto.setName(rs.getString("character_name"));
				dto.setPic(rs.getString("character_pic"));
				dto.setSeries(rs.getInt("series_num"));
				dto.setNum(rs.getInt("character_num"));
				list.add(dto);
				k++;
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
	
	public boolean dropScrap(String cnum, String unum) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "DELETE FROM scrap WHERE character_num = ? AND user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cnum);
			pstmt.setString(2, unum);
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}
			

		}catch (Exception e) {
			System.out.println("dropScrap() ERROR : " + e);
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
				System.out.println("dropScrap() - finally ERROR : " + e2.getMessage());
			}
		}
		
		return b;
	}
	
	public void totalList(String id) { // 전체 레코드 수 구하기
		try {
			conn = ds.getConnection();
			String sql = "SELECT COUNT(*) FROM scrap WHERE user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			recTot = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("totalList() ERROR : " + e.getMessage());
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
				System.out.println("totalList() - finally ERROR : " + e2.getMessage());
			}
		}
	}

	public int getPageSu() { // 전체 페이지 수 반환
		pageSu = recTot / pList;
		if (recTot % pList > 0) {
			pageSu++;
		}
		return pageSu;
	}

	
	
	
}
