<%-- 
    Document   : signup
    Created on : 27 Oct, 2024, 12:13:32 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <link href="../styles/utils.css" rel="stylesheet">
        <title>Sign-up Page</title>
    </head>
    <body>
        <div class="relative">
            <a href="/home" class="h-24 fixed w-28 m-10 z-50">
                <img src="../assets/images/logo.png" alt="logo" class="h-24"/>
            </a>

            <div class="flex w-full">
                <div class="w-3/5 h-screen bg-white">
                    <!-- Left Section -->
                </div>
                <div class="w-2/5 h-screen bg-medium/60">
                    <!-- Right Section -->
                </div>
            </div>

            <div class="absolute inset-0 flex justify-center items-center ">
                <div class="flex w-3/6 h-4/6 shadow-2xl">
                    <div class="w-2/4 bg-primary">
                        <img class="h-80 w-72 mt-28 m-auto transition-opacity duration-1000 opacity-100" id="signupimg" src="../assets/images/3d/tv.png">
                    </div>
                    <div class="w-2/4 p-8 bg-white">
                        <h2 class="text-3xl font-bold text-center my-5 text-gray-800 mb-">Sign-up to Rentle</h2>
                        <form name="Signup" method="POST" action="SignupServlet">
                            <div class="mb-6">
                                <label for="name" class="block text-gray-700 text-sm font-bold mb-2">Full Name</label>
                                <input type="text" id="name" name="name" placeholder="Your FullName" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                                <input type="email" id="email" name="email" placeholder="Your email" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="phno" class="block text-gray-700 text-sm font-bold mb-2">Phone number</label>
                                <input type="text" id="phno" name="phno" placeholder="Your phone number" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                                <input type="password" id="password" name="password" placeholder="Set a password" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200" required aria-required="true">
                            </div>
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center">
                                    <input type="checkbox" id="agreement" name="agreement" required class="mr-2">
                                    <label for="agreement" class="text-sm text-gray-600">I agree to the <span class="text-primary">terms and conditions</span></label>
                                </div>
                            </div>
                            <% if (request.getAttribute("errorMessage") != null || request.getAttribute("successMessage") != null) {%>
                            <div class="my-2 font-medium text-red-500">
                                <%= request.getAttribute("errorMessage")%>
                            </div>
                            <% }%>
                            <button type="submit" class="primary-btn hover:bg-primary-100 transition-all ease-in-out duration-300 w-full">Sign-up</button>
                        </form>
                        <p class="mt-4 text-center text-sm text-gray-600">Already have an account? <a href="login.jsp" class="text-blue-500 hover:underline">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
        <script src="../scripts/auth.js"></script>
    </body>
</html>

