<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="reservation.*" %>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
   <%ReservationDAO reservationDAO = new ReservationDAO(); 
   int result = reservationDAO.deleteReservation(Integer.parseInt(request.getParameter("oid")));
   if (result == -1) {

      PrintWriter script = response.getWriter();

      script.println("<script>");
      script.println("alert('DB 오류가 발생했습니다.')");
      script.println("history.back()");
      script.println("</script>");

   } else {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("location.href = 'reservationSearch.jsp'");
      script.println("</script>");
   }
   %>
</body>
</html>