<%-- 
    Document   : profile
    Created on : 22 Sep, 2024, 9:24:31 PM
    Author     : Srikanta
--%>

<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User) session.getAttribute("user");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <script src="https://kit.fontawesome.com/cb3d6578eb.js" crossorigin="anonymous"></script>
        <title>User Dashboard</title>
    </head>
    <body>
        <section>
            <div class="flex font-lato">
                <div class="w-[18rem] fixed top-0 left-0 bg-gray-50 h-screen px-10 py-4 text-xl font-medium shadow-md">
                    <a href="/home" class="flex items-center space-x-3 rtl:space-x-reverse">
                        <img src="../assets/images/logo.png" class="h-20" alt="Rentle Logo">
                    </a>
                    <ul class="my-10">
                        <li class="pb-8"><a href="userDashboard.jsp"><i class="fa-solid fa-gauge mr-4"></i>Dashboard</a></li>
                        <li class="pb-8"><i class="fa-solid fa-tags mr-4"></i>Products<i class="fa-solid fa-angle-down ml-6 cursor-pointer" id="downArrow" onclick="openProductDropdown()"></i>
                            <ul id="productDropdown" class="hidden text-lg px-10 pt-2">
                                <li class="mt-2"><a href="userDashboard.jsp?page=lendProduct">Add Product</a></li>
                                <li class="mt-2"><a href="userDashboard.jsp?page=lendProduct">All Products</a></li>
                            </ul>
                        </li>
                        <li class="pb-8"><a href="userDashboard.jsp?page=transactions"><i class="fa-solid fa-wallet mr-4"></i>Transactions</a></li>
                        <li class="pb-8"><a href="userDashboard.jsp?page=kyc"><i class="fa-solid fa-id-card mr-4"></i>KYC</a></li>
                        <li class="pb-8"><a href="/pages/support.jsp"><i class="fa-solid fa-circle-info mr-4"></i>Help & Support</a></li>
                    </ul>
                    <form name="Logout" action="LogoutServlet" method="POST">
                        <button class="" type="submit"><i class="fa-solid fa-right-from-bracket mr-4"></i>Logout</button>
                    </form>
                </div>
                <div class="flex w-full flex-col pl-[18rem]">
                    <div class="w-full flex justify-end items-center gap-x-10 bg-gray-50 h-16 p-10 shadow-md">
                        <span class="text-lg">Welcome, <%= user.getName()%> !</span>
                        <i class="fa-regular fa-bell text-2xl"></i>
                        <img id="avatarButton" type="button" class="p-1 w-12 h-12 rounded-full ring-2 ring-primary dark:ring-gray-500" src="../assets/images/profile.jpg" alt=user-profile>
                    </div>
                    <div class="w-full p-16">
                        <jsp:include page="${param.page == 'lendProduct' ? '/components/user-dashboard/lendProduct.jsp' : param.page == 'transactions' ? '/components/user-dashboard/transactions.jsp' :  param.page == 'support' ? '/pages/support.jsp' :  param.page == 'kyc' ? '/components/user-dashboard/kyc.html' :  '/components//user-dashboard/profile.jsp'}" />
                    </div>
                </div>
            </div>
        </section>
        <script>
            var productDD = document.getElementById("productDropdown");
            var downArrow = document.getElementById("downArrow");

            function openProductDropdown() {
                if (productDD.classList.contains('hidden')) {
                    productDD.classList.remove('hidden');
                    downArrow.classList.add('fa-angle-up');
                } else {
                    productDD.classList.add('hidden');
                    downArrow.classList.remove('fa-angle-up');
                }
            }
        </script>
    </body>
</html>
