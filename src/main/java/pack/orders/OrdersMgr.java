package pack.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.question.QuestionDto;

public class OrdersMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private int recTot; //전체 레코드 수
	private int pList=5; //페이지당 출력 행수
	private int totalPage; //전페 페이지수
	
	public OrdersMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	// 해당 주문에 대한 상품들 정보 반환
	public ArrayList<Order_productDto> getOrder(int num){
		ArrayList<Order_productDto> list = new ArrayList<Order_productDto>();
		try {
			conn = ds.getConnection();
			String sql= "select product_name, product_quantity from order_product where orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Order_productDto op = new Order_productDto();
				op.setName(rs.getString(1));
				op.setQuantity(rs.getInt(2));
				list.add(op);
			}
		}  catch (Exception e) {
			System.out.println("getOrder err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
			
		}
		return list;
	}
	
	// 전체 레코드 수를 구해서 지정한 페이지당 개수로 나눠 전체 페이지 수 반환
	public int getTotalPage(String id) { // type: 조회옵션(전체보기/미답변글보기)
		String sql = "select count(*) from orders";
		if (id!=null) sql += " where user_id =" + id;
		// id가 null 이면 전체 주문, 있으면 해당 user 주문만 반환
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			recTot = rs.getInt(1);
			totalPage = recTot / pList;
			if (recTot % pList > 0) totalPage++;
		} catch (Exception e) {
			System.out.println("getTotalPage err: " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return totalPage;
	}

	// 페이지별로 들어갈 전체 주문목록 (관리자 상단메뉴에서 주문 클릭 시)
	public ArrayList<OrdersInfoDto> getOrderAll(int page){
		ArrayList<OrdersInfoDto> list = new ArrayList<OrdersInfoDto>();
		try {
			conn = ds.getConnection();
			String sql= "select orders_num, user.user_id, user_name, user_email, CONCAT(user_address, ' (', user_zipcode, ')'), orders_state "
					+ "from user inner join orders on user.user_id = orders.user_id order by orders.orders_num desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//페이징처리
			for(int i=0; i< (page-1)* pList; i++) {
				rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
			}
			
			int k =0;
			while(rs.next()&& k<pList) {
				OrdersInfoDto oi = new OrdersInfoDto();
				oi.setOrders(rs.getInt(1));
				oi.setId(rs.getString(2));
				oi.setName(rs.getString(3));
				oi.setEmail(rs.getString(4));
				oi.setAddress(rs.getString(5));
				oi.setState(rs.getString(6));
				list.add(oi);
				k++;	
			}
		}  catch (Exception e) {
			System.out.println("getOrderAll() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
			
		}
		return list;
	}
	
	
	// 페이지별로 들어갈 특정 유저의 주문 목록 (질문글에서 유저 아이디 클릭 시)
	public ArrayList<OrdersInfoDto> getUserOrder(String user, int page) {
		ArrayList<OrdersInfoDto> list = new ArrayList<OrdersInfoDto>();
		try {
			conn = ds.getConnection();
			String sql = "select orders_num, user.user_id, user_name, user_email, CONCAT(user_address, ' (', user_zipcode, ')'), orders_state "
					+ "from user inner join orders on user.user_id = orders.user_id where orders.user_id=? order by orders.orders_num desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			//페이징처리
			for(int i=0; i< (page-1)* pList; i++) {
				rs.next(); //레코드 포인터 이동 0, 4, 9, 14, 19..
			}
			int k =0;
			while(rs.next()&& k<pList) {
				OrdersInfoDto oi = new OrdersInfoDto();
				oi.setOrders(rs.getInt(1));
				oi.setId(rs.getString(2));
				oi.setName(rs.getString(3));
				oi.setEmail(rs.getString(4));
				oi.setAddress(rs.getString(5));
				oi.setState(rs.getString(6));
				list.add(oi);
				k++;	
			}
		} catch (Exception e) {
			System.out.println("getUserOrder() err : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}

		}
		return list;
	}
	
	// 관리자 - 유저의 주문 상태 변경
	public boolean updateOrder(String num, String state) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "update orders set orders_state=? where orders_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setString(2, num);
			if(pstmt.executeUpdate()==1) b = true;
		} catch (Exception e) {
			System.out.println("getUserOrder() err : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
		}
		return b;
	}
	
	// 주문 취소 시 상품 재고 돌려놓기
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

}

