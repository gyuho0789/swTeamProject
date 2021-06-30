<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="reservation.*"%>
<%@ page import="table.*"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
   <%
   PrintWriter script = response.getWriter();
   if (request.getParameter("reservationDate").isBlank() || request.getParameter("reservationTime").isBlank() 
         || request.getParameter("reservationCovers").isBlank()) {   
      script.println("<script>");
      script.println("alert('�Է����� ���� ������ �ֽ��ϴ�.')");
      script.println("history.back()");
      script.println("</script>");
   }
   else {
      TableDAO tableDAO = new TableDAO();
      ReservationDAO reservationDAO = new ReservationDAO();
      
      int oid = Integer.parseInt(request.getParameter("reservationOid"));
      String date = request.getParameter("reservationDate");
      String time = request.getParameter("reservationTime");
      int covers = Integer.parseInt(request.getParameter("reservationCovers"));
      String userID = request.getParameter("userID");
      String requests = request.getParameter("reservationRequest");
      
      if (request.getParameter("reservationTable").equals("auto")) {
         int divided = Integer.parseInt(request.getParameter("reservationDivded"));
         int tmp = covers / divided;
         ArrayList<Table> list = tableDAO.getTableList();
         boolean flag_tmp = true;
         boolean[] flag = new boolean[divided];
         boolean[] table = new boolean[list.size()];
         Arrays.fill(flag, false);
         Arrays.fill(table, true);
         /*�̺κ� ���ľ���*/
         for (int i = 0; i < divided; i++) {
            if (i == 0) tmp = covers - tmp * (divided - 1);
            else tmp = covers / divided;
            for (int j = 0; j < list.size(); j++) {
               if (table[j] == true &&
                     !tableDAO.isOverFill(list.get(j).getOid(), tmp)) {
                  if ((i == 0 && !reservationDAO.isDoubleBooked(oid, date, time, list.get(j).getOid())) ||
                        !reservationDAO.isDoubleBooked(-1, date, time, list.get(j).getOid())) {
                     flag[i] = true;
                     table[j] = false;
                     break;
                  }
               }
            }
         }
         for (int i = 0; i < divided; i++) {
            if (flag[i] == false) {
               script.println("<script>");
               script.println("alert('�̿��� �� �ִ� ���̺��� �����մϴ�.')");
               script.println("history.back()");
               script.println("</script>");
               flag_tmp = false;
               break;
            }
         }

         tmp = covers / divided;
         if (flag_tmp) {
            for (int i = 0; i < divided; i++) {
               if (i == 0) tmp = covers - tmp * (divided - 1);
               else tmp = covers /divided;
               for (int j = 0; j < list.size(); j++) {
                  if (i == 0 && !reservationDAO.isDoubleBooked(oid, date, time, list.get(j).getOid()) &&
                     !tableDAO.isOverFill(list.get(j).getOid(), tmp)) {
                     reservationDAO.updateReservation(oid, date, time, list.get(j).getOid(), tmp);
                     break;
                  } else if (!reservationDAO.isDoubleBooked(-1, date, time, list.get(j).getOid()) &&
                        !tableDAO.isOverFill(list.get(j).getOid(), tmp)) {
                     reservationDAO.insertReservation(date, time, list.get(j).getOid(), userID, tmp, requests);
                     break;
                  }
               }
            }
            script.println("<script>");
            script.println("location.href = 'reservationSearch.jsp'");
            script.println("</script>");
         }
      }
      else {
         int tableID = Integer.parseInt(request.getParameter("reservationTable"));
   
         if (reservationDAO.isDoubleBooked(oid, date, time, tableID)) {
            script.println("<script>");
            script.println("alert('Double Booked!')");
            script.println("history.back()");
            script.println("</script>");
         } else if (tableDAO.isOverFill(tableID, covers)) {
            script.println("<script>");
            script.println("alert('OverFill!')");
            script.println("history.back()");
            script.println("</script>");
         } else {
            int result = reservationDAO.updateReservation(oid, date, time, tableID, covers);
            if (result == -1) {
               script.println("<script>");
               script.println("alert('DB ������ �߻��߽��ϴ�.')");
               script.println("history.back()");
               script.println("</script>");
            }
            else {
               script.println("<script>");
               script.println("location.href = 'reservationSearch.jsp'");
               script.println("</script>");
            }
         }
      }
   }
   %>
</body>
</html>