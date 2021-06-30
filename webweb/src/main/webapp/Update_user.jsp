<%@ page language="java" contentType="text/html; charset=UTF-8"

   pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="bbs.Bbs"%>

<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>

<jsp:useBean id="bbs1" class="bbs.Bbs" scope="page" />
<jsp:useBean id="user" class="user.User" scope="page" />
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

         <a class="navbar-brand" href="Main.jsp">JSP 게시판</a>

      </div>

      <div class="collapse navbar-collapse"

         id="#bs-example-navbar-collapse-1">

         <ul class="nav navbar-nav">

            <li><a href="main.jsp">메인</a></li>

            <li class="active"><a href="bbs.jsp">게시판</a></li>

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

                  <li><a href="login.jsp">로그인</a></li>

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

   <!-- 게시판 -->

   
   <div class="container">
      <div class="row">
         <form method="post" action="updateAction_user.jsp?userID=<%= userID %> ">
            <%
                UserDAO userDAO = new UserDAO();
				ArrayList<User> list = userDAO.getUser(userID);
      			for (int i = 0; i < list.size(); i++) {
                          
            %>

            <table class="table table-striped"
               style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th colspan="2"
                        style="background-color: #eeeeee; text-align: center;">개인정보 수정 </th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                  <td>이름</td>
                     <td><input type="text" class="form-control" placeholder="이름" name="userName" maxlength="50" value="<%=list.get(i).getUserName()%>" > </td>
                  </tr>
                  <tr>
				<td>성별</td>
                     <td><input type="text" class="form-control" placeholder="성별" name="userGender" maxlength="50" value="<%=list.get(i).getUserGender()%>" ></td>
                  </tr>
                  <tr>
				<td>비밀번호</td>
                     <td><input type="text" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="50" value="<%=list.get(i).getUserPassword()%>" ></td>
                  </tr>
                  <tr>
				<td>이메일</td>
				<td><input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="50" value="<%=list.get(i).getUserEmail()%>" ></td>
				</tr>
				</tbody>

            </table>   <%} %>

            <button type="submit" class="btn btn-primary pull-right" >정보 수정</button>

         </form>

      </div>

   </div>




   <!-- 애니매이션 담당 JQUERY -->

   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

   <!-- 부트스트랩 JS  -->

   <script src="js/bootstrap.js"></script>




</body>

</html>