<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">
<title>레스토랑 예약 시스템</title>
<style>
#center {
 text-align:center;
 color:white;
}

body{
background-image:url('https://c.pxhere.com/photos/ac/7c/candle_color_bokeh_black_colour-1392326.jpg!d'),url('C:\Users\nosuj\OneDrive\바탕 화면\배경.jpg!d');
}


</style>

</head>

<body>

   <!-- 네비게이션  -->

   <nav class="navbar navbar-default">

      <div class="navbar-header">

         <button type="button" class="navbar-toggle collapsed"
            data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-expaned="false">

            <span class="icon-bar"></span> <span class="icon-bar"></span> <span
               class="icon-bar"></span>

         </button>

         <a class="navbar-brand" href="Main.jsp">레스토랑 예약 시스템</a>

      </div>
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
      <div class="collapse navbar-collapse"
         id="#bs-example-navbar-collapse-1">
			
         <ul class="nav navbar-nav">

            <li><a href="Main.jsp">메인</a></li>
            <li><a href="bbs.jsp">게시판</a></li>    
            <li><a href="Booking.jsp">예약하기</a></li>
            <li><a href="reservationSearch.jsp">예약 조회</a></li>  
            <%

                   String userID = null;
                 if (session.getAttribute("userID") != null) {
                       userID = (String)session.getAttribute("userID");
                       if (userID.equals("admin")) {

         %>
         <li><a href="admin.jsp">관리자게시판</a>

         <%

               } else {
         

         %>
         <li><a onclick="if(confirm('관리자로 로그인 하세요'))location.href='Login.jsp';">관리자게시판</a>
               

            <%

               }
            } 
                 else {
                       %>
         <li><a onclick="if(confirm('관리자로 로그인 하세요'))location.href='Login.jsp';">관리자게시판</a>
                 <%
                 }

            %>
         <%

                 
                 if (session.getAttribute("userID") != null) {
                userID = (String)session.getAttribute("userID");
                if (userID.equals("admin")){
                   %>
                   <li><a onclick="if(confirm('회원으로 로그인하세요'))location.href='Login.jsp';">마이페이지</a>
                   <%
                } else {

         %>
         <li><a onclick="location.href='mypage.jsp';">마이페이지</a>

         <%

         }
          }else {   %>
         <li><a onclick="if(confirm('로그인 하세요'))location.href='Login.jsp';">마이페이지</a>
                  <%
                  }
         %>
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

   <h1 id="center" font-color="white">레스토랑 예약 시스템</h1>
   
  <p  style="text-align: center"> <img src="http://image.newdaily.co.kr/site/data/img/2020/03/12/2020031200074_0.jpg" src="C:\Users\nosuj\OneDrive\바탕 화면\레스토랑.jpg" alt="레스토랑" width="500"></p>
 
  <h3 id="center">서울특별시 OO구 OO동 OOOO<h3>
  <h3 id="center"> 010-XXXX-XXXX<h3>

   <!-- 애니매이션 담당 JQUERY -->

   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

   <!-- 부트스트랩 JS  -->

   <script src="js/bootstrap.js"></script>

</body>
</html>