<%@page import="javax.security.auth.callback.ConfirmationCallback"%>

   <%@ page language="java" contentType="text/html; charset=UTF-8"

      pageEncoding="UTF-8"%>

   <%@ page import="java.io.PrintWriter"%>

   <%@ page import="bbs.BbsDAO"%>
   <%@ page import="bbs.Bbs"%>
   
   <%@ page import="reservation.Reservation"%>
   <%@ page import="reservation.ReservationDAO"%>
   
   <%@ page import="java.util.ArrayList"%>

   <!DOCTYPE html>

   <html>

   <head>

   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

   <!-- 뷰포트 -->

   <meta name="viewport" content="width=device-width" initial-scale="1">

   <!-- 스타일시트 참조  -->

   <link rel="stylesheet" href="css/bootstrap.css">

   <title>관리자 페이지</title>

   <style type="text/css">

      a, a:hover {

         color: #000000;

         text-decoration: none;

      }

   </style>

   </head>

   <body>

      <!-- 네비게이션  -->

      <nav class="navbar navbar-default">

         <div class="navbar-header">

            <button type="button" class="navbar-toggle collapsed"

               data-toggle="collapse" data-target="bs-example-navbar-collapse-1"

               aria-expaned="false">

               <span class="icon-bar"></span> <span class="icon-bar"></span> <span

                  class="icon-bar"></span>

            </button>

            <a class="navbar-brand" href="main.jsp">관리, 통계</a>

         </div>

         <div class="collapse navbar-collapse"

            id="#bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav">

               <li><a href="main.jsp">메인</a></li>

               <li class="active"><a href="bbs.jsp">게시판</a></li>

            </ul>

   

            <ul class="nav navbar-nav navbar-right">

               <li class="dropdown"><a href="#" class="dropdown-toggle"

                  data-toggle="dropdown" role="button" aria-haspopup="true"

                  aria-expanded="false">회원관리<span class="caret"></span></a>

                  <ul class="dropdown-menu">

                     <li><a href="logoutAction.jsp">로그아웃</a></li>

                  </ul></li>

            </ul>


         </div>

      </nav>

</table>


   <div class="container">

         <div class="row">

            <table class="table table-striped"

               style="text-align: center; border: 1px solid #dddddd">

               <thead>

                  <tr>

                     <th style="background-color: #eeeeee; text-align: center;">oid</th>

                     <th style="background-color: #eeeeee; text-align: center;">인원수</th>
                     <th style="background-color: #eeeeee; text-align: center;">날짜</th>

                     <th style="background-color: #eeeeee; text-align: center;">시간</th>
                     <th style="background-color: #eeeeee; text-align: center;">테이블ID</th>

                     <th style="background-color: #eeeeee; text-align: center;">고객ID</th>
                     <th style="background-color: #eeeeee; text-align: center;">요청사항</th>

                  </tr>

               </thead>
               <tbody>
                  
                  <%

                     ReservationDAO reservationDAO = new ReservationDAO();
                     ArrayList<Reservation> list = reservationDAO.gettotalList();
                     for (int i = 0; i < list.size(); i++) {
                  %>
         <tr>
                     <td><%=list.get(i).getOid()%></td>
                     <td><%=list.get(i).getCovers()%></td>
                     <td><%=list.get(i).getDate()%></td>
                     <td><%=list.get(i).getTime()%></td>
                     <td><%=list.get(i).getTableID()%></td>
                     <td><%=list.get(i).getUserID()%></td>
                     <td><%=list.get(i).getRequest()%></td>

                  </tr>

                  <%
                     }
                  %>
                  
               </tbody>
               </table>
               </div>
               </div>
   
   

   

   

   

      <!-- 애니매이션 담당 JQUERY -->

      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

      <!-- 부트스트랩 JS  -->

      <script src="js/bootstrap.js"></script>

   

   </body>

   </html>