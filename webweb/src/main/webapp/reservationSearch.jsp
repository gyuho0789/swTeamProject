<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reservation.*"%>
<%@ page import="user.*"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); String date = request.getParameter("date");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
   <script>
      $(function() {
          //input을 datepicker로 선언
          $("#datepicker").datepicker({
              dateFormat: 'yy-mm-dd' //달력 날짜 형태
              ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
              ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
              ,changeYear: true //option값 년 선택 가능
              ,changeMonth: true //option값  월 선택 가능                
              ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
              ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
              ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
              ,buttonText: "선택" //버튼 호버 텍스트              
              ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
              ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
              ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
              ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
              ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
              ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
              ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
          });                    
          
          //초기값을 받은 날짜로 설정해줘야 합니다.
          $('#datepicker').datepicker('setDate', $("#hidden_param").val()); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
      });
      function view() {
         var date = document.getElementById("datepicker");
         console.log(date.value);
      }
   </script>
   <!-- 자바스크립트로 post값 받기 -->
   <input type="hidden" id="hidden_param", value="<%= date %>"/>
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
   <br>
   <div class="container">
   <form method="post" action="reservationSearch.jsp">
      <p>일정을 선택해주세요. 
         <input type="text" id="datepicker" name="date"></input>
         <button class="btn btn-primary" type="submit">
         <span class="glyphicon glyphicon-search">
         </span>
         </button>
      </p>
   </form>
   <table class="table table-bordered table-hover text-center" style="text-align: center; border: 1px;">
      <thead>
         <tr>
         <th>번호</th>
         <th>시간</th>
         <th>테이블</th>
         <th>서명</th>
         <th>인원</th>
         </tr>
      </thead>
      <tbody>
         <%
         UserDAO userDAO = new UserDAO();
         ReservationDAO reservationDAO = new ReservationDAO();
         ArrayList<Reservation> list = reservationDAO.getReservationList(date);
         for (int i = 0; i < list.size(); i++) {
         %>
         <tr onclick="location.href='reservationView.jsp?oid=<%=list.get(i).getOid()%>'">
            <td><%=i + 1%></td>
            <td><%=list.get(i).getTime().toString()%></td>
            <td><%=list.get(i).getTableID()%></td>
            <td><%=userDAO.getUserName(list.get(i).getUserID())%>(<%=userDAO.getUserEmail(list.get(i).getUserID())%>)</td>
            <td><%=list.get(i).getCovers()%></td>
         </tr>
         <%}%>
      </tbody>
   </table>
   </div>
</body>
   <!-- 부트스트랩 JS  -->
   <script src="js/bootstrap.js"></script>
</html>