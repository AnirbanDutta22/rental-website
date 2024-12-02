<%-- 
    Document   : dashboard
    Created on : 1 Dec, 2024, 7:22:08 PM
    Author     : Srikanta
--%>

<%@page import="dao.AdminDAO"%>
<%
    AdminDAO AdminDAO = new AdminDAO();
%>
<section id="dashboard">
    <h2 class="text-2xl font-semibold mb-6">Dashboard Overview</h2>
    <div class="grid grid-cols-3 gap-6">
        <div class="bg-blue-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Total Users</h3>
            <p class="text-3xl mt-4"><%= AdminDAO.getRowCount("USER1")%></p>
        </div>
        <div class="bg-green-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Total Products</h3>
            <p class="text-3xl mt-4"><%= AdminDAO.getRowCount("PRODUCT")%></p>
        </div>
        <div class="bg-yellow-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Active Rentals</h3>
            <p class="text-3xl mt-4">50</p>
        </div>
    </div>

    <div class="mt-16">
        <h2 class="text-2xl font-semibold mb-6">Database Overview</h2>
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
            <thead>
                <tr class="bg-gray-800 text-white">
                    <th class="py-2 px-4">Table Name</th>
                    <th class="py-2 px-4">Records</th>
                    <th class="py-2 px-4">Last Updated</th>
                    <th class="py-2 px-4">Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr class="border-t">
                    <td class="py-2 px-4 text-center">Users</td>
                    <td class="py-2 px-4 text-center"><%= AdminDAO.getRowCount("USER1")%></td>
                    <td class="py-2 px-4 text-center">25/09/2024</td>
                    <td class="py-2 px-4 text-center">
                        <a href="admin.jsp?page=user"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a> 
                    </td>
                </tr>
                <tr class="border-t">
                    <td class="py-2 px-4 text-center">Products</td>
                    <td class="py-2 px-4 text-center"><%= AdminDAO.getRowCount("PRODUCT")%></td>
                    <td class="py-2 px-4 text-center">24/09/2024</td>
                    <td class="py-2 px-4 text-center">
                        <a href="admin.jsp?page=products"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a> 
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</section>
