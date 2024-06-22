package pack.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ActorMgr {
	private Connection conn;
	private PreparedStatement pstmt1, pstmt2;
	private ResultSet rs1, rs2;
	private DataSource ds;

	public ActorMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB connect fail: " + e);
		}
	}

	// 입력 키워드 기반 검색 결과 추천
	public String actor_suggest(String keyword) {
		String str = "";
		String sql = "";
		try {
			conn = ds.getConnection();
			// 입력 키워드와 정확히 일치하는 검색 결과가 없다면, 새로 만들기 옵션 제시
			sql = "select series_title from series where series_title = ?";
			pstmt1 = conn.prepareStatement(sql);
			pstmt1.setString(1, keyword);
			rs1 = pstmt1.executeQuery();
			if (!rs1.next()) str += keyword + " <a href=\"javascript:actor_insert('" + keyword + "')\">새로 만들기</a><hr>";

			// 입력 키워드가 포함된 검색 결과가 있다면, 해당 결과들 편집 옵션 제시
			sql = "select actor_name, actor_num from actor where actor_name like ?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, "%" + keyword + "%");
			rs2 = pstmt2.executeQuery();
			while (rs2.next()) {
				str += rs2.getString(1) + " <a href=\"javascript:actor_update('" + rs2.getInt(2) + "')\">편집하기</a><hr>";
			}
			// 띄어쓰기 해결 필요
		} catch (Exception e) {
			System.out.println("series_suggest err: " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (rs2 != null)
					rs2.close();
				if (pstmt1 != null)
					pstmt1.close();
				if (pstmt2 != null)
					pstmt2.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("cannot close: " + e);
			}
		}
		return str;
	}

}
