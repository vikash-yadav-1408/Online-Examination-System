package execution;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBHelper;
import modals.Exam;
import modals.Question;

@WebServlet("/EditExam")
public class EditExam extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditExam() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Question> questionsList = new ArrayList<Question>();

		int examId = Integer.parseInt(request.getParameter("examId"));
		String examName = request.getParameter("exam");

		Exam exam = new Exam();
		exam.setExamId(examId);
		exam.setName(examName);
		
		// ---------------------
		
		for (int i = 0; i < 3; i++) {
			Question question = new Question();
			System.out.println("" + request.getParameter("question" + (i + 1)));
			question.setQuestion(request.getParameter("question" + (i + 1)));
			question.setOption1(request.getParameter("option" + (i + 1) + "1"));
			question.setOption2(request.getParameter("option" + (i + 1) + "2"));
			question.setOption3(request.getParameter("option" + (i + 1) + "3"));
			question.setOption4(request.getParameter("option" + (i + 1) + "4"));
			question.setCorrectAnswer(request.getParameter("correct" + (i + 1)));
			question.setExamId(examId);

			questionsList.add(question);
		}

		if (DBHelper.updateExam(exam) & DBHelper.updateQuestions(questionsList)) {
			response.sendRedirect("admin/edit_exam.jsp?editMessage=Exam Updated Successfully&id="+examId);
		} else {
			response.sendRedirect("admin/edit_exam.jsp?editMessage=Exam could not be Updated&id="+examId);
		}

	}
}
