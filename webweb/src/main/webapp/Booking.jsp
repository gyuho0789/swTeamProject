
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="reservation.*"%>
<%@ page import="user.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="user.User" scope="session" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<%
request.setCharacterEncoding("utf-8");
String name = null, mail = null;
ResultSet rs = null;
String sql;
Statement stmt = null;
Connection con = null;
try {
	String dbURL = "jdbc:mariadb://localhost:3306/restaurant";
	String dbID = "root";
	String dbPassword = "0824";
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(dbURL, dbID, dbPassword);
} catch (Exception e) {
	e.printStackTrace();
}
try{
	String userID = (String)session.getAttribute("userID");
	if (userID != null) { 
  		stmt = con.createStatement() ;
  		rs = stmt.executeQuery("SELECT userName, userEmail FROM user where userID ='" + userID + "'") ;
		while (rs.next()) {
			name = rs.getString(1) ;
			mail = rs.getString(2);
		}	
		rs.close() ;

} else {
	out.println("<script>alert('로그인 하십시오.');window.history.back();</script>"); //로그인 안했을 시 페이지 되돌아가도록 수정
	}
}catch(Exception e) {
	e.printStackTrace();
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Booking Page</title>
<script type = "text/javascript">
function check() {
	 var id = document.regform.id.value;
	 var name = document.regform.name.value;
	 
	 if(name.length == 0 || name == 0){
	  alert("이름을 입력하십시오.");
	  document.regform.id.focus();
	  return false; 
	 } 
	 
	 if (mail.length == 0 || mail == 0){
	  alert("이메일을 입력하십시오.");
	  document.regform.name.focus();
	  return false;
	 }
	 
	 var idx = regform.hour.options.selectedIndex;
	 var idx2 = regform.minute.options.selectedIndex;
	 if(regform.hour.options[idx3].value == "시" || regform.minute.options[idx3].value == "분"){
	 	alert("예약 날짜를 선택하십시오.");
	 	regform.hour.focus(); 
	 	return false;
	 }
	 
	 var idx3 = regform.table.options.selectedIndex;
	 if(regform.roomname.options[idx3].value == ""){
	 	alert("테이블을 선택하십시오.");
	 	regform.table.focus(); 
	 	return false;
	 }
	 
	 var covers = document.getElementById('covers').value;
	 if(covers.length == 0 || covers == 0){
	 	alert("인원수를 입력하십시오.");
	 	document.regform.covers.focus(); 
	 	return false;
	 }
}

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
</script>
<style>
<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">
</style>
</head>
<body>
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
	<%-- 예약 페이지 폼 --%>
<header>
	<h1 id="title">예약 페이지</h1>
</header>
<section>
   <%   
   TableDAO tableDAO = new TableDAO();
   UserDAO userDAO = new UserDAO();
   
   ArrayList<Table> list = tableDAO.getTableList();
   %>
	<form name = "regform" method="post" action = "bookingAction.jsp" onsubmit = "return check() && return doubleBookedCheck()">	
	<div class="col-lg-4">
               <h3 style="text-align: center;">예약 화면</h3>
               <div class="form-group">
                  <input type="hidden" class="form-control" value="1" name="reservationOid">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="날짜"
                     name="reservationDate" maxlength="20">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="시간"
                     name="reservationTime" maxlength="20">
               </div>
               <div class="form-group">
                  <select name="reservationTable" onchange="autoChange(this)">
				     <%
				     	for (int i = 0; i < list.size(); i++) {
	                 %>
	     			 <option value= "<%=list.get(i).getOid()%>"><%=list.get(i).getOid()%></option>
                     <% } %>
                     <option value="auto">자동 선택</option>
                  </select>
               </div>
               <div class="form-group">
                  <select id="divide" name="reservationDivded">
                     <option>그룹을 선택해주세요</option>
                  </select>
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="인원"
                     name="reservationCovers" maxlength="20">
               </div>
               <input type="hidden" name="userID">
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="서명" value = <%=name %>
                     name="userName" maxlength="20" readonly>
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="이메일" value = <%=mail %>
                     name="userEmail" maxlength="20" readonly>
               </div>
               <div class="form-group">
                  <input type="textarea" class="form-control" placeholder="요청사항"
                     name="reservationRequest" maxlength="20">
               </div>
            </div>

	</form>
            <div class="col-lg-3">
                  <input type = "submit" class="btn btn-primary" value = "예약하기">
                  <input type="button" class="btn btn-primary" onclick="location.href='Main.jsp'" value="뒤로가기">
            </div>
</section>

</body>
</html>