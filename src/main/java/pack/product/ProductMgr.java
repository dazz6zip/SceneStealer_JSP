package pack.product;

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

public class ProductMgr {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;
 // paging 처리
 	private int rectot;  		// tot : 전체 레코드 수
 	private int pList = 10;      // 페이지 당 출력 행 수 
 	private int pageSu;         // 전체 페이지 수 
    
    public ProductMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("DB 연결 실패 : " + e);
        }
    }
    public ArrayList<ProductDto> getProductAll(){
 		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
 		try {
 			conn = ds.getConnection();
 			String sql = "select * from product";
 			
 			
 			pstmt = conn.prepareStatement(sql);
 			
 			rs=pstmt.executeQuery();
 			
 			 
 			while(rs.next() ) {
 				ProductDto dto = new ProductDto();
 				dto.setName(rs.getString(1));
 				dto.setPic(rs.getString(2));
 				dto.setPrice(rs.getInt(3));
 				dto.setContents(rs.getString(4));
 				dto.setStock(rs.getInt(5));
 				dto.setDate(rs.getString(6));
 				dto.setCategory(rs.getString(7));
 				list.add(dto);
 				
 			}
 			
 		} catch (Exception e) {
 			System.out.println("getProductAll() err : " + e);
 		} finally {
 			try {
 				if(rs != null) rs.close();
 				if(pstmt != null) pstmt.close();
 				if(conn != null) conn.close();
 			} catch (Exception e2) { }
 		}
 		return list;
 	} 
    public ArrayList<ProductDto> getProductAll(int page){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from product";
			
			
			pstmt = conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			 for(int i=0; i< (page-1)* pList; i++) {
		            rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
		         }
			 int k =0;
			while(rs.next() && k < pList) {
				ProductDto dto = new ProductDto();
				dto.setName(rs.getString(1));
				dto.setPic(rs.getString(2));
				dto.setPrice(rs.getInt(3));
				dto.setContents(rs.getString(4));
				dto.setStock(rs.getInt(5));
				dto.setDate(rs.getString(6));
				dto.setCategory(rs.getString(7));
				list.add(dto);
				k++;
			}
			
		} catch (Exception e) {
			System.out.println("getProductAll() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return list;
	} 
    public ArrayList<ProductDto> getProductAll(int page, String category){
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "select * from product where product_category=?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
		
			rs=pstmt.executeQuery();
			
			 for(int i=0; i< (page-1)* pList; i++) {
		            rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
		         }
			 int k =0;
			while(rs.next() && k < pList) {
				ProductDto dto = new ProductDto();
				dto.setName(rs.getString(1));
				dto.setPic(rs.getString(2));
				dto.setPrice(rs.getInt(3));
				dto.setContents(rs.getString(4));
				dto.setStock(rs.getInt(5));
				dto.setDate(rs.getString(6));
				dto.setCategory(rs.getString(7));
				list.add(dto);
				k++;
			}
			
		} catch (Exception e) {
			System.out.println("getProductAll() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return list;
	} 


    public boolean insertProduct(HttpServletRequest request) {
        boolean isInserted = false;
        String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/product";
        int maxFileSize = 5 * 1024 * 1024; // 5MB

        try {
            MultipartRequest multi = new MultipartRequest(request, uploadDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

            conn = ds.getConnection();
            String sql = "INSERT INTO product(product_name,product_price,product_contents,product_stock,product_date,product_category,product_pic) values(?, ?, ?, ?, now(), ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, multi.getParameter("name"));
            pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
           
            pstmt.setString(3, multi.getParameter("contents"));
            pstmt.setInt(4,Integer.parseInt( multi.getParameter("stock")));
            pstmt.setString(5, multi.getParameter("category"));

            // 이미지 파일이 업로드되지 않은 경우 기본 이미지 설정
            String pic = multi.getFilesystemName("pic") == null ? "ready.gif" : multi.getFilesystemName("pic");
            pstmt.setString(6, pic);

            if (pstmt.executeUpdate() > 0) isInserted = true;
        } catch (NumberFormatException e) {
            System.out.println("입력 값이 숫자 형식이 아닙니다: " + e.getMessage());
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
    public ProductDto getProduct(String name) {
		ProductDto dto = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from product where product_name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProductDto();
				
				dto.setName(rs.getString("product_name"));
				dto.setPrice(rs.getInt("product_price"));
				dto.setContents(rs.getString("product_contents"));
				dto.setStock(rs.getInt("product_stock"));
				dto.setDate(rs.getString("product_date"));
				dto.setCategory(rs.getString("product_category"));
				dto.setPic(rs.getString("product_pic"));
				
				
			}
			
		} catch (Exception e) {
			System.out.println("insertProduct() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close(); 
			
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return dto;
	}
	public boolean updateProduct(HttpServletRequest request) {
		boolean b = false;
		try {
			//업로드할 이미지 경로 : upload 폴더(절대 경로)
	        String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/product";
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
	public boolean deleteProduct(String name) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "delete from product where product_name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			
			if(pstmt.executeUpdate() > 0) b= true;
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
	public boolean  idCheckProcess(String name) {
		boolean b =false;
		
		try {
			conn = ds.getConnection();
			String sql = "select count(*) from product where product_name=?";
			//String sql = "select count(*) from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs=pstmt.executeQuery();
			 if(rs.next()) {
		            int count = rs.getInt(1);
		            if(count > 0) {
		                b = true; // 중복된 상품명이 존재함
		            }
		        }
		} catch (Exception e) {
			System.out.println("상품이름() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return b;
	}
	public boolean updateStockToZero(String productName) {
	    boolean updated = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "UPDATE product SET product_stock = 0 WHERE product_name = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, productName);
	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            updated = true;
	        }
	    } catch (Exception e) {
	        System.out.println("updateStockToZero() 에러 : " + e);
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            System.out.println("리소스 해제 중 오류 발생 : " + e);
	        }
	    }
	    return updated;
	}
	
	public ArrayList<ProductDto> getProductByCategory(String category) {
        ArrayList<ProductDto> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM product WHERE product_category=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                ProductDto dto = new ProductDto();
                dto.setName(rs.getString("product_name"));
                dto.setPic(rs.getString("product_pic"));
                dto.setPrice(rs.getInt("product_price"));
                dto.setContents(rs.getString("product_contents"));
                dto.setStock(rs.getInt("product_stock"));
                dto.setDate(rs.getString("product_date"));
                dto.setCategory(rs.getString("product_category"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getProductByCategory() err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println(": " + e2);
            }
        }
        return list;

	}
	public ArrayList<ProductDto> getProductPice(String pice) {
        ArrayList<ProductDto> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "select * from product order by product_price desc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pice);
            rs = pstmt.executeQuery();
            
            
            while(rs.next()) {
                ProductDto dto = new ProductDto();
                dto.setName(rs.getString("product_name"));
                dto.setPic(rs.getString("product_pic"));
                dto.setPrice(rs.getInt("product_price"));
                dto.setContents(rs.getString("product_contents"));
                dto.setStock(rs.getInt("product_stock"));
                dto.setDate(rs.getString("product_date"));
                dto.setCategory(rs.getString("product_category"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getProductPice() err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                System.out.println(": " + e2);
            }
        }
        return list;
	}
	public void totalList() { // 전체 레코드 수 구하기
		String sql = "select count(*) from product";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
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
	public void otalList(String category) { // 전체 레코드 수 구하기
		String sql = "select count(*) from product";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
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
	public int getPageSu(String category) { //전체 페이지수 반환
		pageSu = rectot / pList;
		if(rectot % pList > 0) pageSu++; //자투리가 있으면 페이지 하나 플러스
		return pageSu;
	}
	

	
	
}
