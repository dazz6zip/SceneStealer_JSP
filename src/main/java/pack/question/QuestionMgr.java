package pack.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QuestionMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private int recTot; //전체 레코드 수
	private int pList=5; //페이지당 출력 행수
	private int pageSu; //전페 페이지수
	
	public QuestionMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("Db 연결 실패:"+e);
		}
	}
	
	// 페이지별로 들어갈 레코드 리스트 반환
	public ArrayList<QuestionDto> getDataAll(String type, int page){ // type: 조회옵션(전체보기/미답변글보기)	
		ArrayList<QuestionDto> list = new ArrayList<QuestionDto>();
		String sql = "select * from question";
		if(type.equals("answered")) sql += " where answer_contents is not null";
		else if(type.equals("unanswered")) sql += " where answer_contents is null";
		sql += " order by question_num desc";
		try {
			conn = ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt= conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			//페이징처리
			for(int i=0; i< (page-1)* pList; i++) {
				rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
			}
			
			int k =0;
			while(rs.next()&& k<pList) {
				QuestionDto dto = new QuestionDto();
				dto.setNum(rs.getInt(1));
				dto.setUser(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setPic(rs.getString(4));
				dto.setContents(rs.getString(5));
				dto.setDate(rs.getString(6));
				dto.setAnswer_contents(rs.getString(7));
				list.add(dto);
				k++;	
			}
		} catch (Exception e) {
			System.out.println("getDataAll() err:"+e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	// 전체 레코드 수를 구해서 지정한 페이지당 개수로 나눠 전체 페이지 수 반환
	public int getTotalPage(String type) { // type: 조회옵션(전체보기/미답변글보기)
		String sql = "select count(*) from question";
		if(type.equals("answered")) sql += " where answer_contents is not null";
		else if(type.equals("unanswered")) sql += " where answer_contents is null";
		try {
			conn= ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			recTot = rs.getInt(1);
			pageSu = recTot / pList;
			if(recTot % pList > 0) pageSu++;
		} catch (Exception e) {
			System.out.println("getTotalPage err: "+e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				
			}
		}
		return pageSu;
	}
		

	// url로 찍고 들어오는 상황을 방지. 글 클릭 시 접근 가능하도록 함
	public QuestionDto getData(int num) {
		String sql = "select * from question where question_num=?";
		QuestionDto dto = null;
		try {
			conn=ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new QuestionDto();
				dto.setNum(rs.getInt(1));
				dto.setUser(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setPic(rs.getString(4));
				dto.setContents(rs.getString(5));
				dto.setDate(rs.getString(6));
				dto.setAnswer_contents(rs.getString(7));
			}	
		} catch (Exception e) {
			System.out.println("getData err: "+e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				
			}
		}	
		return dto;	
	}	
	
	public int answerUpdate(int num, String answer) {
		int result = 0;
		String sql = "update question set answer_contents=? where question_num=?";
		try {
			conn=ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, answer);
			pstmt.setInt(2, num);
			result = pstmt.executeUpdate();	
		} catch (Exception e) {
			System.out.println("answerUpdate err: "+e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				
			}
		}
		
		
		return result;
	}	
}
