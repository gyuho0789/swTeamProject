<%@page import="javax.security.auth.callback.ConfirmationCallback"%>

   <%@ page language="java" contentType="text/html; charset=UTF-8"

      pageEncoding="UTF-8"%>

   <%@ page import="java.io.PrintWriter"%>

   <%@ page import="bbs.BbsDAO"%>
   <%@ page import="bbs.Bbs"%>
   
   <%@ page import="user.User"%>
   <%@ page import="user.UserDAO"%>
   
   <%@ page import="reservation.Reservation"%>
   <%@ page import="reservation.ReservationDAO"%>
   
   <%@ page import="java.util.ArrayList"%>
	<%@ page import="java.sql.*"%>
   
   <jsp:useBean id="user" class="user.User" scope="session" />
   <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
   <jsp:useBean id="booking" class="reservation.Reservation" scope="page" />

   <!DOCTYPE html>

   <html>
	
   <head>

   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.css">

<title>개인정보 수정</title>

</head>

<body>

      <%

         //로긴한사람이라면    userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
         String userID = null;

         if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
         }
    
         %>
         
<!-- 네비게이션  -->

      <nav class="navbar navbar-default">

         <div class="navbar-header">

            <button type="button" class="navbar-toggle collapsed"

               data-toggle="collapse" data-target="bs-example-navbar-collapse-1"

               aria-expaned="false">

               <span class="icon-bar"></span> <span class="icon-bar"></span> <span

                  class="icon-bar"></span>

            </button>

            <a class="navbar-brand" href="Main.jsp">레스토랑 예약 시스템</a>

         </div>
         <div class="collapse navbar-collapse"
            id="#bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
               <li><a href="Main.jsp">메인</a></li>
               <li class="active"><a href="bbs.jsp">문의 게시판</a></li>
            </ul>

            <%
               //라긴안된경우
               if (userID == null) {
            %>
            <ul class="nav navbar-nav navbar-right">
               <li class="dropdown"><a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">접속하기<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                     <li><a href="Login.jsp">로그인</a></li>
                     <li><a href="join.jsp">회원가입</a></li>
                  </ul></li>
            </ul>
            <%
               } else {
            %>
            <ul class="nav navbar-nav navbar-right">
               <li class="dropdown"><a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">회원관리<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                     <li><a href="logoutAction.jsp">로그아웃</a></li>
                  </ul></li>
            </ul>
            <%
               }
            %>
  
         </div>
      </nav>

      <%
                     UserDAO userDAO = new UserDAO();
                     ArrayList<User> list = userDAO.getUser(userID);
                       for (int i = 0; i < list.size(); i++) {  
                  %>
<table>

   <tr>                     <td>아이디: <%=list.get(i).getUserID()%></td>
                     <td>이름: <%=list.get(i).getUserName()%></td>
                     <td>성별: <%=list.get(i).getUserGender()%></td>
                     <td>이메일: <%=list.get(i).getUserEmail()%></td>
                            <td><a href="Update_user.jsp?userID=<%=userID %>" class="btn btn-primary">정보 수정</a> </td>
                            <%} %>                         
                        </tr>
</table>
   <div class="container">
         <div class="row">
            <table class="table table-striped"
               style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th style="background-color: #eeeeee; text-align: center;">번호</th>
                     <th style="background-color: #eeeeee; text-align: center;">제목</th>
                  </tr>
               </thead>
               <tbody>
                  
                        <%

                     BbsDAO bbsDAO = new BbsDAO();

                     ArrayList<Bbs> list1 = bbsDAO.getPost(userID);

                     for (int j = 0; j < list1.size(); j++) {
                          
                  %>
                     <tr>
                     <td><%=list1.get(j).getBbsID()%></td>
                     <td><a href="view.jsp?bbsID=<%=list1.get(j).getBbsID()%>"><%=list1.get(j).getBbsTitle()%></a></td>
                     </tr><br>
   

                  <%

                     }

                  %>
                  
               </tbody>
               </table>
               
               </table>
      <div class="container">
         <div class="row">
            <table class="table table-striped"
               style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th style="background-color: #eeeeee; text-align: center;">인원</th>
                     <th style="background-color: #eeeeee; text-align: center;">날짜</th>
                     <th style="background-color: #eeeeee; text-align: center;">시간</th>
                     <th style="background-color: #eeeeee; text-align: center;">테이블 번호</th>
                     <th style="background-color: #eeeeee; text-align: center;">예약인</th>
                     <th style="background-color: #eeeeee; text-align: center;">요청사항</th>
                     <th style="background-color: #eeeeee; text-align: center; width: 90px"></th>
                  </tr>
               </thead>
               <tbody>
               <%
               ReservationDAO reservationDAO = new ReservationDAO();
                    ArrayList<Reservation> bList = reservationDAO.getList(userID);
               for (int j = 0; j < bList.size(); j++) {
               %>
                     <tr>
                     <td><%=bList.get(j).getCovers()%></td>
                     <td><%=bList.get(j).getDate()%></td>
                     <td><%=bList.get(j).getTime()%></td>
                     <td><%=bList.get(j).getTableID()%></td>
                     <td><%=bList.get(j).getUserID()%></td>
                     <td><%=bList.get(j).getRequest()%></td>
                     <td><a href="Modify.jsp?oid=<%=bList.get(j).getOid() %>"class="btn btn-primary">수정&nbsp;&nbsp;</a>
                     <a href="Delete.jsp?oid=<%=bList.get(j).getOid()%>"class="btn btn-primary">삭제</a></td>
                     </tr>
                  <%

                     }

                  %>                  
               </tbody>
               </table>
               </div>
               </div>

      
</body>
</html>