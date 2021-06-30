<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>레스토랑 예약 웹사이트</title>

</head>
<body>

	<%
	UserDAO userDAO = new UserDAO(); //인스턴스생성

	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	//로그인 성공
	if (result == 1) {
		session.setAttribute("userID", user.getUserID());
		session.setAttribute("userPassword", user.getUserPassword());
		session.setAttribute("userName", user.getUserName());
		session.setAttribute("userGender", user.getUserGender());
		session.setAttribute("userEmail", user.getUserEmail());

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'Main.jsp'");
		script.println("</script>");
	}
	//로그인 실패
	else if (result == 0) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	//아이디 없음
	else if (result == -1) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	//DB오류

	else if (result == -2) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>

</body>
</body>
</html>

