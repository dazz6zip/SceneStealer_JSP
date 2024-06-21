package pack.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class ReviewMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;

	
	// DB 연결을 위한 생성자
	public ReviewMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB CONNECT ERROR : " + e.getMessage());
		}
	}
	
	// 특정 유저의 리뷰 받아오기
	public ArrayList<ReviewDto> getReview(String id) {
		ArrayList<ReviewDto> list = new ArrayList<ReviewDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM review WHERE user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setContents(rs.getString("review_contents"));
				dto.setProduct(rs.getString("product_name"));
				dto.setDate(rs.getString("review_date"));
				dto.setPic(rs.getString("review_pic"));
				dto.setUser(rs.getString("user_id"));
				dto.setNum(rs.getInt("review_num"));
				list.add(dto);
			}
		}catch (Exception e) {
			System.out.println("getReviewAll() ERROR : " + e);
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
				System.out.println("getReviewAll() - finally ERROR : " + e2.getMessage());
			}
		}

		return list;
	}
	
	// 특정 리뷰 삭제하기
	public boolean delReview(String review_num) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "DELETE FROM review WHERE review_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review_num);
			if (pstmt.executeUpdate() > 0) {
				b = true;
			}
			
			
		}catch (Exception e) {
			System.out.println("delReview() ERROR : " + e);
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
				System.out.println("delReview() - finally ERROR : " + e2.getMessage());
			}
		}
		
		return b;
	}
}
