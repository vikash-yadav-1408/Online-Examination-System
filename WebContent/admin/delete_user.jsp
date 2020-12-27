<%@page import="database.DBHelper"%>
<%@page import="modals.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Users</title>
</head>
<body>
<%
int userId = Integer.parseInt(request.getParameter("id"));
System.out.println("Id ="+userId);
if(DBHelper.deleteuser(userId)){
	response.sendRedirect("listusers.jsp?deleteResult=success");
	
}
else
{
	response.sendRedirect("listusers.jsp?deleteResult=failure");
}


%>

</body>
</html>