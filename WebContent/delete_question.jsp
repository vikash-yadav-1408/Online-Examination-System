<%@page import="database.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int questionId = Integer.parseInt(request.getParameter("Id"));
System.out.println("Id ="+questionId);
if(DBHelper.deletequestion(questionId)){
	response.sendRedirect("listquestions.jsp?deleteResult=success");
	
}
else
{
	response.sendRedirect("listquestions.jsp?deleteResult=failure");
}


%>

</body>
</html>