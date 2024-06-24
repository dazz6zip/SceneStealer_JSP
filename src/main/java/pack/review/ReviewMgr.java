package pack.review;

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



public class ReviewMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private int rectot;  		// tot : 전체 레코드 수
 	private int pList = 5;      // 페이지 당 출력 행 수 
 	private int pageSu;  

	
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
	public ArrayList<ReviewDto> reviewAll(String product_name){
		ArrayList<ReviewDto> list = new ArrayList<ReviewDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from review where product_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setUser(rs.getString("user_id"));
				dto.setProduct(rs.getString("product_name"));
				dto.setContents(rs.getString("review_contents"));
				dto.setPic(rs.getString("review_pic"));
				dto.setNum(rs.getInt("review_num"));
				dto.setDate(rs.getString("review_date"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("reviewAll() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return list;
    }
	
    public int newNum() {
        int num = 0;
        try {
           conn = ds.getConnection();
           String sql = "select max(review_num) from review";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           if(rs.next()) num = rs.getInt(1);
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
    
    public boolean insertProduct(HttpServletRequest request) {
    	int newNum = newNum();
        boolean isInserted = false;
        String uploadDir = "C:\\work\\scene_stealer\\src\\main\\webapp\\upload";
        int maxFileSize = 5 * 1024 * 1024; // 5MB

        try {
            MultipartRequest multi = new MultipartRequest(request, uploadDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

            conn = ds.getConnection();
            String sql = "INSERT INTO review(review_num, user_id, product_name, review_contents, review_pic, review_date) " +
                    "VALUES (?, ?, ?, ?, ?, now())";
            pstmt = conn.prepareStatement(sql);

          
            
            pstmt.setInt(1, newNum);

            pstmt.setString(2, multi.getParameter("user"));
            pstmt.setString(3, multi.getParameter("product"));
            pstmt.setString(4, multi.getParameter("contents"));

            // 이미지 파일이 업로드되지 않은 경우 기본 이미지 설정
            String pic = multi.getFilesystemName("pic") == null ? "ready.gif" : multi.getFilesystemName("pic");
            pstmt.setString(5, pic);

            if (pstmt.executeUpdate() > 0) isInserted = true;
        } catch (Exception e) {
            System.out.println("insertProduct() err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println("리소스 해제 중 오류 발생: " + e2);
            }
        }
        return isInserted;
    }
    public boolean updateProduct(HttpServletRequest request) {
		boolean b = false;
		try {
			//업로드할 이미지 경로 : upload 폴더(절대 경로)
	        String uploadDir = "C:\\work\\scene_stealer\\src\\main\\webapp\\upload";
			MultipartRequest multi = new MultipartRequest(request, uploadDir,
								5 * 1014 * 1024, "UTF-8",new DefaultFileRenamePolicy());
	
			conn=ds.getConnection();
			if(multi.getFilesystemName("pic") == null) {
				
			String sql = "update product set product_price=?,product_contents=?,product_stock=?,product_category=? where product_name=?"; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, multi.getParameter("price"));
			pstmt.setString(2, multi.getParameter("contents"));
			pstmt.setString(3, multi.getParameter("stock"));
			pstmt.setString(4, multi.getParameter("category"));
			pstmt.setString(5, multi.getParameter("name"));
				
			
			}else {
				
				String sql ="update product set product_price=?,product_contents=?,product_stock=?,product_category=?,product_pic=? where product_name=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, multi.getParameter("price"));
				pstmt.setString(2, multi.getParameter("contents"));
				pstmt.setString(3, multi.getParameter("stock"));
				pstmt.setString(4, multi.getParameter("category"));
				pstmt.setString(5, multi.getFilesystemName("pic"));
				pstmt.setString(6, multi.getParameter("name"));
			}
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close(); 
			
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return b;
	}
    
 // 특정 리뷰 자세히보기 - 6월 23일 추가
    public ReviewDto getDetailReview(String num) {
        ReviewDto dto = null;
        
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM review WHERE review_num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new ReviewDto();
                dto.setNum(rs.getInt("review_num"));
                dto.setUser(rs.getString("user_id"));
                dto.setProduct(rs.getString("product_name"));
                dto.setContents(rs.getString("review_contents"));
                dto.setPic(rs.getString("review_pic"));
                dto.setDate(rs.getString("review_date"));
            }
        } catch (Exception e) {
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

        return dto;
    }
    
    public void totalList(String id) { // 전체 레코드 수 구하기
		String sql = "select count(*) from review where user_id = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			rectot = rs.getInt(1);
			System.out.println("전체 레코드수 " + rectot);
		} catch (Exception e) {
			System.out.println("totalList() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { 
				
			}
		}
	}
    
    public int getPageSu() { //전체 페이지수 반환
		pageSu = rectot / pList;
		if(rectot % pList > 0) pageSu++; //자투리가 있으면 페이지 하나 플러스
		return pageSu;
	}
    
    public ArrayList<ReviewDto> getReview(String id,int page) {
		ArrayList<ReviewDto> list = new ArrayList<ReviewDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM review WHERE user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			 for(int i=0; i< (page-1)* pList; i++) {
		            rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
		         }
			 int k =0;
			while (rs.next()&& k < pList) {
				ReviewDto dto = new ReviewDto();
				dto.setContents(rs.getString("review_contents"));
				dto.setProduct(rs.getString("product_name"));
				dto.setDate(rs.getString("review_date"));
				dto.setPic(rs.getString("review_pic"));
				dto.setUser(rs.getString("user_id"));
				dto.setNum(rs.getInt("review_num"));
				list.add(dto);
				k++;
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
   
}
