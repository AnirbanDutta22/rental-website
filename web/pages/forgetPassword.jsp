<%-- 
    Document   : forgetPassword
    Created on : 14 Jan, 2025, 10:00:45 PM
    Author     : Srikanta
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String sentmsg = (String) session.getAttribute("successMessage");
    String verifymsg = (String) session.getAttribute("successOTPMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
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
    <title>Forget Password</title>
</head>
<body>
    <div class="relative">
        <a href="/pages/index.jsp" class="h-24 fixed w-28 m-10 z-50">
            <img src="../assets/images/logo.png" alt="logo" class="h-24"/>
        </a>
        <div class="flex w-full">
            <div class="w-2/5 h-screen bg-medium/60"></div>
            <div class="w-3/5 h-screen bg-white"></div>
        </div>

        <div class="absolute inset-0 flex justify-center items-center">
            <div class="flex w-3/6 min-h-[30rem] shadow-2xl">
                <div class="w-2/4 bg-primary flex items-center justify-center">
                    <img class="h-80 w-72 my-auto m-auto transition-opacity duration-1000 opacity-100 p-6" 
                         id="signupimg" src="../assets/images/3d/tv.png">
                </div>
                <div class="w-2/4 p-8 bg-white flex flex-col justify-center">
                    <h2 class="text-3xl font-bold text-center mt-4 mb-8 text-gray-800">
                        Forget Password
                    </h2>

                    <% if (sentmsg != null && sentmsg.equals("OTP sent to your email!")) { %>
                        <!-- OTP Verification Section -->
                        <form name="OtpForm" method="POST" action="/VerifyOtpServlet" class="flex flex-col justify-center items-center">
                            <div class="mb-6 text-center">
                                <label for="otp" class="block text-gray-700 text-sm font-bold mb-2">
                                    Enter the OTP sent to your registered email
                                </label>
                                <div class="flex justify-center gap-2">
                                    <input name="digit1" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit2" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit3" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                    <input name="digit4" type="text" maxlength="1" class="w-12 h-12 border rounded text-center" required>
                                </div>
                            </div>

                            <button type="submit" class="primary-btn w-2/4 mt-6">Verify OTP</button>
                            <p class="mt-4 text-center text-sm text-gray-600">
                                Already have an account? <a href="login.jsp" class="text-blue-500 hover:underline">Login</a>
                            </p>
                        </form>

                    <% session.removeAttribute("successMessage");
                        } else if (verifymsg != null && verifymsg.equals("OTP verified successfully!")) { %>
                        <!-- Password Reset Section -->
                        <form name="ResetPasswordForm" method="POST" action="/ResetPasswordServlet">
                            <div class="mb-6">
                                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">New Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter new password" required 
                                       class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>
                            <div class="mb-6">
                                <label for="confirmPassword" class="block text-gray-700 text-sm font-bold mb-2">Confirm Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required 
                                       class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>

                            <button type="submit" class="primary-btn w-full mt-4">Save Password</button>
                        </form>

                    <% } else { %>
                        <!-- Email Submission Section -->
                        <form name="ForgetPassword" method="POST" action="/RequestOtpServlet">
                            <div class="mb-6">
                                <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                                <input type="email" id="email" name="email" placeholder="Your email" required 
                                       class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none transition duration-200">
                            </div>

                            <button type="submit" class="primary-btn w-full">Verify Email</button>
                            <p class="mt-6 text-center text-md text-gray-600">
                                <a href="/pages/login.jsp" class="text-blue-500 hover:underline">Back to Login page</a>
                            </p>
                        </form>
                    <% } %>
                    
                    <!-- Show messages -->
                    <% if (errorMessage != null) { %>
                        <div class="my-2 font-medium text-red-500 text-center"><%= errorMessage %></div>
                        <% session.removeAttribute("errorMessage"); %>
                    <% } %>

                </div>
            </div>
        </div>
    </div>

    <script src="../scripts/auth.js"></script>
    <script>
        function closePopup() {
            const popup = document.getElementById("messagePopup");
            if (popup) {
                popup.style.display = "none";
            }
        }
    </script>
</body>
</html>
