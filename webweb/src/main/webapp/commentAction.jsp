<%@ page language="java" contentType="text/html; charset=UTF-8"

   pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

   request.setCharacterEncoding("UTF-8");

   response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="bbsTitle" /><!-- bbs.setBbsTitle(requrst) -->

<jsp:setProperty name="bbs" property="bbsContent" />

<jsp:setProperty name="bbs" property="bbsComment" />

<%

   System.out.println(bbs);

%>

<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

   <%
    BbsDAO BbsDAO = new BbsDAO();
      String userID = null;

      if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

         userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.

      }
      if (userID == null) {

         PrintWriter script = response.getWriter();

         script.println("<script>");

         script.println("alert('로그인을 하세요.')");

         script.println("location.href = 'http://localhost:8080/webproject/Login.jsp'");

         script.println("</script>");

      } else {
            
            
           
             
            int bbsID = 0;
            bbsID=(Integer)session.getAttribute("bbsID"); 
            
         
            if (request.getParameter("bbsID") != null) {
         
               PrintWriter script = response.getWriter();
               script.println("<script>");

               script.println("alert('널값이 아니다')");

               script.println("</script>");
            }   
            
             

            //bbsID = (Integer)session.getAttribute("bbsID");
             
         //   Bbs bbs1 = new BbsDAO().getBbs(bbsID);
         //   bbsID=bbs1.getBbsID();
            int c_result = BbsDAO.c_write(bbsID,bbs.getBbsComment());

            if (c_result == -1) {

               PrintWriter script = response.getWriter();

               script.println("<script>");

               script.println("alert('댓글쓰기에 실패했습니다')");
               script.println("history.back()");

               script.println("</script>");

            } else  {

               PrintWriter script = response.getWriter();

               script.println("<script>");

               script.println("location.href='bbs.jsp'");
               script.println("alert('댓글달기 성공')");
               //script.println("history.back()");

               script.println("</script>");
            
            }
         
      }

      

   %>

</body>

</html>