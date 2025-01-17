<%-- 
    Document   : adminlogin
    Created on : 13 Jan, 2025, 6:04:36 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Login</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100">
        <div class="h-screen flex justify-center items-center">
            <div class="w-full max-w-sm bg-white rounded-lg shadow-md p-6">
                <h2 class="text-2xl font-semibold text-center text-gray-700 mb-6">Admin Login</h2>
                <form method="POST" action="adminlogin.jsp">
                    <div class="mb-4">
                        <label for="email" class="block text-gray-700 font-medium mb-2">Admin Email</label>
                        <input type="email" id="email" name="email" class="w-full px-4 py-2 border rounded-lg text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                        <input type="password" id="password" name="password" class="w-full px-4 py-2 border rounded-lg text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    </div>
                    <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg focus:outline-none">Login</button>
                </form>
                <%
                    String hardcodedEmail = "admin_of_rentle@gmail.com";
                    String hardcodedPassword = "Everything";
                    
                    String inputEmail = request.getParameter("email");
                    String inputPassword = request.getParameter("password");
                    
                    if (inputEmail != null && inputPassword != null) {
                        if (hardcodedEmail.equals(inputEmail) && hardcodedPassword.equals(inputPassword)) {
                            session.setAttribute("admin", "adminLoggedIn");
                            response.sendRedirect("/pages/admin.jsp?page=dashboard");
                        } else if (inputEmail != null && inputPassword != null) {
                            out.print("<p class='text-red-500 text-center mt-4'>Invalid credentials</p>");
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
