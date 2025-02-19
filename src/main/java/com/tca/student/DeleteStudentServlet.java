package com.tca.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tca.entities.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/DeleteStudent")
public class DeleteStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		/*
		 *  Purpose : Only Display student records in case -
		 * 	1. Directly called this servlet from URL
		 *  2. Through Serch Button from Delete.jsp
		 *  3. Through Referesh Button From Delete.jsp
		 */
	
		List<Student> L = new ArrayList<>();
		
		Connection con =null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String dbURL = "jdbc:postgresql://localhost/ajdb";
		String user  = "root1";
		String pwd   = "root@123";
		String qry   = "select * from student";
		
		try
		{
			Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection(dbURL,user, pwd);
			
			String sbtn = request.getParameter("sbtn"); // sbtn --> Refresh / Search
			
			String  srno = request.getParameter("rno");
			
			if(srno==null || srno.isEmpty() || sbtn.equals("Refresh")) // 
			{
				qry = "select * from student";
			
			}
			else
			{
				qry = "select * from student where rollno = "+ srno;
			}
			
			
			ps = con.prepareStatement(qry);
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				int rno = rs.getInt(1);
				String name = rs.getString(2);
				double per  = rs.getDouble(3);
				
				Student ob = new Student(rno, name, per);
				L.add(ob);
			}
			
			request.setAttribute("listOfStudents", L);
		}
		catch(Exception e)
		{
			request.setAttribute("listOfStudents", null);
		}
		finally
		{
			try
			{
				
				con.close();
				rs.close();
			}
			catch(Exception e)
			{
				request.setAttribute("listOfStudents", null);
			}
		}
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Delete.jsp");
		rd.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		/* Purpose : 
		 * Delete Student Record based on 'rno' where 'rno' is kept in 'request' object by JS
		 * This method will be called from Java Script when 'Delete' Button is clicked from Delete.jsp 
		 * 
		 */
		
		response.setContentType("text.html");
		PrintWriter out = response.getWriter();
		
		
		String srno= request.getParameter("rno");
		
		Connection con =null;
		PreparedStatement ps=null;
		
		String dbURL = "jdbc:postgresql://localhost/ajdb";
		String user  = "root1";
		String pwd   = "root@123";
		String qry   = "Delete FROM student where rollno = " + srno;
		
		try
		{
			Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection(dbURL,user, pwd);
			
			ps = con.prepareStatement(qry);
			
			int status = ps.executeUpdate();
			
			if(status==1)
			{
				out.println("Deleted");
			}
			else
			{
				out.println("NotExist");
			}
			
		}
		catch(Exception e)
		{
			out.println("Failed");
		}
		finally
		{
			try
			{  
				if(con!=null)
					con.close();
			}
			catch(Exception e)
			{
				out.println("Failed");
			}
		}
		
		//Failed\nFailed
		
		
	}

}




