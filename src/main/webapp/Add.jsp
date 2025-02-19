<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class ="container" style="margin-top:100px;">
	<h2 class="text-center mb-5 text-primary" > Registration form</h2>
	<form method="POST" action="./AddStudent">
	
		<div class="mb-3 row">
    			<label for="inputPassword" class="col-sm-2 col-form-label">Roll Num:</label>
    		<div class="col-sm-10">
      			<input type="text" name="rno" class="form-control" id="inputPassword">
    		</div>
  		</div>
  		
  		<div class="mb-3 row">
    			<label for="inputPassword" class="col-sm-2 col-form-label">Name:</label>
    		<div class="col-sm-10">
      			<input type="text" name="name" class="form-control" id="inputPassword">
    		</div>
  		</div>
  		
  		
  		<div class="mb-3 row">
    			<label for="inputPassword" class="col-sm-2 col-form-label">Percentage:</label>
    		<div class="col-sm-10">
      			<input type="text" name="per" class="form-control" id="inputPassword">
    		</div>
  		</div>
  		
		<div class="d-grid gap-2 col-4 mx-auto">
  			<input class="btn btn-primary" type="submit" value="Save">
		</div>
	</form>
	
	<p> ${message}  </p>
	
</div>

</body>
</html>