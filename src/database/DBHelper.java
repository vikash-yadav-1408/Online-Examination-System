package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modals.Category;
import modals.Exam;
import modals.Question;
import modals.User;

public class DBHelper {
	private static final String driver = "com.mysql.cj.jdbc.Driver";
	private static final String connectionURL = "jdbc:mysql://localhost:3306/online_examination";
	private static final String userName = "root";
	private static final String userPassword = "";

	public static boolean authenticateAdmin(String username, String password) {
		// Getting values from database
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			
			Statement stmt = connection.createStatement();
			ResultSet resultSet = stmt.executeQuery("SELECT user_name, password FROM login");

			while (resultSet.next()) {
				String adminUName = resultSet.getString(1);
				String adminPwd = resultSet.getString(2);

				if (username.equals(adminUName) && password.equals(adminPwd))
					return true;
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static String getAdminPassword() {
		String currentPwd = null;
		// Getting values from database
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			Statement stmt = connection.createStatement();
			ResultSet resultSet = stmt.executeQuery("SELECT password FROM login");

			while (resultSet.next()) {
				currentPwd = resultSet.getString(1);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return currentPwd;
	}

	public static boolean updateAdminPassword(String currentPassword, String newPassword) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "UPDATE login SET password = ? WHERE password = ?";
			PreparedStatement stmt = connection.prepareStatement(sqlString);
			stmt.setString(1, newPassword);
			stmt.setString(2, currentPassword);
			if (stmt.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean addUser(User user) {

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			PreparedStatement preparedStatement = connection
					.prepareStatement("INSERT INTO user(name,email_id,password) VALUES (?,?,?)");

			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getEmailId());
			preparedStatement.setString(3, user.getPassword());

			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public static User getUserDetails(String username) {
		User user = null;
		// Getting values from database
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "SELECT * FROM user WHERE email_id = ?";
			PreparedStatement prepStmt = connection.prepareStatement(sqlString);
			prepStmt.setString(1, username);
			ResultSet resultSet = prepStmt.executeQuery();

			if (resultSet.next()) {
				user = new User();
				int userId = resultSet.getInt(1);
				String userName = resultSet.getString(2);
				String userEmailId = resultSet.getString(3);
				String userPwd = resultSet.getString(4);

				user.setUserId(userId);
				user.setName(userName);
				user.setEmailId(userEmailId);
				user.setPassword(userPwd);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	public static User getUserDetails(int userId) {
		User user = null;
		// Getting values from database
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "SELECT name, email_id FROM user WHERE user_id = ?";
			PreparedStatement prepStmt = connection.prepareStatement(sqlString);
			prepStmt.setInt(1, userId);
			ResultSet resultSet = prepStmt.executeQuery();

			if (resultSet.next()) {
				user = new User();
				String userName = resultSet.getString(1);
				String userEmailId = resultSet.getString(2);
				user.setName(userName);
				user.setEmailId(userEmailId);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	public static List<User> getUsersList() {
		List<User> listUsers = new ArrayList<User>();

		// Getting values from database
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "SELECT * FROM user";
			Statement stmt = connection.createStatement();

			ResultSet resultSet = stmt.executeQuery(sqlString);

			while (resultSet.next()) {
				User user = new User();
				int userId = resultSet.getInt(1);
				String userName = resultSet.getString(2);
				String userEmailId = resultSet.getString(3);
				String userPwd = resultSet.getString(4);

				user.setUserId(userId);
				user.setName(userName);
				user.setEmailId(userEmailId);
				user.setPassword(userPwd);
				listUsers.add(user);
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return listUsers;
	}

	public static boolean updateUserDetails(User user) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "UPDATE user SET name = ?, email_id = ? WHERE user_id = ?";
			PreparedStatement stmt = connection.prepareStatement(sqlString);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmailId());
			stmt.setInt(3, user.getUserId());

			if (stmt.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean addCategory(Category category) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO category(name) VALUES (?)");

			preparedStatement.setString(1, category.getName());

			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();

		}
		return false;

	}

	public static Category getCategory(int categoryId) {
		Category category = null;
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement stmt = connection.prepareStatement("Select * from category WHERE category_id = ?");
			stmt.setInt(1, categoryId);
			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				category = new Category();
				category.setCategoryId(resultSet.getInt(1));
				category.setName(resultSet.getString(2));
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return category;
	}

	public static List<Category> getCategoryList() {
		List<Category> categoryList = new ArrayList<Category>();
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			Statement stmt = connection.createStatement();
			ResultSet resultSet = stmt.executeQuery("Select * from category ORDER BY category_id");

			while (resultSet.next()) {
				Category category = new Category();
				category.setCategoryId(resultSet.getInt(1));
				category.setName(resultSet.getString(2));
				categoryList.add(category);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return categoryList;
	}

	public static boolean addQuestions(List<Question> questionsList) {

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "INSERT INTO question(question,option1,option2,option3,option4,correct_answer,exam_id) VALUES (?,?,?,?,?,?,?)";
			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			for (Question question : questionsList) {
				preparedStatement.setString(1, question.getQuestion());
				preparedStatement.setString(2, question.getOption1());
				preparedStatement.setString(3, question.getOption2());
				preparedStatement.setString(4, question.getOption3());
				preparedStatement.setString(5, question.getOption4());
				preparedStatement.setString(6, question.getCorrectAnswer());
				preparedStatement.setInt(7, question.getExamId());
				preparedStatement.addBatch();
			}

			if (preparedStatement.executeBatch().length == 10) {
				return true;
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static List<Question> getQuestionsList(int examId) {
		List<Question> questionList = new ArrayList<Question>();
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "Select * from question WHERE exam_id=?";
			PreparedStatement stmt = connection.prepareStatement(sqlString);
			stmt.setInt(1, examId);
			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				Question question = new Question();
				question.setQuestionId(resultSet.getInt(1));
				question.setQuestion(resultSet.getString(2));
				question.setOption1(resultSet.getString(3));
				question.setOption2(resultSet.getString(4));
				question.setOption3(resultSet.getString(5));
				question.setOption4(resultSet.getString(6));
				question.setCorrectAnswer(resultSet.getString(7));
				question.setExamId(resultSet.getInt(8));
				questionList.add(question);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return questionList;
	}

	public static int getNumOfQuestions(int examId) {
		int numberOfQ = 0;
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement stmt = connection.prepareStatement("Select count(*) from question WHERE exam_id=?");
			stmt.setInt(1, examId);
			ResultSet rSet = stmt.executeQuery();

			while (rSet.next()) {
				numberOfQ = rSet.getInt(1);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return numberOfQ;
	}

	public static List<Integer> getCorrectAnswers(int examId) {
		List<Integer> correctAnswers = new ArrayList<Integer>();

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement stmt = connection.prepareStatement("Select correct_answer from question WHERE exam_id=?");
			stmt.setInt(1, examId);
			ResultSet rSet = stmt.executeQuery();

			while (rSet.next()) {
				correctAnswers.add(rSet.getInt(1));
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return correctAnswers;
	}

	public static int addExam(Exam exam) {
		int examId = 0;
		try {
			Class.forName(driver);
			String sqlString = "INSERT INTO exam(category_id,name) VALUES (?,?)";
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement preparedStatement = connection.prepareStatement(sqlString, Statement.RETURN_GENERATED_KEYS);

			preparedStatement.setInt(1, exam.getCategory());
			preparedStatement.setString(2, exam.getName());

			preparedStatement.executeUpdate();
			ResultSet rs = preparedStatement.getGeneratedKeys();
			if (rs.next()) {
				examId = rs.getInt(1);
			}

			System.out.println("exam id : " + examId);

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return examId;

	}

	public static boolean updateExam(Exam exam) {

		try {
			Class.forName(driver);
			String updateExamQry = "UPDATE exam SET name = ? WHERE exam_id = ?";

			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement preparedStatement = connection.prepareStatement(updateExamQry);

			preparedStatement.setString(1, exam.getName());
			preparedStatement.setInt(2, exam.getExamId());

			if (preparedStatement.executeUpdate() > 0) {
				return true;
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public static boolean updateQuestions(List<Question> questionsList) {

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);
			String sqlString = "UPDATE question SET question = ?, option1 = ?, option2=?, option3=?, option4=?, correct_answer=? WHERE exam_id=?";
			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			for (Question question : questionsList) {
				System.out.print("DBHElper: " + question.getQuestion());
				preparedStatement.setString(1, question.getQuestion());
				preparedStatement.setString(2, question.getOption1());
				preparedStatement.setString(3, question.getOption2());
				preparedStatement.setString(4, question.getOption3());
				preparedStatement.setString(5, question.getOption4());
				preparedStatement.setString(6, question.getCorrectAnswer());
				preparedStatement.setInt(7, question.getExamId());
				preparedStatement.addBatch();
			}

			if (preparedStatement.executeBatch().length == questionsList.size()) {
				System.out.println("Questions Updated");
				return true;
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static List<Exam> getExamsList(int categoryId) {
		List<Exam> examList = new ArrayList<Exam>();

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement stmt = connection.prepareStatement("Select * from exam WHERE category_id = ?");
			stmt.setInt(1, categoryId);
			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				Exam exam = new Exam();
				exam.setExamId(resultSet.getInt(1));
				exam.setCategory(resultSet.getInt(2));
				exam.setName(resultSet.getString(3));
				examList.add(exam);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return examList;
	}

	public static List<Exam> getExamsList() {
		List<Exam> examList = new ArrayList<Exam>();

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			Statement stmt = connection.createStatement();

			ResultSet resultSet = stmt.executeQuery("Select * from exam");

			while (resultSet.next()) {
				Exam exam = new Exam();
				exam.setExamId(resultSet.getInt(1));
				exam.setCategory(resultSet.getInt(2));
				exam.setName(resultSet.getString(3));
				examList.add(exam);
			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return examList;
	}

	public static Exam getExam(int examId) {
		Exam exam = null;

		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			PreparedStatement stmt = connection.prepareStatement("Select * from exam WHERE exam_id=?");
			stmt.setInt(1, examId);
			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				exam = new Exam();
				exam.setExamId(resultSet.getInt(1));
				exam.setCategory(resultSet.getInt(2));
				exam.setName(resultSet.getString(3));

			}

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return exam;
	}

	public static String[][] categoryExam() {
		String[][] categoryExam;
		List<Category> categoryList = DBHelper.getCategoryList();

		int totalCategories = categoryList.size();

		categoryExam = new String[totalCategories][];

		for (int i = 0; i < totalCategories; i++) {
			int numberOfExams = DBHelper.getExamsList(i + 1).size();
			if (numberOfExams > 0)
				categoryExam[i] = new String[numberOfExams];
			else
				categoryExam[i] = new String[0];
		}

		return categoryExam;
	}

	public static boolean deletequestion(int questionId) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "DELETE FROM question WHERE question_id = ?";

			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			preparedStatement.setInt(1, questionId);
			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean deleteExam(int examId) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "DELETE FROM exam WHERE exam_id = ?";

			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			preparedStatement.setInt(1, examId);
			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean deleteQuestions(int examId) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "DELETE FROM question WHERE exam_id = ?";

			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			preparedStatement.setInt(1, examId);
			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean deleteuser(int userId) {
		try {
			Class.forName(driver);
			Connection connection = DriverManager.getConnection(connectionURL, userName, userPassword);

			String sqlString = "DELETE FROM user WHERE user_id = ?";

			PreparedStatement preparedStatement = connection.prepareStatement(sqlString);
			preparedStatement.setInt(1, userId);
			if (preparedStatement.executeUpdate() > 0)
				return true;

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}