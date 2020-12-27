<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<FORM METHOD="POST" ACTION="http://jkorpela.fi/cgi-bin/echo.cgi">
<TABLE BORDER="1" width="500px">
  <TR>
    <TD colspan="2">Question</TD>
    
  </TR>
  <TR>
    <TD><input type="radio" name="option 1" value="option 1"> Option 1</TD>
    <TD><input type="radio" name="option 2" value="option 2"> Option 2</TD>
  </TR>
  <TR>
    <TD><input type="radio" name="option 3" value="option 3"> Option 3</TD>
    <TD><input type="radio" name="option 4" value="option 4"> Option 4</TD>
  </TR>
  <TR>
    <TD  colspan="2"><INPUT TYPE="SUBMIT" VALUE="Submit" NAME="B1"></TD>
    
  </TR>
  
</TABLE>

</FORM>


</body>
</html>