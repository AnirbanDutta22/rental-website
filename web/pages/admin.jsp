<%@page import="dao.AdminDAO"%>
<%@page import="utils.FetchData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <style>
            /* Hide all sections */
            .section {
                display: none;
            }
            /* Show the active section */
            .active {
                display: block;
            }
        </style>
    </head>
    <!-- Sidebar and Main Content Wrapper -->
    <div class="flex">
        <!-- Sidebar -->
        <div class="w-64 bg-gray-800 text-white h-screen p-6">
            <h2 class="text-2xl font-semibold mb-8">Admin Panel</h2>
            <ul>
                <li class="mb-4">
                    <a href="admin.jsp?page=dashboard" class="hover:bg-gray-700 block px-4 py-2 rounded" >Dashboard</a>
                </li>
                <li class="mb-4">
                    <a href="admin.jsp?page=user" class="hover:bg-gray-700 block px-4 py-2 rounded" >Manage Users</a>
                </li>
                <li class="mb-4">
                    <a href="admin.jsp?page=products" class="hover:bg-gray-700 block px-4 py-2 rounded" >Manage Products</a>
                </li>
                <li class="mb-4">
                    <a href="admin.jsp?page=category" class="hover:bg-gray-700 block px-4 py-2 rounded" >Manage Category</a>
                </li>
                <li class="mb-4">
                    <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" >Active Rentals</a>
                </li>
                <li class="mb-4">
                    <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" >Settings</a>
                </li>
                <li class="mb-4">
                    <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('database-overview')">Logout</a>
                </li>
            </ul>
        </div>
        <div class="w-full">
                <!-- Top Navbar -->
            <nav class="bg-gray-800 text-white py-4 px-6 flex ">
                <ul class="flex space-x-4 ml-auto">
                    <li><a href="#" class="hover:text-yellow-500">Dashboard</a></li>
                    <li><a href="#" class="hover:text-yellow-500">Profile</a></li>
                    <li><a href="#" class="hover:text-yellow-500">Logout</a></li>
                </ul>
            </nav>
        <!-- Main viewport -->
            <div class="flex-1 p-6">
                <jsp:include page="${param.page == 'dashboard' ? '/components/admin-dashboard/dashboard.jsp' : param.page == 'user' ? '/components/admin-dashboard/fetchUser.jsp' : param.page == 'products' ? '/components/admin-dashboard/fetchProduct.jsp' : param.page == 'category' ? '/components/admin-dashboard/fetchCategory.jsp' : '/components/admin-dashboard/dashboard.jsp'}" />
                    
            </div>
        </div>
    </div>

</html>
