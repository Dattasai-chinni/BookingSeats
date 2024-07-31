<!Doctype>
<html>
<head><title>welcome</title></head>
<body>
<%    
String  username = (String) session.getAttribute("username");
if(username == null){
	response.sendRedirect("login.jsp");
}




%>

<h1>Welcome, <%= username %>!</h1>
    <p>You have successfully logged in.</p>
    
     <form action="logout" method="post">
        <input type="submit" value="Logout" />
    </form>
   <form action="seating" method = "post">
         <input type = "submit" value ="seating"/> 
   
   
   </form>

</body>


</html>