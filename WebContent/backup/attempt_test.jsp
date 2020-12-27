<%@page import="modals.Exam"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.DBHelper"%>
<%@page import="modals.Question"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>C Questions</title>
</head>
<body>
<%int examId = Integer.parseInt(request.getParameter("examId")); %>
	<form method="get" action="result.jsp">
		<table style="border:1px solid black; width:50%">
			<% 
				List<Question> questionList = DBHelper.getQuestionsList(examId);
				for (int i = 0; i < questionList.size(); i++) {
			%>
			<tr>
				<td colspan="2">Q <%= (i+1) + ". " + questionList.get(i).getQuestion()%></td>
			</tr>
			<tr>
				<td>A.<input type="radio" name="answer<%=(i+1) %>"
					value="1" ><%=questionList.get(i).getOption1()%>
					</td>
				<td>B.<input type="radio" name="answer<%=(i+1) %>"
					value="2" ><%=questionList.get(i).getOption2()%>
				</td>
			</tr>
			<tr>
				<td>C.<input type="radio" name="answer<%=(i+1) %>"
					value="3" ><%=questionList.get(i).getOption3()%>
				</td>
				<td>D.<input type="radio" name="answer<%=(i+1) %>"
					value="4" ><%=questionList.get(i).getOption4()%>
				</td>
			</tr>
			<%} %>
			<tr>
				<td colspan="2">
					<input type="hidden" name="examId" value="<%=examId %>" >
					<input type="submit" value="submit" name="submit">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>