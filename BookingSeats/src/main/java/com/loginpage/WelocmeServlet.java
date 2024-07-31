package com.loginpage;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/seating")
public class WelocmeServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if(session!=null && session.getAttribute("username")!=null) {
			response.sendRedirect("seating.jsp");
		}else {
			response.sendRedirect("login.jsp");
		}
	}

}
