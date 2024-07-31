package com.loginpage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DatabaseUtil.Database;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		PrintWriter writer = response.getWriter();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmpassword = request.getParameter("confirmpassword");
		if(!password.equals(confirmpassword)) {
			writer.println("passwords missmatch");
			
		}
		
		try (Connection connection = Database.getConnection()) {
			String query = "insert into register(username,password,confirmpassword) values(?,?,?)";
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, username);
			statement.setString(2, password);
			statement.setString(3, confirmpassword);
			statement.executeUpdate();


			response.sendRedirect("login.jsp");
		} catch (SQLException e) {
			throw new ServletException(e);
		}
		
		
	}

}
