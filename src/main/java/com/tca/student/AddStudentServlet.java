package com.tca.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddStudent")
public class AddStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("./Add.jsp");
		rd.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		
		String msg="";
		
		
		Connection con =null;
		PreparedStatement ps = null;
		
		
		String dbURL = "jdbc:postgresql://localhost/ajdb";
		String user  = "root1";
		String pwd   = "root@123";
		
		
		
		try
		{
			Class.forName("org.postgresql.Driver");
			con = DriverManager.getConnection(dbURL,user, pwd);
			
			int rno = Integer.parseInt(request.getParameter("rno"));  		  
			String name= request.getParameter("name");
			double per = Double.parseDouble( request.getParameter("per"));

			
			ps = con.prepareStatement("insert into student values(?,?,?)");
			ps.setInt(1, rno);
			ps.setString(2, name);
			ps.setDouble(3, per);
			ps.executeUpdate();
			
			msg = "<div class='alert alert-success text-center col-8 mx-auto' role='alert'> Record is Saved Successfully </div>";
		}
		
	
		
		catch(Exception e) {
		    e.printStackTrace(); // Logs the actual error for debugging
		    msg = "<div class='alert alert-danger text-center col-8 mx-auto' role='alert'> Unable to save Record: " + e.getMessage() + "</div>";
		}
		
		finally
		{
			try 
			{
				con.close();
			} catch (SQLException e) 
			{
				//e.printStackTrace();
				msg = "<div class='alert alert-danger text-center col-8 mx-auto' role='alert'>Unable save Record !!! </div>";
				
			}
		}
		
		
		request.setAttribute("message", msg);
		
		RequestDispatcher rd = request.getRequestDispatcher("./Add.jsp");
		rd.forward(request, response);
		
	}

}
