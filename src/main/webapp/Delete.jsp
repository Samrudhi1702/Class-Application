<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tca.entities.Student" %>

 <%@ include file="Header.jsp" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function display(trno)
	{
		var status = confirm("Do you want delete record for Roll number : " +  trno);
		if(status)
		{
			fetch('http://localhost:8080/ClassApp/DeleteStudent', { 
					method: 'POST',	
					body : new URLSearchParams({'rno': trno})}
				 )
			.then(response => response.text() )
			.then(data => {
				if (data.trim() == 'Failed')
				{
					alert("Server is Down...Unable to Delete Record");
				}
				else if(data.trim() =='Deleted')
				{
					alert("Record is Deleted Successfully " + trno);
					var tr = document.getElementById(trno);
					tr.remove(); 
				}
				else if( data.trim() == 'NotExist')
				{
					alert("Record is not Found for Roll Numbr :" + trno);
				}
				else
				{
					alert("Unable to Delete Record for Roll Numbr :" + trno);
				}
				
			})
			.catch(error=> console.error("MyError:" , error))
		}
	}
</script>

</head>
<body>

<%
	String sbtn = request.getParameter("sbtn");
	String srno = request.getParameter("rno");

	if(srno == null || sbtn.equals("Refresh"))
		srno = "";
%>

<div class="container" style="margin-top: 100px;">
<h2 class="text-center mb-3"> Student Information </h2>

<!--  Search form  -->
<div class="mb-3 col-4 ms-auto">

	<form class="d-flex mt-3" role="search"  method="GET" action="./DeleteStudent">
          <input class="form-control me-2" type="search"     name="rno"  value="<%= srno %>" placeholder="Roll Num" aria-label="Search">
          <button class="btn btn-success me-2" type="submit" name="sbtn" value="Search"> Search</button>
          <button class="btn btn-success me-2" type="submit" name="sbtn" value="Refresh"> Refresh</button>
        </form>
</div>

<!-- table logic -->

<div class="d-flex  justify-content-center">

<table class="table table-hover text-center w-75 ">
<thead>
	<tr class="table-primary">
      
      <th scope="col">Roll Num</th>
      <th scope="col">Name</th>
      <th scope="col">Percentage</th>
      <th scope="col">Action</th>
    </tr>
</thead>

<tbody>

<%
	List<Student>  L = (List<Student>) request.getAttribute("listOfStudents");
	
	if(L==null || L.isEmpty())
	{
%>

		<tr> <td colspan="3" class="text-center text-danger  fst-italic"> NO DATA FOUND !! </td> </tr>
<% 
	}
	else
	{
		for(Student ob  : L) 
		{
			int rno = ob.getRno();
			String name = ob.getName();
			double per = ob.getPer();
			String cls="";
			
			
			if(per < 40.0)
			{
				cls="bg-danger-subtle";
			}
%>
			<tr id="<%= rno %>">
				<td class= "<%= cls %>" > <%= rno %> </td>
				<td class= "<%= cls %>" > <%= name %> </td>
				<td class= "<%= cls %>" > <%= per %>  </td>
				<td class= "<%= cls %>" >  <button type="button" class="btn btn-danger" onclick="display(<%= rno %>)">Delete</button>  </td>
			</tr>
<%		
		}
	}

%>

</tbody>

</table>

</div>

</div> 



</body>
</html>