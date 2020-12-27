<%@page import="database.DBHelper"%>
<%@page import="modals.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update User</title>
</head>
<body>
<%
	int userId = Integer.parseInt(request.getParameter("id")); 
	User user=new User();
	user.setUserId(userId);
	user.setName(request.getParameter("name"));
	user.setEmailId(request.getParameter("email"));

	if(DBHelper.updateUserDetails(user)) {
		response.sendRedirect("listusers.jsp");
	} else {
		response.sendRedirect("edit_user.jsp?updateUserResult=Failure");
	}

%>




</body>
</html>