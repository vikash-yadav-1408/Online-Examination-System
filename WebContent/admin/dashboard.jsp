<%@page import="modals.Category"%>
<%@page import="modals.Exam"%>
<%@page import="java.util.List"%>
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

  <title>Admin - Home</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		  response.setHeader("pragma","no-cache");  
	  String sessionMessage = (String)session.getAttribute("sessionMessage");
	  if(sessionMessage==null){
		  System.out.println("Session Message = " + sessionMessage);
		  response.sendRedirect("index.jsp?loginMessage=Session has terminated. Please log in again"); 
	  }
%>

<body id="page-top">

  <jsp:include page="header.jsp"></jsp:include>
  <div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp"></jsp:include>
    
    <div id="content-wrapper" style="background-color:#ffffff;">

          <!-- DataTables Example -->
          <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Exams Data</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                  	<th>Category Id</th>
                    <th>Category</th>
                    <th>Exam Id</th>
                    <th>Exam Name</th>
                    <th>Number of Questions</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                  	<th>Category Id</th>
                    <th>Category</th>
                    <th>Exam Id</th>
                    <th>Exam Name</th>
                    <th>Number of Questions</th>
                  </tr>
                </tfoot>
                <tbody>
                <% 
                	List<Category> categoryList = DBHelper.getCategoryList();
                	for(int i=0;i<categoryList.size();i++) {
                		List<Exam> examList = DBHelper.getExamsList(categoryList.get(i).getCategoryId());
                		for(int j=0;j<examList.size();j++) {
                %>
                  <tr>
                  	<td><%= categoryList.get(i).getCategoryId() %></td>
                    <td><%= categoryList.get(i).getName().toUpperCase() %></td>
                    <td><%= examList.get(j).getExamId() %></td>
                    <td><%= examList.get(j).getName() %></td>
                    <td><%= DBHelper.getNumOfQuestions(examList.get(j).getExamId()) %></td>
                  </tr>
				
				<%       } 
                	}
				%>
				
				</tbody>
              </table>
            </div>
          </div>
        </div>
      <!-- /.container-fluid -->
    </div>
    <!-- /.content-wrapper -->
    
      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © Online Examination 2019</span>
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

  <jsp:include page="logout_modal.jsp"></jsp:include>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/chart.js/Chart.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>
  <script src="js/demo/chart-area-demo.js"></script>

</body>

</html>
