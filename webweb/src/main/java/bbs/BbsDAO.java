package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	// dao : �뜲�씠�꽣踰좎씠�뒪 �젒洹� 媛앹껜�쓽 �빟�옄
	private Connection conn; // connection:db�뿉�젒洹쇳븯寃� �빐二쇰뒗 媛앹껜
	// private PreparedStatement pstmt;
	private ResultSet rs;

	// mariadb 泥섎━遺�遺�
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public BbsDAO() {
		// �깮�꽦�옄瑜� 留뚮뱾�뼱以��떎.
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/restaurant"; // localhost:3306 �룷�듃�뒗 而댄벂�꽣�꽕移섎맂 mariadb二쇱냼
			String dbID = "root";
			String dbPassword = "";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// �쁽�옱�쓽 �떆媛꾩쓣 媛��졇�삤�뒗 �븿�닔

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}

	// bbsID 寃뚯떆湲� 踰덊샇 媛��졇�삤�뒗 �븿�닔
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 泥� 踰덉㎏ 寃뚯떆臾쇱씤 寃쎌슦
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	// �떎�젣濡� 湲��쓣 �옉�꽦�븯�뒗 �븿�닔
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return -1;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();

				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));

				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// �닔�젙 �븿�닔
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ?, WHERE bbsID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�

	}
	

	   public ArrayList<Bbs> getPost(String userID){ 

	   
	      String SQL = "SELECT * FROM BBS WHERE userID = ? AND bbsAvailable = 1;";
	      ArrayList<Bbs> list = new ArrayList<Bbs>();

	      try {

	         PreparedStatement pstmt = conn.prepareStatement(SQL);

	         pstmt.setString(1,userID);

	         rs = pstmt.executeQuery();

	         while (rs.next()) {

	            Bbs bbs = new Bbs();

	            bbs.setBbsID(rs.getInt(1));

	            bbs.setBbsTitle(rs.getString(2));

	            bbs.setBbsAvailable(rs.getInt(6));

	            list.add(bbs);

	         }

	      } catch (Exception e) {

	         e.printStackTrace();

	      }

	      return list; 

	   }

	public int c_write(int bbsID, String bbsComment) {
	      String SQL = "UPDATE BBS SET bbsComment = ? WHERE bbsID = ?";

	      try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);

	         pstmt.setString(1, bbsComment);
	         pstmt.setInt(2,bbsID);
	      
	         
	         return pstmt.executeUpdate();

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return -1; // 데이터베이스 오류
	   }
	   
	   
	   public int update_c(int bbsID, String bbsComment) {
	      String SQL = "UPDATE BBS SET bbsComment = ? WHERE bbsID = ?";
	      try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, bbsComment);
	         pstmt.setInt(2, bbsID);
	         return pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return -1; // 데이터베이스 오류
	   }

	public int delete_c(int bbsID) {
	      String SQL = "UPDATE BBS SET bbsComment = null WHERE bbsID = ?";
	      try {

	         PreparedStatement pstmt = conn.prepareStatement(SQL);   
	         pstmt.setInt(1, bbsID);
	         return pstmt.executeUpdate();

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return -1; // 데이터베이스 오류
	   }

}
