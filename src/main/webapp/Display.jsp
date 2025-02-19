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

	<form class="d-flex mt-3" role="search"  method="GET" action="./DisplayStudent">
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
			<tr>
				<td class= "<%= cls %>" > <%= rno %> </td>
				<td class= "<%= cls %>" > <%= name %> </td>
				<td class= "<%= cls %>" > <%= per %>  </td>
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