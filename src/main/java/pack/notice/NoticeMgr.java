package pack.notice;

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

import pack.question.QuestionDto;

public class NoticeMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private int recTot; //전체 레코드 수
	private int pList=10; //페이지당 출력 행수
	private int pageSu; //전페 페이지수
	
	NoticeDto dto;
	
	public NoticeMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("Db 연결 실패:"+e);
		}
	}
	
	// 페이지별로 들어갈 레코드 리스트 반환
	public ArrayList<NoticeDto> getDataAll(int page){	
		ArrayList<NoticeDto> list = new ArrayList<NoticeDto>();
		String sql = "select * from notice order by notice_num desc";
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
				dto = new NoticeDto();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setPic(rs.getString(3));
				dto.setContents(rs.getString(4));
				dto.setDate(rs.getString(5));
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
	public int getTotalPage() {
		String sql = "select count(*) from notice";
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
	public NoticeDto getData(String num) {
		String sql = "select * from notice where notice_num=?";
		try {
			conn=ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDto();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setPic(rs.getString(3));
				dto.setContents(rs.getString(4));
				dto.setDate(rs.getString(5));
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
	
	// notice 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		String sql = "select max(notice_num) from notice";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				num = rs.getInt(1);
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

	// notice 추가
	public boolean insertNotice(HttpServletRequest request) {
	      boolean b = false;
	      try {
	         String uploadDir = "C:\\Users\\dazz6\\OneDrive\\Desktop\\study\\study\\scenestealer\\src\\main\\webapp\\upload";
	         MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
	         String sql = "insert into notice values(?,?,?,?,now())";
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, multi.getParameter("num"));
	         pstmt.setString(2, multi.getParameter("title"));
	         // 이미지 처리
	         if (multi.getFilesystemName("pic") == null) pstmt.setString(3, "ready.jpg");
		     else pstmt.setString(3, multi.getFilesystemName("pic"));
	         pstmt.setString(4, multi.getParameter("contents"));

	         if (pstmt.executeUpdate() == 1) b = true;
	      } catch (Exception e) {
	         System.out.println("insertNotice() err : " + e);
	      } finally {
	         try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	         } catch (Exception e2) {}
	      }

	      return b;
	}
	
	// notice 수정
	public boolean updateNotice(HttpServletRequest request) {
		boolean b = false;
		try {
			String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload";
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
			conn = ds.getConnection();
			if (multi.getFilesystemName("pic") == null) {
				String sql = "update notice set notice_title=?,notice_contents=? where notice_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("title"));
				pstmt.setString(2, multi.getParameter("contents"));
				pstmt.setString(3, multi.getParameter("num"));
			} else { // pic까지 고쳤으면 그것도 업뎃
				String sql = "update notice set notice_title=?,notice_contents=?,notice_pic=? where notice_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("title"));
				pstmt.setString(2, multi.getParameter("contents"));
				pstmt.setString(3, multi.getFilesystemName("pic"));	
				pstmt.setString(4, multi.getParameter("num"));			
			}
			if (pstmt.executeUpdate() == 1) b = true;
		} catch (Exception e) {
			System.out.println("updateNotice() err : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return b;
	}
	
	
	// notice 삭제
	public boolean deleteNotice(String num) {
		boolean b = false;
		String sql = "delete from notice where notice_num = ?";
		try {
			conn=ds.getConnection();
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, num);
			if(pstmt.executeUpdate() == 1) b = true;	
		} catch (Exception e) {
			System.out.println("deleteNotice err: "+e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				
			}
		}
		return b;
	}
	
}
