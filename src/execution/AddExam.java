package execution;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.ArrayList;

import database.DBHelper;
import modals.Exam; 
import modals.Question;

@WebServlet("/AddExam")
public class AddExam extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddExam() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Question> questionsList = new ArrayList<Question>();
		
		int categoryId = Integer.parseInt(request.getParameter("category"));
		String examName = request.getParameter("exam");
		
		Exam exam = new Exam();
		exam.setCategory(categoryId);
		exam.setName(examName);	
		
		int examId = DBHelper.addExam(exam);
		System.out.println("Exam id Add Exam: " + examId);
		if(examId==0) {
			response.sendRedirect("admin/add_exam.jsp");
		} else {
			for (int i = 0; i < 3; i++) {
				Question question = new Question();

				question.setQuestion(request.getParameter("question" + (i+1)));
				question.setOption1(request.getParameter("option" + (i+1) + "1"));
				question.setOption2(request.getParameter("option" + (i+1) + "2"));
				question.setOption3(request.getParameter("option" + (i+1) + "3"));
				question.setOption4(request.getParameter("option" + (i+1) + "4"));
				question.setCorrectAnswer(request.getParameter("correct" + (i+1)));
				question.setExamId(examId);
				
				questionsList.add(question);
			}

			if (DBHelper.addQuestions(questionsList)) {
				response.sendRedirect("admin/dashboard.jsp");
			} else {
				response.sendRedirect("admin/add_exam.jsp");
			}

		}
	}

}
