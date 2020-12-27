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

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String emailId = request.getParameter("email");
		String password = request.getParameter("password");
		
		User user = DBHelper.getUserDetails(emailId);
		if(user==null) {
			request.setAttribute("errorMessage", "User Does not exist. Register Your self" + user);
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response); 	
		} else if(emailId.equals(user.getEmailId()) && password.equals(user.getPassword())){
			request.getSession().setAttribute("user", user);
            response.sendRedirect("test.jsp");	// redirect to question answer page		
		} else {
			request.setAttribute("errorMessage", "Invalid Credentials");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response); 	
		}
	}
	
}
