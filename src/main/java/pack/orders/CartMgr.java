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

	
	//--------------------
	public OrdersDto getProductCart3(String id) {
		OrdersDto dto = null;
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM orders WHERE user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto = new OrdersDto();
				dto.setNum(rs.getInt("orders_num"));
				dto.setState(rs.getString("orders_state"));
				dto.setUser(rs.getString("user_id"));
			}
		
		}catch (Exception e) {
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
		
		return dto;
	}
	
	public ArrayList<Order_productDto> getProductCart(int num) {
		ArrayList<Order_productDto> list = new ArrayList<Order_productDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM order_product WHERE orders_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Order_productDto dto = new Order_productDto();
				dto.setName(rs.getString("product_name"));
				dto.setQuantity(rs.getInt("product_quantity"));
				list.add(dto);
			}
		
		}catch (Exception e) {
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
	
	public ArrayList<ProductDto> getProductCart2(String name) {
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = ds.getConnection();
			String sql = "SELECT * FROM product WHERE product_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setPic(rs.getString("product_pic"));
				dto.setContents(rs.getString("product_contents"));
				dto.setName(rs.getString("product_name"));
				dto.setPrice(rs.getInt("product_price"));
				list.add(dto);
			}
		
		}catch (Exception e) {
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
	
	public void addCart(OrdersDto dto){
		try {
			conn = ds.getConnection();
			String sql ="insert into orders(orders_num, user_id) values(?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getUser());
			pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			System.out.println("addCart err: " + e);
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
