<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
</head>
<body>
    <h1>Booking Confirmation</h1>
    <%
        String blockedSeats = (String) session.getAttribute("blockedSeats");

        if (blockedSeats == null || blockedSeats.isEmpty()) {
            out.print("<p>No seats blocked.</p>");
        } else {
            out.print("<p>Blocked seats: " + blockedSeats + "</p>");
        }
    %>
    <a href="seating.jsp">Go back to Seating Page</a>
</body>
</html>
