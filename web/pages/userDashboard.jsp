<%-- 
    Document   : profile
    Created on : 22 Sep, 2024, 9:24:31 PM
    Author     : Srikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
       <title>User Dashboard</title>
    </head>
    <body>
        <section>
        <jsp:include page="../components/header.jsp"/>
        <div class="flex pt-24">
            <div class="w-[25rem] bg-gray-500 h-[90vh] p-10 text-3xl font-semibold">
                <ul>
                    <li class="pb-6 hover:text-white"><a href="#">Dashboard</a></li>
                    <li class="pb-6 hover:text-white"><a href="#">Transactions</a></li>
                    <li class="pb-6 hover:text-white"><a href="#">KYC</a></li>
                    <li class="pb-6 hover:text-white"><a href="#">help & Support</a></li>
                </ul>
                <button class="hover:text-white" type="submit"><a href="#">Logout</a></button>
            </div>
            <div class="flex w-full ">
                <div class="w-1/2 h-[78vh] p-16">
                    <div class="h-80 w-[40rem] bg-gray-500 flex justify-center items-center ">
                        <div class="h-52 w-52 rounded-full bg-blue-500 ">
                            
                        </div>
                    </div>
                    <div class="h-96 w-[40rem] mt-10 bg-gray-500 rounded-lg font-semibold text-2xl p-16">
                        <p >John Doe</p> <hr class="pb-4">
                        <p >1234567890</p> <hr class="pb-4">
                        <p >john@gmail.com</p> <hr class="pb-4">
                        <p >Address</p> <hr class="pb-4"> <br> <hr class="pb-4">
                        <button type="submit" class="font-normal text-xl w-full bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600 transition duration-200 transform hover:scale-105">Save</button>
                    </div>
                    
                </div>
                <div class="h-[90vh] w-1/2 pt-16">
                    <div class="h-[38rem] w-[40rem] p-4 bg-gray-500 ">
                        
                    </div>
                    <div class="w-[40rem] p-4 mt-10  grid grid-cols-2 gap-6 text-xl">
                        <button type="submit" class=" bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600 transition duration-200 transform hover:scale-105">Get Premium</button>
                        <button type="submit" class=" bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600 transition duration-200 transform hover:scale-105">Register as an org.</button>
                    </div>
                </div>
            </div>
        </div>
        </section>
    </body>
</html>
