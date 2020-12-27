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
  <title>Admin - Reset Password</title>

  <!-- Custom fonts for this template-->
   
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>
<%
	response.setHeader("Cache-Control", "no-cache, no-control, must-revalidate");
		  response.setHeader("pragma","no-cache");  
	  String sessionMessage = (String)session.getAttribute("sessionMessage");
	  if(sessionMessage==null){
		  System.out.println("Session Message = " + sessionMessage);
		  response.sendRedirect("index.jsp?loginMessage=Session has terminated. Please log in again"); 
	  }
%>
<body class="bg-dark">

  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">Reset Password</div>
      <div class="card-body">
        <form action="reset_password.jsp" method="get">
          <div class="form-group">
            <div class="form-label-group">
              <input name="current_password" type="text" id="currentPassword" class="form-control" placeholder="Enter Current Password" required="required" autofocus="autofocus">
              <label for="currentPassword">Enter Current Password</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input name="new_password" type="password" id="newPassword" class="form-control" placeholder="Enter New Password" required="required">
              <label for="newPassword">Enter New Password</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input name="retype_password" type="password" id="reTypePassword" class="form-control" placeholder="Re-type New Password" required="required">
              <label for="reTypePassword">Re-type New Password</label>
            </div>
          </div>
          <input type="submit" name="submit" value="Submit" class="btn btn-primary btn-block">
        </form>
        
		<% 
		String enteredPassword = request.getParameter("current_password");
		
        if(enteredPassword==null) {
        	
        } else {
        	String currentPassword = DBHelper.getAdminPassword();
        	if(currentPassword.equals(enteredPassword)) {
	          	String newPassword = request.getParameter("new_password");
	    		String reTypePassword = request.getParameter("retype_password");
	    		if(newPassword.equals(reTypePassword)) {
	    			if(DBHelper.updateAdminPassword(enteredPassword, reTypePassword)) {
	    				response.sendRedirect("dashboard.jsp");
	    			} else{ %>
	    				"<script>alert("Could not change password. Please try again later")</script>"
	    			<% }
	    		} else{%>
	    		"<script>alert("Passwords do not match")</script>"
	    		<% }
	        }else {%>
	        	"<script>alert("Wrong Password Entered")</script>"
	        	
	        <% }
        }
        %>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	<script type="text/javascript">
	function showAlert(String message){
		alert(message);
	}
	</script>
</body>

</html>
