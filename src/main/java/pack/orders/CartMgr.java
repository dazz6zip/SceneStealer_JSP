package pack.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.product.ProductDto;
import pack.product.ProductMgr;
import pack.product.ProductMgr_u;

public class CartMgr {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public CartMgr() {
		try { //DB연결 fooling사용
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	
	
	// 고객이 상품 주문시 주문 수 만큼 재고량 빼기
	public void reduceProduct(Order_productDto opdto) {

		try {
			conn = ds.getConnection();
			String sql = "update product set product_stock=(product_stock-?) where product_name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, opdto.getQuantity());
			pstmt.setString(2, opdto.getName());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("reduceProduct err: " + e);
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
}
