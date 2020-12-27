<!DOCTYPE html>
<%@page import="modals.Exam"%>
<%@page import="database.DBHelper"%>
<%@page import="modals.User"%>
<%@page import="java.util.List"%>
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
  <script type="text/javascript">
  
  function editExam(id){
	  var f=document.form;
	  f.method="post";
	  f.action='edit_exam.jsp?id='+id
      f.submit();
  }
  
function deleteExam(id){	  
	  var answer=confirm('Are you sure?');
	  if(answer){
		  var f=document.form;  
		  f.method="post";
		  f.action='delete_exam.jsp?id='+id
	      f.submit();
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
	} else if(request.getParameter("deleteResult")!=null) {%>
		<script>alert('<%=request.getParameter("deleteResult")%>')</script>
	<%}
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
            Users Data</div>
          <div class="card-body">
            <div class="table-responsive">
            <form method="post" name="form">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                  	<th>Category Id</th>
                    <th>Exam Id</th>
                    <th>Exam Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                  	<th>Category Id</th>
                    <th>Exam Id</th>
                    <th>Exam Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                  </tr>
                </tfoot>
                <tbody>
                <% 
                	List<Exam> examList = DBHelper.getExamsList();
                	for(int i=0;i<examList.size();i++) {
                %>
                  <tr>
                  	<td><%= examList.get(i).getCategory() %></td>
                    <td><%= examList.get(i).getExamId() %></td>
                    <td><%= examList.get(i).getName() %></td>
                    <td>
                    <input type="button" name="edit" value="View/Edit" style="background-color:green;font-weight:bold;color:white;" onclick="editExam(<%= examList.get(i).getExamId() %>);">
                   </td> 
                    <td>
                    <input type="button" name="delete" value="Delete" style="background-color:green;font-weight:bold;color:white;" onclick="deleteExam(<%=examList.get(i).getExamId()%>);">
                   </td> 
                  </tr>
				
				<%       } 
                	
				%>
				
				</tbody>
              </table>
              </form>
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
