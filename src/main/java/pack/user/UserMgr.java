package pack.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserMgr {
	private DataSource ds;
	
	public UserMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("ConnPooling err : " + e);
        }		
	}
	
	// 회원가입
	public boolean userInsert(UserBean userBean) {
		
		boolean b = false;

		try (Connection conn = ds.getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement("INSERT INTO user(user_id, user_pwd, user_name, user_tel, user_email, user_zipcode, user_address) VALUES (?, ?, ?, ?, ?, ?, ?)")) {

			pstmt.setString(1, userBean.getId());
			pstmt.setString(2, userBean.getPwd());
			pstmt.setString(3, userBean.getName());
			pstmt.setString(4, userBean.getTel());
			pstmt.setString(5, userBean.getEmail());
			pstmt.setString(6, userBean.getZipcode());
			pstmt.setString(7, userBean.getAddress());
			if(pstmt.executeUpdate() == 1) b = true;
		} catch (Exception e) {
			System.out.println("userInsert err: " + e);
		} 
		return b;
	} 	
	
	// 로그인
    public UserBean userAccess(String user_id) {
    	UserBean user = null;
        try (Connection conn = ds.getConnection();
        	PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?")) {
            pstmt.setString(1, user_id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new UserBean();
                user.setId(rs.getString("user_id"));
                user.setPwd(rs.getString("user_pwd"));
            }
        } catch (SQLException e) {
            System.out.println("userAccess error: " + e);
        }
        return user;
    }
    
    // 회원정보 가져오기
	public UserBean getUser(String id) {
		UserBean bean = null;
		try (Connection conn = ds.getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE user_id = ?")) {
	            pstmt.setString(1, id);
	            ResultSet rs = pstmt.executeQuery();
		
			if(rs.next()) {
				bean = new UserBean();
				bean.setId(rs.getString("user_id"));
				bean.setPwd(rs.getString("user_pwd"));
				bean.setName(rs.getString("user_name"));
				bean.setTel(rs.getString("user_tel"));
				bean.setEmail(rs.getString("user_email"));
				bean.setZipcode(rs.getString("user_zipcode"));
				bean.setAddress(rs.getString("user_address"));
			}
		} catch (Exception e) {
			System.out.println("getUser err: " + e);
		} 
		return bean;
	} 
	
	// 회원정보 수정
	public boolean userUpdate(UserBean userBean, String id) {	// 멤버 업데이트를 성공할 수도 있고 실패할 수도 있으니까 boolean으로 받아
		boolean b = false;
		
		try (Connection conn = ds.getConnection();
	        	PreparedStatement pstmt = conn.prepareStatement("update user set user_pwd=?,user_name=?,user_tel=?,user_email=?,user_zipcode=?,user_address=? where user_id=?")) {

			pstmt.setString(1, userBean.getPwd());
			pstmt.setString(2, userBean.getName());
			pstmt.setString(3, userBean.getTel());
			pstmt.setString(4, userBean.getEmail());
			pstmt.setString(5, userBean.getZipcode());
			pstmt.setString(6, userBean.getAddress());
			pstmt.setString(7, id);
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("userUpdate err: " + e);
		} 
		return b;
	} 
}