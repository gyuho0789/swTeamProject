<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reservation.*"%>
<%@ page import="user.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); int oid = Integer.parseInt(request.getParameter("oid"));%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
   <script>
      function autoChange(e) {
         var person = ["1", "2", "3", "4", "5"];
         var none = ["그룹을 선택해주세요"];
         var target = document.getElementById("divide");
         
         if (e.value == "auto") var range = person;
         else var range = none;
         target.options.length = 0;
         
         for (i in range) {
            var opt = document.createElement("option");
            opt.value = range[i];
            opt.innerHTML = range[i];
            target.appendChild(opt);
         }
      }
      
      function func_confirm() {
         var result = confirm("예약을 취소하시겠습니까?");
         var url = 'deleteReservation.jsp?oid=' + <%=oid%>
         if (result == true) location.href = url;
      }
   </script>
   
   <!-- 네비게이션  -->

   <nav class="navbar navbar-default">
      <div class="navbar-header">
         <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-expaned="false">
            <span class="icon-bar"></span> <span class="icon-bar"></span> <span
               class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="Main.jsp">예약하기</a>
      </div>
      <div class="collapse navbar-collapse"
         id="#bs-example-navbar-collapse-1">
         <ul class="nav navbar-nav">
            <li><a href="Main.jsp">메인</a></li>
            <li><a href="bbs.jsp">게시판</a></li>
            <li><a href="reservationSearch.jsp">예약 조회</a></li>
         </ul>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown"><a href="#" class="dropdown-toggle"
               data-toggle="dropdown" role="button" aria-haspopup="true"
               aria-expanded="false">접속하기<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li class="active"><a href="Login.jsp">로그인</a></li>
                  <li><a href="Join.jsp">회원가입</a></li>
               </ul></li>
         </ul>
      </div>
   </nav>
   
   <%   
   ReservationDAO reservationDAO = new ReservationDAO();
   TableDAO tableDAO = new TableDAO();
   UserDAO userDAO = new UserDAO();
   
   Reservation reservation = reservationDAO.getReservation(oid);
   ArrayList<Table> list = tableDAO.getTableList();
   %>
   <div class="container">
      <div class="col-lg-4"></div>
      <!-- 점보트론 -->
      <div class="jumbotron" style="padding-top: 20px;">
         <form method="post" action="modifyReservation.jsp" accept-charset="utf-8">
            <div class="col-lg-4">
               <h3 style="text-align: center;">예약 화면</h3>
               <div class="form-group">
                  <input type="hidden" class="form-control" value="1" name="reservationOid">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" value="<%=String.format("%1$tY-%1$tm-%1$td", reservation.getDate())%>" placeholder="날짜"
                     name="reservationDate" maxlength="20">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" value="<%=reservation.getTime().toString()%>" placeholder="시간"
                     name="reservationTime" maxlength="20">
               </div>
               <div class="form-group">
                  <select name="reservationTable" onchange="autoChange(this)">
                     <%for (int i = 0; i < list.size(); i++) {
                        if (list.get(i).getOid() == reservation.getTableID()) {
                     %>
                     <option value="<%=list.get(i).getOid()%>" selected><%=list.get(i).getOid()%></option>
                     <%   } else { %>
                     <option value="<%=list.get(i).getOid()%>"><%=list.get(i).getOid()%></option>
                     <%   }
                     } %>
                     <option value="auto">자동 선택</option>
                  </select>
               </div>
               <div class="form-group">
                  <select id="divide" name="reservationDivded">
                     <option>그룹을 선택해주세요</option>
                  </select>
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" value="<%=reservation.getCovers()%>" placeholder="인원"
                     name="reservationCovers" maxlength="20">
               </div>
               <input type="hidden" value="<%=reservation.getUserID()%>" name="userID">
               <div class="form-group">
                  <input type="text" class="form-control" value="<%=userDAO.getUserName(reservation.getUserID())%>" placeholder="서명"
                     name="userName" maxlength="20" readonly>
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" value="<%=userDAO.getUserEmail(reservation.getUserID())%>" placeholder="이메일"
                     name="userEmail" maxlength="20" readonly>
               </div>
               <%if (reservation.getRequest() != null) {%>
               <div class="form-group">
                  <input type="textarea" class="form-control" value="<%=reservation.getRequest()%>" placeholder="요청사항"
                     name="reservationRequest" maxlength="20">
               </div>
               <%} else {%>
               <div class="form-group">
                  <input type="textarea" class="form-control" placeholder="요청사항"
                     name="reservationRequest" maxlength="20">
               </div>
               <%} %>
            </div>
            <div class="col-lg-3">
                  <input type="submit" class="btn btn-primary" value="수정하기">
                  <input type="button" class="btn btn-primary" onclick="func_confirm()" value="삭제하기">
                  <input type="button" class="btn btn-primary" onclick="location.href='reservationSearch.jsp'" value="뒤로가기">
            </div>
         </form>
      </div>
   </div>
</body>
   <!-- 부트스트랩 JS  -->
   <script src="js/bootstrap.js"></script>
</html>