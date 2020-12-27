<%@page import="java.util.ArrayList"%>
<%@page import="database.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Result</title>
</head>
<body>

<%
	int examId=0;
	Enumeration enums = request.getParameterNames();
	List<Integer> givenAnswers = new ArrayList<Integer>();
	while(enums.hasMoreElements())
	{
	  Object obj = enums.nextElement();
	  String fieldName = (String) obj;
	  if(fieldName.contains("answer")) {
	  	int fieldValue = Integer.parseInt(request.getParameter(fieldName));	
	  	givenAnswers.add(fieldValue);
	  } else if(fieldName.contains("examId")){
	  	examId = Integer.parseInt(request.getParameter(fieldName));
	  }
	}
	List<Integer> correctAnswers = DBHelper.getCorrectAnswers(examId);
	int score=0;
	for(int i=0, j=0; i<correctAnswers.size();i++,j++) {
		if(correctAnswers.get(i)==givenAnswers.get(i)) {
			score++;
		}
	}
	
	out.println("Score: "+score);
%>

</body>
</html>