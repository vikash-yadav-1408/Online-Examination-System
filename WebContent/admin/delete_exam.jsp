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
	int examId = Integer.parseInt(request.getParameter("id"));
	System.out.println("Id ="+examId);
	if(DBHelper.deleteExam(examId) & DBHelper.deleteQuestions(examId)){
		System.out.println("Exam deleted successfully");
		response.sendRedirect("listexams.jsp?deleteResult=Exam deleted successfully");		
	} else{
		System.out.println("Exam can't be deleted");
		response.sendRedirect("listexams.jsp?deleteResult=Exam can't be deleted");
	}


%>

</body>
</html>