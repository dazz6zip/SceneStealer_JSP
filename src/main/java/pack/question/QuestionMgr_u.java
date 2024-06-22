package pack.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.notice.NoticeDto;

public class QuestionMgr_u {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//페이징 처리용
	private int recTot;
	private int pList = 6;
	private int pageSu;
	
	public QuestionMgr_u() {
		try { //DB연결 
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	public ArrayList<QuestionDto> getData(int page, String id){
		ArrayList<QuestionDto> list = new ArrayList<QuestionDto>();
	
		String sql = "select * from question where user_id=?";
				
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//paging 처리
			for(int i=0; i<(page -1)* pList; i++) {
				rs.next();
			}
			int j = 0;
			while(rs.next() && j <pList) {
				QuestionDto qdto = new QuestionDto();
				qdto.setNum(rs.getInt("question_num"));
				qdto.setUser(rs.getString("user_id"));
				qdto.setTitle(rs.getString("question_title"));
				qdto.setPic(rs.getString("question_pic"));
				qdto.setContents(rs.getString("question_contents"));
				qdto.setDate(rs.getString("question_date"));
				qdto.setAnswer_contents(rs.getString("answer_contents"));
				list.add(qdto);
				j++;
				
			}	
		} catch (Exception e) {
			System.out.println("getProductCart err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}	
		return list;
	}
	
	// 새 작성글 번호 
	public int currentMaxNum() {
		String sql = "select max(question_num) from question";
		int question_num = 0;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) question_num = rs.getInt(1); 
		} catch (Exception e) {
			System.out.println("currentMaxNum err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return question_num;
	}
	
	public int getPageSu() {
		pageSu = recTot/pList;
		//짜두리 페이지 하나 늘려
		if(recTot % pList >0) pageSu++;
		return pageSu;
	}
	
	public void totalList(String id) {
		String sql = "select count(*) from question where user_id=?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			recTot = rs.getInt(1);
			System.out.println("전체 레코드 수 : " + recTot);
		} catch (Exception e) {
			System.out.println("getProductCart err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
	public void saveData(QuestionDto qdto) { //데이터 db저장 용
		String sql = "INSERT INTO question(question_num,user_id, question_title, question_pic, question_contents, question_date) values(?,?,?,?,?,now())";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qdto.getNum());
			System.out.println(qdto.getUser());
			pstmt.setString(2, qdto.getUser());
			pstmt.setString(3, qdto.getTitle());
			pstmt.setString(4, qdto.getPic());
			pstmt.setString(5, qdto.getContents());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("saveData err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
	public QuestionDto getData2(String num) { // 글 상세보기 위한 것
		QuestionDto qdto = null;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from question where question_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qdto = new QuestionDto();
				
				qdto.setNum(rs.getInt("question_num"));
				qdto.setUser(rs.getString("user_id"));
				qdto.setTitle(rs.getString("question_title"));
				qdto.setPic(rs.getString("question_pic"));
				qdto.setContents(rs.getString("question_contents"));
				qdto.setDate(rs.getString("question_date"));
				qdto.setAnswer_contents(rs.getString("answer_contents"));
				
			}
			
			//System.out.println(rs.getString("answer_contents"));
		} catch (Exception e) {
			System.out.println("getData2 err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return qdto;
	}
	
	public void saveEdit(QuestionDto qdto) {
		String sql = "UPDATE question SET user_id=?,question_title=?,question_pic=?,question_contents=? WHERE question_num=?";
	
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qdto.getUser());
			pstmt.setString(2, qdto.getTitle());
			pstmt.setString(3, qdto.getPic());
			pstmt.setString(4, qdto.getContents());
			pstmt.setInt(5, qdto.getNum());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("saveEdit err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	
	}
	
	public boolean delData(String num) {
		boolean b= false;
		
		String sql = "delete from question where question_num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			if(pstmt.executeUpdate() >0 ) {
				b  = true;
			}
			
			
		} catch (Exception e) {
			System.out.println("delData err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	// 댓글 쓰기(관리자만 댓글을 쓸수 있게 해야됨) 여기서 안쓰임 일단
	public QuestionDto getReplyData(String num) {
		String sql = "select * from question where question_num=?";
		QuestionDto qdto = null;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qdto = new QuestionDto();
				qdto.setTitle(rs.getString("question_title"));
				qdto.setAnswer_contents("answer_contents");
			}
			
		} catch (Exception e) {
			System.out.println("getReplyData err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return qdto;
		
	}
	
	// 공지사항 글 데이터 받기
	public ArrayList<NoticeDto> getNoticeAll(){
		ArrayList<NoticeDto> list = new ArrayList<NoticeDto>();
		  
		try {
			conn = ds.getConnection();
			String sql = "select * from notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDto ndto = new NoticeDto();
				ndto.setNum(rs.getInt("notice_num"));
				ndto.setTitle(rs.getString("notice_title"));
				ndto.setPic(rs.getString("notice_pic"));
				ndto.setContents(rs.getString("notice_contents"));
				ndto.setDate(rs.getString("notice_date"));
				list.add(ndto);
			}
		} catch (Exception e) {
			System.out.println("getReplyData err: " + e);
		} finally {
			try {
				if(rs !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	// 공지사항 자세히 보기
	public NoticeDto getNotice(String num) {
	    NoticeDto ndto = null;

	    try {
	        conn = ds.getConnection();
	        String sql = "select * from notice where notice_num=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, num);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            ndto = new NoticeDto();
	            ndto.setNum(rs.getInt("notice_num"));
	            ndto.setTitle(rs.getString("notice_title"));
	            ndto.setPic(rs.getString("notice_pic"));
	            ndto.setContents(rs.getString("notice_contents"));
	            ndto.setDate(rs.getString("notice_date"));
	           
	        }
	    } catch (Exception e) {
	        System.out.println("getNotice err: " + e);
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            // TODO: handle exception
	        }
	    }
	    return ndto;
	}

}
