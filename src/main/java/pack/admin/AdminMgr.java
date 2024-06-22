package pack.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public AdminMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("Db 연결 실패:"+e);
		}
	}
	
	public boolean adminLoginCheck(String adminid, String adminpasswd) {
	      boolean b= false;
	      try {
	         conn= ds.getConnection();
	         String sql="select * from admin where admin_id=? and admin_passwd=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, adminid);
	         pstmt.setString(2, adminpasswd);
	         rs= pstmt.executeQuery(); //있을수도없을수도 있다. 
	         b= rs.next();//있으면 true 없으면 false. 
	      }catch (Exception e) {
	         System.out.println("adminLoginCheck err:"+e);
	      }finally {
	         try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(conn != null) conn.close();
	         } catch (Exception e2) {
	            // TODO: handle exception
	         }
	      }
	      return b;
	   }
	
	
}