package pack.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ItemMgr {
	private DataSource ds;
	
	public ItemMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB connect fail: " + e);
		}
	}
	
	// 스타일 번호 받아서 해당 스타일의 아이템 목록 반환
	// 한 스타일 내의 아이템은 3개로 고정
	// 존재하는 아이템 수만큼 ItemDto를 담아주고, 나머지는 null이 저장됨
	// (ArrayList가 아닌 Array를 해야 크기가 고정돼서 null이 담김)
	public ItemDto[] getAllItem(String num){
		ItemDto[] array = new ItemDto[3];
		String sql = "select * from item where style_num = ?";
		try(Connection conn = ds.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, num);
			try(ResultSet rs = pstmt.executeQuery()){
				for(int i=0; i<3; i++) {
					if(rs.next()){
						ItemDto dto = new ItemDto();
						dto.setNum(rs.getInt(1));
						dto.setPic(rs.getString(2));
						dto.setStyle(rs.getInt(3));
						dto.setProduct(rs.getString(4));
						array[i] = dto;
					}
				}
			}			
		} catch (Exception e) {
			System.out.println("getAllStyle err: " + e);
		}
		return array;
	}
	
	// item 추가 전 PK max+1로 받도록 번호 주기
	public int newNum() {
		int num = 0;
		String sql = "select max(item_num) from item";
		try (Connection conn = ds.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) num = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("newNum err: " + e);
		}
		return num + 1;
	}
	
	// item 추가
	public boolean insertItem(HttpServletRequest request) {
		boolean b = false;
		String uploadDir = "C:/work/scene_stealer/src/main/webapp/upload/item";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5 * 1024 * 1024, "UTF-8",
					new DefaultFileRenamePolicy());
			String sql = "INSERT INTO item values(?,?,?,?)";
			try (Connection conn = ds.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, multi.getParameter("num"));
				if (multi.getFilesystemName("pic") == null) pstmt.setString(2, "ready.jpg");
				else pstmt.setString(2, multi.getFilesystemName("pic"));
				pstmt.setString(3, multi.getParameter("style"));
				pstmt.setString(4, multi.getParameter("product"));
				if (pstmt.executeUpdate() == 1) b = true;
			}
		} catch (Exception e) {
			System.out.println("insertItem err : " + e);
		}
		return b;
	}

}
