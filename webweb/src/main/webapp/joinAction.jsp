<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>레스토랑 예약 웹사이트</title>

</head>

<body>

	<%
	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null

			|| user.getUserGender() == null || user.getUserEmail() == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");

	} else {

		UserDAO userDAO = new UserDAO(); //인스턴스생성

		int result = userDAO.join(user);

		if (result == -1) { // 아이디가 기본키기. 중복되면 오류.

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");

		}

		//가입성공

		else {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("location.href = 'Main.jsp'");

			script.println("</script>");

		}

	}
	%>

</body>

</body>

</html>

