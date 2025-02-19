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
		var status = confirm("Do you want Update record for Roll number : " +  trno);
		if(status)
		{
			row = document.getElementById(trno); 
			td	= row.getElementsByTagName("td"); 
			trno =  td[0].textContent;
			tname = td[1].querySelector("input").value;
			tper =  td[2].querySelector("input").value;
			
			
			fetch('http://localhost:8080/ClassApp/UpdateStudent', { 
					method: 'POST',	
					body : new URLSearchParams({'rno': trno,'name':tname,'per':tper})}
				 )
			.then(response => response.text() )
			.then(data => {
				if (data.trim() == 'Failed')
				{
					alert("Unable to Update Record due to invlid Input !!");
				}
				else if(data.trim() =='Updated')
				{
					alert("Record is Updated Successfully " + trno);
				}
				else if( data.trim() == 'NotExist')
				{
					alert("Record is not Found for Roll Numbr :" + trno);
				}
				else if( data.trim() == 'Empty-Field')
				{
					alert("You can not keep any field Empty !!!");
				}
				else if( data.trim() == 'Invalid-per')
				{
					alert("Percentage is Invalid for Updation !!!");
				}
				else
				{
					alert("Unable to Delete Record for Roll Numbr :" + trno);
				}
				
			})
			.catch(error=> console.error("MyError:" , error))
			
			
			
			alert(trno+"--"+tname+"--"+tper);
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

	<form class="d-flex mt-3" role="search"  method="GET" action="./UpdateStudent">
          <input class="form-control me-2" type="search"     name="rno"  value="<%= srno %>" placeholder="Roll Num" aria-label="Search">
          <button class="btn btn-success me-2" type="submit" name="sbtn" value="Search"> Search</button>
          <button class="btn btn-success me-2" type="submit" name="sbtn" value="Refresh"> Refresh</button>
        </form>
</div>

<!-- table logic -->

<div class="d-flex  justify-content-center">

<table class="table table-bordered text-center w-75 ">
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
		for(Student ob  : L) // ob  : 101 AAA 60
		{
			int rno = ob.getRno();
			String name = ob.getName();
			double per = ob.getPer();
			String cls="";
			
			
			if(per < 40.0)
			{
				cls="";
			}
%>
			<tr id="<%= rno %>">
				<td class= "<%= cls %>" ><%= rno %></td>
				<td class= "<%= cls %>" >  <input class = "form-control me-2 border-danger border-2" type="text"  value="<%= name %>">   </td>
				<td class= "<%= cls %>" >  <input class = "form-control me-2 border-danger border-2" type="text" value="<%= per %>">     </td>
				<td class= "<%= cls %>" >  <button type="button" class="btn btn-danger" onclick="display(<%= rno %>)">Update</button>  </td>
			</tr>
<%		
		}//for
	}//else

%>


</tbody>

</table>

</div>

</div> <!--  container wala div -->



</body>
</html>