<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seating Page</title>
    <style>
        table {
            width: 60%;
            margin: 0 auto;
            border-collapse: collapse;
        }
        td {
            border: 1px solid black;
            width: 50px;
            height: 50px;
            text-align: center;
            cursor: pointer;
        }
        .selected {
            background-color: green;
            color: white;
        }
        .blocked {
            background-color: red;
            color: white;
            cursor: not-allowed;
        }
        .gap {
            border: none;
        }
    </style>
    <script>
        let selectedSeats = 0;
        const maxSeats = 6;

        function selectSeat(seat) {
            if (seat.classList.contains('blocked')) {
                return;
            }
            if (seat.classList.contains('selected')) {
                seat.classList.remove('selected');
                selectedSeats--;
            } else if (selectedSeats < maxSeats) {
                seat.classList.add('selected');
                selectedSeats++;
            } else {
                alert('You can only select up to 6 seats.');
            }
            updateSelectedSeatsInput();
        }

        function updateSelectedSeatsInput() {
            const selectedSeatIds = Array.from(document.getElementsByClassName('selected')).map(seat => seat.id);
            document.getElementById('selectedSeats').value = selectedSeatIds.join(',');
        }

        function validateSelection() {
            if (selectedSeats === 0) {
                alert('Please select at least one seat before booking.');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h1>Welcome to Seating Page Screen!</h1>
    <%
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get blocked seats from session
        String blockedSeats = (String) session.getAttribute("blockedSeats");
        List<String> blockedSeatList = new ArrayList<>();
        if (blockedSeats != null && !blockedSeats.isEmpty()) {
            blockedSeatList = Arrays.asList(blockedSeats.split(","));
        }
    %>
    <h1>Seating Arrangement</h1>
    <p>Welcome, <%= username %>! Here is the seating arrangement.</p>
    <table>
        <% 
            char rowLabel = 'A';
            int cols = 12; // 10 seats + 2 gaps for 2 gaps after every 5 seats
            for (int i = 0; i < 10; i++) {
                out.print("<tr>");
                for (int j = 1; j <= cols; j++) {
                    if (j == 6 || j == 12) {
                        out.print("<td class='gap'></td>");
                    } else {
                        String seatId = "seat-" + rowLabel + "-" + (j > 5 ? j - 1 : j);
                        String seatLabel = rowLabel + (j > 5 ? String.valueOf(j - 1) : String.valueOf(j));
                        if (blockedSeatList.contains(seatId)) {
                            out.print("<td id='" + seatId + "' class='blocked'>" + seatLabel + "</td>");
                        } else {
                            out.print("<td id='" + seatId + "' onclick='selectSeat(this)'>" + seatLabel + "</td>");
                        }
                    }
                }
                out.print("</tr>");
                rowLabel++;
            }
        %>
    </table>
    
    <form action="booking" method="post" onsubmit="return validateSelection();">
        <input type="hidden" id="selectedSeats" name="selectedSeats" value=""/>
        <input type="submit" value="Book"/>
    </form>
</body>
</html>
