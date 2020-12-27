<%@page import="modals.Exam"%>
<%@page import="database.DBHelper"%>
<%@page import="modals.Question"%>
<%@page import="java.util.List"%>

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

  <title>Admin - Edit Exam</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
   <script type="text/javascript">
     

     function validateForm(){
    	var eName = document.forms.myForm.exam.value;
      	var category = document.forms.myForm.category.value;
      	
      	if (eName.trim() == "") {
     		alert("Exam Name can't be blank");
     		return false;
     	}

      	else if ( category.trim() == "")
     	{
     		alert("Category can't be blank");
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
		response.sendRedirect("index.jsp?loginMessage=Session has terminated. Please log in again"); 
	} else if(request.getParameter("id")!=null) {
		if(request.getParameter("editMessage")!=null) {
			%>
			<script>alert('<%=request.getParameter("editMessage")%>')</script>
		<%}
		int examId = Integer.parseInt(request.getParameter("id"));
		Exam exam = DBHelper.getExam(examId);
		List<Question> questionsList = DBHelper.getQuestionsList(examId);
%>

<body id="page-top">

  <jsp:include page="header.jsp"></jsp:include>

  <div id="wrapper">

    <!-- Sidebar -->
        <jsp:include page="sidebar.jsp"></jsp:include>
    

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Dashboard</a>
          </li>
          <li class="breadcrumb-item active">Edit Exams</li>
        </ol>
     <!-- DataTables Example -->
          <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Edit Exam</div>
          <div class="card-body">
          	<form  name="myForm" onsubmit="return validateForm()" action="../EditExam" method="get">         
	  			<div class="table-responsive">
              		<table class="table table-bordered"  style="width:100%;border-spacing: 0px;" >
		                <thead>
		                  <tr>
		                    <th>Question</th>
		                    <th>Option 1</th>
		                    <th>Option 2</th>
		                    <th>Option 3</th>
		                    <th>Option 4</th>
		                    <th>Correct Answer (1/2/3/4)</th>
		                  </tr>
		                </thead>
		                <tfoot>
		                  <tr>
		                    <th>Question</th>
		                    <th>Option 1</th>
		                    <th>Option 2</th>
		                    <th>Option 3</th>
		                    <th>Option 4</th>
		                    <th>Correct Answer</th>
		                  </tr>
		                </tfoot>
		                <tbody>
		                <tr>
							<td>Edit Exam</td>
							<td colspan=2>
								<div class="form-label-group">
				                  <input name="exam" type="text" id="exam" class="form-control" placeholder="Exam Name" value="<%=exam.getName() %>" required="required" autofocus="autofocus">
				                  <input name="examId" type="hidden" value="<%=examId %>">
				                  <label for="exam">Update Exam Name</label>
				                </div>            
							</td>             	  
						</tr>
		                <% for(int i = 0; i<questionsList.size(); i++) { %>
		                   <tr>
		                  	<td>
		                  		<input type="text" name="question<%=(i+1) %>" value="<%=questionsList.get(i).getQuestion() %>" class="form-control" placeholder="Question" required="required">
							</td>
		                    <td>
		                    	<input type="text" name="option<%=(i+1) %>1" value="<%=questionsList.get(i).getOption1() %>" class="form-control" placeholder="Option 1" required="required" autofocus="autofocus">
		                    </td>
		                    <td>
		                    	<input type="text" name="option<%=(i+1) %>2" value="<%=questionsList.get(i).getOption2() %>" class="form-control" placeholder="Option 2" required="required" autofocus="autofocus">
		                    </td>
		                    <td>
		                    	<input type="text" name="option<%=(i+1) %>3" value="<%=questionsList.get(i).getOption3() %>" class="form-control" placeholder="Option 3" required="required" autofocus="autofocus">
							</td>
		                    <td>
								<input type="text" name="option<%=(i+1) %>4" value="<%=questionsList.get(i).getOption4() %>" class="form-control" placeholder="Option 4" required="required" autofocus="autofocus">
							</td>
		                    <td>
								<input type="number" name="correct<%=(i+1) %>" value="<%=questionsList.get(i).getCorrectAnswer() %>" class="form-control" placeholder="Correct Answer" required="required" autofocus="autofocus">
							</td>
							
		                  </tr>

		                  <%} %>
						<tr>
							<td colspan="6"><input type="submit" name="submit" value="Update" class="btn btn-primary btn-block"></td>
							<td></td>
								<td colspan="2"></td>
							<td></td>
							<td></td>
						</tr>		                  
                		</tbody>
              		 </table>
            	  </div>
		  	    </form>
              </div>
           </div>

         </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Online Examination 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="logout.jsp">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>

</body>

<%} %>

</html>
