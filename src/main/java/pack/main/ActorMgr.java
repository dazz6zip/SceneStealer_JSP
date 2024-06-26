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
		// 배우명 중복 가능하므로 검색 결과 여부와 무관하게 무조건 새로 만들기 가능
		String str = keyword + " <a href=\"javascript:actor_insert('" + keyword + "')\">새로 만들기 ➕</a><hr>";
		String sql = "select actor_name, actor_birth, actor_num from actor where actor_name like ?";
		// 입력 키워드가 포함된 검색 결과가 있으면 선택 가능
		try (Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, "%" + keyword.replaceAll(" ", "") + "%");
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					String actorInfo = rs.getString(1) + " (" + rs.getString(2) +")"; // 배우 이름과 배우 생일을 같이 뜨게 해서 동명이인 구분 가능하도록
					str += actorInfo + " <a href=\"javascript:actor_connect('" + rs.getInt(3) + "','" + actorInfo + "')\">선택하기 ✔️</a><hr>";
				}
			}	
		} catch (Exception e) {
			System.out.println("actor_suggest err: " + e);
		} 
		return str;
	}
	
	// actor 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		String sql = "select max(actor_num) from actor";
		try (Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) num = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("newNum err: " + e);
		}
		return num + 1;
	}
	
	// actor 추가
	public boolean insertActor(ActorBean actor) {
		boolean b = false;
		String sql = "INSERT INTO actor values(?,?,?)";
		try (Connection conn = ds.getConnection(); 
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, actor.getNum());
				pstmt.setString(2, actor.getName());
				pstmt.setString(3, actor.getBirth());
				if (pstmt.executeUpdate() == 1) b = true;
		} catch (Exception e) {
			System.out.println("insertActor err : " + e);
		}
		return b;
	}
	
	// character 추가 시 비로소 character와 연결되는 동시에 (FK로 actor_num 가지므로)
	// series_actor 테이블에 관계를 저장하여 유저 파트 개발자에서 코드 구현이 용이하도록 함
	public boolean connectSeries(String num) {
		boolean b = false;
		String sqlA = "select series_num, actor_num from characters where character_num = ?";
		try (Connection conn = ds.getConnection();
			 PreparedStatement pstmtA = conn.prepareStatement(sqlA)){
				 pstmtA.setString(1, num);
				 try(ResultSet rsA = pstmtA.executeQuery()){
					 if(rsA.next()) {
						 String sqlB = "insert into series_actor values(?,?)";
						 try(PreparedStatement pstmtB = conn.prepareStatement(sqlB)){
							 pstmtB.setInt(1, rsA.getInt(1));
							 pstmtB.setInt(2, rsA.getInt(2));				 
							 if (pstmtB.executeUpdate() == 1) b = true;
						 }
					 }
			}
		} catch (Exception e) {
			System.out.println("connectSeries err : " + e);
		}
		return b;
	}

}
