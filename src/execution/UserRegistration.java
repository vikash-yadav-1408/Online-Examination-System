package execution;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBHelper;
import modals.User;


@WebServlet("/UserRegistration")
public class UserRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;    
   
    public UserRegistration() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String emailId = request.getParameter("email");
		System.out.println("Email Id = " +  emailId);
		
		if(DBHelper.getUserDetails(emailId)!=null) {
			 request.setAttribute("errorMessage", "User already exists. Log in to continue");
             RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
             rd.forward(request, response); 				
		} else {
			String name = request.getParameter("name");
			String password = request.getParameter("pass");
			String repeatPassword = request.getParameter("re_pass");
			
			System.out.println("User Name = " + name);
			System.out.println("Password = " +  password);
			System.out.println("Repeat Password= " +   repeatPassword);
			
			if(password.equals(repeatPassword)) {
				User user = new User();
				user.setName(name);
				user.setEmailId(emailId);
				user.setPassword(password);
				if(DBHelper.addUser(user)) {
					request.getSession().setAttribute("username", request.getParameter("username"));
	                response.sendRedirect("login.jsp");
				} else {
					 request.setAttribute("errorMessage", "User cannot be added\nPlease Try again");
		             RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
		             rd.forward(request, response); 				
				}
			} else {
				 request.setAttribute("errorMessage", "Passwords do not match");
	             RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
	             rd.forward(request, response); 
			}
			
		}
		
	}

}