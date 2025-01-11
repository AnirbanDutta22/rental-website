<%-- 
    Document   : signup
    Created on : 27 Oct, 2024, 1:29:09 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String msg = (String) session.getAttribute("successMessage");
    String errormsg = (String) session.getAttribute("otpErrorMessage");
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
                    @apply text-white bg-primary hover:bg-primary-100 transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
                }
            }
        </style>
        <title>Sign-up Page</title>
    </head>
    <body>
        <div class="relative">
            <% if (msg != null && errormsg == null) {%>
            <div id="messagePopup" class="fixed inset-0 bg-black/50 flex justify-center items-center z-50">
                <div class="bg-white rounded-lg shadow-lg w-96 p-6 text-center">
                    <h2 class="text-lg font-semibold text-gray-800 mb-4">Notification</h2>
                    <p class="text-gray-600 mb-6"><%= msg%></p>
                    <button onclick="closePopup()" class="primary-btn w-full">Close</button>
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
                <div class="flex w-3/6 min-h-[35rem] shadow-2xl">
                    <div class="w-2/4 bg-primary flex items-center justify-center">
                        <img class="h-80 w-72 my-auto m-auto transition-opacity duration-1000 opacity-100 p-6" id="signupimg" src="../assets/images/3d/tv.png">
                    </div>
                    <div class="w-2/4 p-8 bg-white flex flex-col justify-center">
                        <h2 class="text-3xl font-bold text-center mt-4 mb-8 text-gray-800 mb-">
                            <% if ("OTP sent to your email !".equals(msg)) { %>
                            Enter OTP
                            <% } else { %>
                            Sign-up to Rentle
                            <% } %>
                        </h2>
                        <% if ("OTP sent to your email !".equals(msg)) { %>
                        <!-- OTP Input Form -->
                        <form name="OtpForm" method="POST" action="/OTPVerificationServlet" class="flex flex-col justify-center items-center">
                            <div class="mb-6 text-center">
                                <label for="otp" class="block text-gray-700 text-sm font-bold mb-2">Enter the OTP sent to your registered email</label>
                                <div class="flex justify-center gap-2">
                                    <input name="digit1" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit2" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit3" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit4" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                </div>
                            </div>
                            <% if (errormsg != null) {%>
                            <div class="my-2 font-medium text-red-500">
                                <%= errormsg%>
                            </div>
                            <% } %>
                            <button type="submit" class="primary-btn w-2/4 mt-6">Verify OTP</button>
                            <p class="mt-4 text-center text-sm text-gray-600">Already have an account? <a href="login.jsp" class="text-blue-500 hover:underline">Login</a></p>
                        </form>
                        <%--session.removeAttribute("successMessage");--%>
                        <% } else { %>
                        <!-- Sign-up Form -->
                        <form name="Signup" method="POST" action="/SignupServlet">
                            <div class="mb-6">
                                <label for="name" class="block text-gray-700 text-sm font-bold mb-2">Full Name</label>
                                <input type="text" id="name" name="name" placeholder="Your Full Name" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>
                            <div class="mb-6">
                                <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                                <input type="email" id="email" name="email" placeholder="Your email" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>
                            <div class="mb-6">
                                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                                <input type="password" id="password" name="password" placeholder="Set a password" required class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center">
                                    <input type="checkbox" id="agreement" name="agreement" required class="mr-2">
                                    <label for="agreement" class="text-sm text-gray-600">I agree to the <span class="text-primary">terms and conditions</span></label>
                                </div>
                            </div>
                            <% if (request.getAttribute("errorMessage") != null) {%>
                            <div class="my-2 font-medium text-red-500">
                                <%= request.getAttribute("errorMessage")%>
                            </div>
                            <% } %>
                            <button type="submit" class="primary-btn w-full">Continue</button>
                        </form>
                        <p class="mt-4 text-center text-sm text-gray-600">Already have an account? <a href="/pages/login.jsp" class="text-blue-500 hover:underline">Login</a></p>
                        <% }%>
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
