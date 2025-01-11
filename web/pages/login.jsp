<%-- 
    Document   : login
    Created on : 27 Oct, 2024, 1:29:09 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String msg = (String) session.getAttribute("signupSuccessMessage");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <style type="text/tailwindcss">
            @layer components {
                .primary-btn {
                    @apply text-white bg-primary transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
                }
            }</style>
        <title>Login Page</title>
    </head>
    <body>
        <div class="relative">
            <% if (msg != null) {%>
            <div id="messagePopup" class="fixed inset-0 bg-black/50 flex justify-center items-center z-50">
                <div class="bg-white rounded-lg shadow-lg w-96 p-6 text-center">
                    <p class="text-gray-600 mb-6"><%= msg%></p>
                    <button onclick="closePopup()" class="primary-btn w-full">Close</button>
                    <%session.removeAttribute("successMessage");%>
                </div>
            </div>
            <%} %>
            <a href="/pages/index.jsp" class="h-24 fixed w-28 m-10 z-50">
                <img src="../assets/images/logo.png" alt="logo" class="h-24"/>
            </a>
            <div class="flex w-full">
                <div class="w-2/5 h-screen bg-medium/60">

                </div>
                <div class="w-3/5 h-screen bg-white">

                </div>
            </div>

            <div class="absolute inset-0 flex justify-center items-center">
                <div class="flex w-3/6 h-auto shadow-2xl">
                    <div class="w-2/4 bg-primary">
                        <img class="h-80 w-72 mt-28 m-auto transition-opacity duration-1000" id="loginimg" src="../assets/images/3d/tv.png">
                    </div>
                    <div class="w-2/4  p-8 bg-white">
                        <h2 class="text-3xl font-bold text-center mt-4 text-gray-800 mb-8">Login to Rental</h2>
                        <form name="Login" method="POST" action="/LoginServlet">
                            <div class="mb-6">
                                <label for="username" class="block text-gray-700 text-sm font-bold mb-2">Username/Email</label>
                                <input type="text" id="username" name="username" placeholder="Enter your username or email" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter your password" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center">
                                    <input type="checkbox" id="remember" name="remember" class="mr-2">
                                    <label for="remember" class="text-sm text-gray-600">Remember Me</label>
                                </div>
                                <a href="#" class="text-sm text-blue-500 hover:underline">Forgot Password?</a>
                            </div>
                            <% if (request.getAttribute("errorMessage") != null) {%>
                            <div class="my-2 font-medium text-red-500">
                                <%= request.getAttribute("errorMessage")%>
                            </div>
                            <% }%>
                            <button type="submit" class="primary-btn w-full">Login</button>
                        </form>
                        <p class="w-full text-center my-4">OR</p>
                        <p class="w-full text-center text-primary font-semibold underline"><a href="#">Login with Phone number</a></p>
                        <p class="mt-6 text-center text-sm text-gray-600">Don't have an account? <a href="/pages/signup.jsp" class="text-blue-500 hover:underline">Sign up</a></p>
                    </div>
                </div>
            </div>
        </div>
        <script src="../scripts/auth.js"></script>
        <script>
                        function closePopup() {
                            // Hide the popup when the "Close" button is clicked
                            const popup = document.getElementById("messagePopup");
                            if (popup) {
                                popup.style.display = "none";
                            }
                        }
        </script>
    </body>
</html>

