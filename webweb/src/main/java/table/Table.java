package table;

public class Table {
   private int oid;
   private int places;
   
   public Table(int oid, int places) {
      this.oid = oid;
      this.places = places;
   }
   
   public int getOid() {
      return oid;
   }
   
   public int getPlaces() {
      return places;
   }
}