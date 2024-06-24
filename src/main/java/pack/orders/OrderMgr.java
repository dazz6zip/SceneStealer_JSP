package pack.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


import pack.product.ProductDto;

public class OrderMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	private int rectot;  		// tot : 전체 레코드 수
 	private int pList = 5;      // 페이지 당 출력 행 수 
 	private int pageSu;  

	// DB 연결을 위한 생성자
	public OrderMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB CONNECT ERROR : " + e.getMessage());
		}
	}
	
	// 유저 아이디로 해당 유저의 주문 정보 받아오기
	public ArrayList<OrdersDto> getOrderData(String id) {
		ArrayList<OrdersDto> list = new ArrayList<OrdersDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM orders WHERE user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrdersDto dto = new OrdersDto();
				dto.setNum(rs.getInt("orders_num"));
				dto.setState(rs.getString("orders_state"));
				dto.setUser(rs.getString("user_id"));
				list.add(dto);
			}
		}catch (Exception e) {
			System.out.println("getOrderData() ERROR : " + e);
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
				System.out.println("getOrderData() - finally ERROR : " + e2.getMessage());
			}
		}
		return list;
	}
	
	// 주문번호로 해당 주문의 정보 받아오기
	public OrdersDto getOrderDataDetail(int orders_num) {
		OrdersDto dto = null;
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM orders WHERE orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new OrdersDto();
				dto.setNum(rs.getInt("orders_num"));
				dto.setState(rs.getString("orders_state"));
				dto.setUser(rs.getString("user_id"));
			}
		}catch (Exception e) {
			System.out.println("getOrderData() ERROR : " + e);
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
				System.out.println("getOrderData() - finally ERROR : " + e2.getMessage());
			}
		}
		return dto;
	}
	
	// 특정 주문번호에 해당하는 제품명으로 상품 정보 받아오기 (여러 개)
	public ArrayList<ProductDto> getOPInfoDetail(int num) {
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE product_name IN (SELECT product_name FROM order_product WHERE orders_num = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setPic(rs.getString("product_pic"));
				dto.setPrice(rs.getInt("product_price"));
				dto.setName(rs.getString("product_name"));
				list.add(dto);
			}

		}catch (Exception e) {
			System.out.println("getOrderProductInfo() ERROR : " + e);
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
				System.out.println("getOrderProductInfo() - finally ERROR : " + e2.getMessage());
			}
		}
		return list;
	}
	
	//  특정 주문번호에 해당하는 제품명으로 상품 정보 받아오기 (한 개)
	public ProductDto getOPinfo(int num) {
		ProductDto dto = null;
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE product_name IN (SELECT product_name FROM order_product WHERE orders_num = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				dto = new ProductDto();
				dto.setPic(rs.getString("product_pic"));
				dto.setPrice(rs.getInt("product_price"));
				dto.setName(rs.getString("product_name"));
			}

		}catch (Exception e) {
			System.out.println("getOrderProductInfo() ERROR : " + e);
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
				System.out.println("getOrderProductInfo() - finally ERROR : " + e2.getMessage());
			}
		}
		return dto;
	}
	
	// 리뷰 이미 작성했는지 확인하기
	public boolean getReivewOk(String product_name, String id) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM review WHERE product_name = ? AND user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_name);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				b = true;
			}

		}catch (Exception e) {
			System.out.println("getReivewOk() ERROR : " + e);
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
				System.out.println("getReivewOk() - finally ERROR : " + e2.getMessage());
			}
		}
		
		return b;
	}
	
	// 특정 주문번호의 상품 갯수 구하기
	public int countprocess(int orders_num) {
		int count = 0;
		try {
			conn = ds.getConnection();
			String sql = "SELECT COUNT(product_name) as count FROM order_product WHERE orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("count");
			}

		}catch (Exception e) {
			System.out.println("countprocess() ERROR : " + e);
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
				System.out.println("countprocess() - finally ERROR : " + e2.getMessage());
			}
		}
		return count;
	}
	
	// 특정 주문번호의 특정 상품 갯수 구하기
	public int countprocessDetail(int orders_num, String product_name) {
		int count = 0;
		try {
			conn = ds.getConnection();
			String sql = "SELECT product_quantity FROM order_product WHERE orders_num = ? AND product_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			pstmt.setString(2, product_name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}

		}catch (Exception e) {
			System.out.println("countprocess() ERROR : " + e);
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
				System.out.println("countprocess() - finally ERROR : " + e2.getMessage());
			}
		}
		return count;
	}
	
	// 주문 취소 (UPDATE로 주문 상태 취소완료로 변경)
	public boolean delOrder(String num) {
		boolean b = false;
		try {
			conn = ds.getConnection();	
			String sql = "UPDATE orders SET orders_state = ? WHERE orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "취소완료");
			pstmt.setString(2, num);
			if (pstmt.executeUpdate() > 0) {
				b = true;
			}
			
		}catch (Exception e) {
			System.out.println("delOrder() ERROR : " + e);
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
				System.out.println("delOrder() - finally ERROR : " + e2.getMessage());
			}
		}
		return b;
	}
	
	// 주문 취소로 인한 재고 반영
	public boolean delOrderStock(String num) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM order_product WHERE orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sql = "UPDATE product SET product_stock = product_stock + (SELECT product_quantity FROM order_product WHERE orders_num = ? AND product_name = ?) WHERE product_name = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, num);
				pstmt.setString(2, rs.getString("product_name"));
				pstmt.setString(3, rs.getString("product_name"));
				if (pstmt.executeUpdate() > 0) {
					b = true;
				} else {
					b = false;
					break;
				}
			}

		}catch (Exception e) {
			System.out.println("delOrderStock() ERROR : " + e);
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
				System.out.println("delOrderStock() - finally ERROR : " + e2.getMessage());
			}
		}
		return b;
	}
	
	public ArrayList<OrdersDto> getorders(String id,int page) {
		ArrayList<OrdersDto> list = new ArrayList<OrdersDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY orders_num DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			 for(int i=0; i< (page-1)* pList; i++) {
		            rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
		         }
			 int k =0;
			while (rs.next()&& k < pList) {
				OrdersDto dto = new OrdersDto();
				dto.setNum(rs.getInt("orders_num"));
				dto.setUser(rs.getString("user_id"));
				dto.setState(rs.getString("orders_state"));
				
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
	public void totalList(String id) { // 전체 레코드 수 구하기
		String sql = "select count(*) from orders where user_id = ?";
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
	
	
	
}
