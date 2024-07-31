package com.loginpage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the selected seats from the request
        String selectedSeats = request.getParameter("selectedSeats");

        // Get the session
        HttpSession session = request.getSession();

        // Get previously blocked seats
        String blockedSeats = (String) session.getAttribute("blockedSeats");
        if (blockedSeats == null) {
            blockedSeats = "";
        }
        
        // Append new selected seats to blocked seats
        if (selectedSeats != null && !selectedSeats.isEmpty()) {
            if (!blockedSeats.isEmpty()) {
                blockedSeats += ",";
            }
            blockedSeats += selectedSeats;
        }

        // Store the updated blocked seats in the session
        session.setAttribute("blockedSeats", blockedSeats);

        // Redirect to a confirmation or success page
        response.sendRedirect("confirmation.jsp");
    }
}
