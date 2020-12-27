<%@page import="database.DBHelper"%>
<%@page import="modals.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up to give Test</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="../css/style.css">
    <script type="text/javascript">
     
    function validateForm(){
    	var uName = document.forms.myForm.name.value;
    	var pwd = document.forms.myForm.pass.value;
    	
    	
    	if (uName.trim() == "")
    	{
    		alert("User Name can't be blank");
    		return false;
    	}
    	else if(pwd.trim() == "")
    	{
    		alert("Password can't be blank");
    		return false;
    	}
    	else if(pwd.length<6){
    		alert("Password must be 6 character long");
    		return false;
    	}
    }
    
    </script>
</head>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		  response.setHeader("pragma","no-cache");  
	  String sessionMessage = (String)session.getAttribute("sessionMessage");
	  if(sessionMessage==null){
		  System.out.println("Session Message = " + sessionMessage);
		  response.sendRedirect("index.jsp?loginMessage=Session has terminated. Please log in again"); 
	  } else{
		  int id = Integer.parseInt(request.getParameter("id"));
		  User user = DBHelper.getUserDetails(id);
	  
%>
<body>

    <div class="main">

        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>
                        <form name="myForm" onsubmit="return validateForm()" action="edit_user2.jsp?id=<%= id %>" method="POST" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name" value= "<%=user.getName() %>" required/>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email" value= "<%=user.getEmailId() %>" required/>
                            </div>
                            
                            <div class="form-group form-button">
                                <input type="submit" name="update" id="signup" class="form-submit" value="Update"/>
                            </div>
                                <p style="color:red;font-weight:bold;">
                                <%
								    if(null!=request.getAttribute("errorMessage"))
								    {
								        out.println(request.getAttribute("errorMessage"));
								    }
								%>
                                </p>
        
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="../images/signup-image.jpg" alt="sign up image"></figure>
                        <a href="login.jsp" class="signup-image-link">I am already member</a>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
<%} %>
</html>