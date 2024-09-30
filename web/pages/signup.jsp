<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <link href="../styles/utils.css" rel="stylesheet">
        <title>sign-up Page</title>
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
                <div class="w-2/5 h-screen bg-medium">
                    <!-- Right Section -->
                </div>
            </div>

            <div class="absolute inset-0 flex justify-center items-center ">
                <div class="flex w-2/5 h-3/5 shadow-2xl">
                    <div class="w-2/5 bg-primary">
                        <img class="h-80 w-72 mt-28 m-auto" src="../assets/images/loginimg.png">
                    </div>
                    <div class="w-3/5  p-8 bg-white">
                        <h2 class="text-3xl font-bold text-center mt-8 text-gray-800 mb-">Sign-up to Rental</h2>
                        <form>
                            <div class="mb-6">
                                <label for="email" class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                                <input type="email" id="username" name="email" placeholder="Enter your email" class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none focus:ring focus:ring-blue-300 transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="phone" class="block text-gray-700 text-sm font-bold mb-2">Phone number</label>
                                <input type="text" id="username" name="phone" placeholder="Enter your phone number" class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none focus:ring focus:ring-blue-300 transition duration-200" required aria-required="true">
                            </div>
                            <div class="mb-6">
                                <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter your password" class="w-full px-3 py-2 placeholder-gray-400 border rounded-lg focus:outline-none focus:ring focus:ring-blue-300 transition duration-200" required aria-required="true">
                            </div>
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center">
                                    <input type="checkbox" id="remember" name="remember" class="mr-2">
                                    <label for="remember" class="text-sm text-gray-600">Remember Me</label>
                                </div>
                            </div>
                            <button type="submit" class="primary-btn w-full">Sign-up</button>
                        </form>
                        <p class="mt-4 text-center text-sm text-gray-600">Already have an account? <a href="login.jsp" class="text-blue-500 hover:underline">Login</a></p>
                    </div>
                    
                </div>
            </div>
        </div>
    </body>
</html>
