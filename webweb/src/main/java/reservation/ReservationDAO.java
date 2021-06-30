package reservation;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class ReservationDAO {
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;

   public ReservationDAO() { 
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
   
   public ArrayList<Reservation> getReservationList(String date) {
      ArrayList<Reservation> list = new ArrayList<Reservation>();
      String SQL = "select * from reservation where date = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, date);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            Reservation reservation = new Reservation (
                  rs.getInt(1),
                  rs.getDate(2),
                  rs.getTime(3),
                  rs.getInt(4),
                  rs.getString(5),
                  rs.getInt(6),
                  rs.getString(7)
                  );
            list.add(reservation);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return list;
   }
   
   public Reservation getReservation(int oid) {
      Reservation reservation = null;
      String SQL = "select * from reservation where oid = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setInt(1, oid);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            reservation = new Reservation (
                  rs.getInt(1),
                  rs.getDate(2),
                  rs.getTime(3),
                  rs.getInt(4),
                  rs.getString(5),
                  rs.getInt(6),
                  rs.getString(7)
                  );
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return reservation;
   }
   
   public int deleteReservation(int oid) {
      String SQL = "delete from reservation where oid = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setInt(1, oid);
         return pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   void setOid(int oid) {
      String SQL = "update lastoid set lastNumber = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setInt(1, oid);
         int result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   int getOid() {
      int result = 0;
      String SQL = "select * from lastoid";
      try {
         pstmt = conn.prepareStatement(SQL);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            result = rs.getInt(1);
            setOid(result + 1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return result;
   }
   
   public int insertReservation(String date, String time, int tableID, String userID, int covers, String request) {
      int oid = getOid();
      String SQL = "INSERT INTO reservation VALUES (?,?,?,?,?,?,?)";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setInt(1, oid);
         pstmt.setDate(2, Date.valueOf(date));
         pstmt.setTime(3, Time.valueOf(time));
         pstmt.setInt(4, tableID);
         pstmt.setString(5, userID);
         pstmt.setInt(6, covers);
         pstmt.setString(7, request);
         return pstmt.executeUpdate();
      }  catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   public int updateReservation(int oid, String date, String time, int tableID, int covers) {
      String SQL = "update reservation set date = ?, time = ?, tableID = ?, covers = ? where oid = ?";
      try {
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, date);
         pstmt.setString(2, time);
         pstmt.setInt(3, tableID);
         pstmt.setInt(4, covers);
         pstmt.setInt(5, oid);
         return pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   public boolean isDoubleBooked(int oid, String date, String time, int tableID) {
      Time time_conversion = Time.valueOf(time);
      Time endTime = (Time) time_conversion.clone();
      endTime.setHours(endTime.getHours() + 2);
      ArrayList<Reservation> list = getReservationList(date);
      for (int i = 0; i < list.size(); i++){
         if (list.get(i).getOid() != oid &&
               list.get(i).getTableID() == tableID && 
               time_conversion.before(list.get(i).getEndTime()) &&
               endTime.after(list.get(i).getTime())) return true;
      }
      return false;
   }
   
   public ArrayList<Reservation> gettotalList(){ 

	      
	      String sql = "SELECT * FROM reservation ";
	      ArrayList<Reservation> list = new ArrayList<Reservation>();

	      try {
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();

	         while (rs.next()) {
	             Reservation reservation = new Reservation (
	                     rs.getInt(1),
	                     rs.getDate(2),
	                     rs.getTime(3),
	                     rs.getInt(4),
	                     rs.getString(5),
	                     rs.getInt(6),
	                     rs.getString(7)
	                     );
            
	             list.add(reservation);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return list; 
	   }
   
   public ArrayList<Reservation> getList(String userID) {
	      ArrayList<Reservation> list = new ArrayList<Reservation>();
	      String SQL = "select * from reservation where customer_id = ?";
	      try {
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            Reservation reservation = new Reservation (
	                  rs.getInt(1),
	                  rs.getDate(2),
	                  rs.getTime(3),
	                  rs.getInt(4),
	                  rs.getString(5),
	                  rs.getInt(6),
	                  rs.getString(7)
	                  );
	            list.add(reservation);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return list;
	   }
}