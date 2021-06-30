package reservation;

import java.sql.Date;
import java.sql.Time;

public class Reservation {
   private int oid;
   private Date date; //yyyy-mm-dd
   private Time time; //hh:mm:ss
   private int tableID;
   private String userID;
   private int covers;
   private String request;
   
   public Reservation(int oid, Date date, Time time, int tableID, String userID, int covers, String request) {
      this.oid = oid;
      this.date = date;
      this.time = time;
      this.tableID = tableID;
      this.userID = userID;
      this.covers = covers;
      this.request = request;
   }
   
   public int getOid() {
      return oid;
   }
   
   public Date getDate() {
      return date;
   }
   
   public Time getTime() {
      return time;
   }
   
   public Time getEndTime() {
      Time endTime = (Time) time.clone();
      endTime.setHours(time.getHours() + 2);
      return endTime;
   }
   
   public int getTableID() {
      return tableID;
   }
   
   public String getUserID() {
      return userID;
   }
   
   public int getCovers() {
      return covers;
   }
   
   public String getRequest() {
      return request;
   }
}