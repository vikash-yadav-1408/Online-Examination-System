package execution;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBHelper;
import modals.Category;

@WebServlet("/AddCategory")
public class AddCategory extends HttpServlet implements Servlet {
	private static final long serialVersionUID = 1L;
       
    public AddCategory() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Category category = new Category();
		category.setName(request.getParameter("category"));
		if(DBHelper.addCategory(category)) {
			response.sendRedirect("admin/dashboard.jsp");
		} else {
			response.sendRedirect("admin/add_category.jsp");
		}
		
	}
}
