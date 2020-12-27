<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
</head>
<body>
<% 
session.removeAttribute("sessionMessage");
session.invalidate();
response.sendRedirect("index.jsp?loginMessage=Session has ended. Please login again");
%>

</body>
</html>