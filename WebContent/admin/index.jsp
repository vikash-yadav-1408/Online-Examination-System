<%@page import="database.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" type="image/ico" href="image/qa.png" />
  <title>Admin - Login</title>

  <!-- Custom fonts for this template-->
   
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">

  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">Login</div>
      <div class="card-body">
        <form action="index.jsp" method="post">
          <div class="form-group">
            <div class="form-label-group">
              <input name="username" type="text" id="inputEmail" class="form-control" placeholder="User Name" required="required" autofocus="autofocus">
              <label for="inputEmail">User Name</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required="required">
              <label for="inputPassword">Password</label>
            </div>
          </div>
          <input type="submit" name="submit" value="Submit" class="btn btn-primary btn-block">
        </form>
        <div class ="text-center">
        <a class = "d-block small mt-3 text-danger" href="">
        <% 
        	String errorMessage = (String)request.getParameter("loginMessage");
        	if(errorMessage!=null){
        		out.println(errorMessage);
        	}     
         %>
        </a>
        </div>
      </div>
      
     <%
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(request.getParameter("submit")!=null){
        
    		if(DBHelper.authenticateAdmin(username, password)) {
				session.setAttribute("sessionMessage", "session");
				response.sendRedirect("dashboard.jsp");
    		} else {  
    			response.sendRedirect("index.jsp?loginMessage=failure");
    		%>
    			"<script>alert("Wrong Credentials")</script>"
    	<%	}        	
        }%>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>

</html>
