<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function display(name)
	{
		alert("Hello " + name + ", this is my First JS");	
		// call a Delete servelet to delete record for rno= 101
	}
	
	function show()
	{
		var h1 = document.getElementById("101");
		h1.innerText = "Welcome to Pune";
	}
	
	function make()
	{
		var sn = document.getElementById("sn");
		var s = sn.value;  // s --> "sachin"
		sn.value = s.toUpperCase();  // value-->"SACHIN"
	}
	
</script>
</head>
<body>

<h1 id="101"> Welcome to TCA </h1> <br>

<input type="button" Value="Click here" onclick="display(101)"> <br>
--------------------------------------------------------- <br>
<input type="button" value="Show" onclick="show()"> <br>
--------------------------------------------------------- <br>

<input type="text" name="sname" id="sn" onkeydown="make()"> <br>

<input type="button" value="make" onclick="make()">

</body>
</html>



