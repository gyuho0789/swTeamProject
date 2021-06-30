<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reservation.ReservationDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>예약 확인</title>
</head>
<body>	
	<title>레스토랑 예약 웹사이트</title>

</head>
<body>

	<%
	ReservationDAO reservationDAO = new ReservationDAO(); //인스턴스생성
	
	String userID = (String)session.getAttribute("userID");
	int covers = Integer.parseInt(request.getParameter("reservationCovers"));
	int tableID = Integer.parseInt(request.getParameter("reservationTable"));
	String date = request.getParameter("reservationDate");
	String time = request.getParameter("reservationTime"); //변경 필요 - select에 시간 넣어서 전달받도록 변경
	String requirement = request.getParameter("reservationRequest");
	
	int result = reservationDAO.insertReservation(date,time,tableID,userID,covers,requirement);
	//예약 성공
	if (result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'Main.jsp'");
		script.println("</script>");
	}
	//예약 실패
	else if (result == -1) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('예약 실패')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>