package table;

import java.sql.*;
import java.util.ArrayList;

public class TableDAO {
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;

   public TableDAO() { 
      try {

         String dbURL = "jdbc:mariadb://localhost:3306/restaurant"; 
         String dbID = "root";
         String dbPassword = "gks253";
         Class.forName("org.mariadb.jdbc.Driver");
         conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   public ArrayList<Table> getTableList() {
      ArrayList<Table> list = new ArrayList<Table>();
      String SQL = "SELECT * FROM `Table` ORDER BY oid";
      try {
         pstmt = conn.prepareStatement(SQL);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            Table table = new Table(
                  rs.getInt(1),
                  rs.getInt(2)
                  );
            list.add(table);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return list;
   }
   
   public boolean isOverFill(int tableID, int covers) {
      String SQL = "SELECT places FROM `Table` WHERE oid = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setInt(1, tableID);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            if (rs.getInt(1) < covers) return true;
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return false;
   }
}