package com.tca.student;

import java.io.IOException;
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


@WebServlet("/DisplayStudent")
public class DisplayStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
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
				qry = "select * from student where rno = "+ srno;
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
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Display.jsp");
		rd.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
