<%-- 
    Document   : feftchUser
    Created on : 27 Nov, 2024, 3:23:19 PM
    Author     : Srikanta
--%>


<%@page import="models.User"%>
<%@page import="dao.AdminDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="responses.ResponseHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%
    AdminDAO AdminDAO = new AdminDAO();
    ResponseHandler userRes;
    List<User> userList;

    userRes = AdminDAO.getAllUsers();

    if (userRes.isSuccess()) {
        userList = (List<User>) userRes.getData();
        session.setAttribute("useruist", userList);
    } else {
        userList = new ArrayList<User>();
    }

%>
<section id="manage-users">
    <h2 class="text-2xl font-semibold mb-6">Manage Users</h2>
    <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
        <thead>           
            <tr class="bg-gray-800 text-white">
                <th class="py-2 px-4">SL_NO</th>
                <th class="py-2 px-4">NAME</th>
                <th class="py-2 px-4">EMAIL</th>
                <th class="py-2 px-4">PHONE NO</th>
                <th class="py-2 px-4">ADDRESS</th>
                <th class="py-2 px-4">IS_VERIFIED</th>
                <th class="py-2 px-4">USERNAME</th>
                <th class="py-2 px-4">TOTAL_BORROW</th>
                <th class="py-2 px-4">TOTAL_LEND</th>
                <th class="py-2 px-4">ACTION</th>
            </tr>
        </thead>
        <tbody>
            <%        int sl_no = 0;
                for (User user : userList) {
                    sl_no++;
            %>
            <tr class="border-t">
                <td class="py-2 px-4 text-center"><%= sl_no%></td>
                <td class="py-2 px-4 text-center"><%=user.getName()%></td>
                <td class="py-2 px-4 text-center"><%=user.getEmail()%></td>
                <td class="py-2 px-4 text-center"><%=user.getPhno()%></td>
                <td class="py-2 px-4 text-center"><%=user.getAddress()%></td>
                <td class="py-2 px-4 text-center">null</td>
                <td class="py-2 px-4 text-center"><%=user.getUsername()%></td>
                <td class="py-2 px-4 text-center">00</td>
                <td class="py-2 px-4 text-center">00</td>
                <td class="py-2 px-4 text-center">
                <!--<form name="RemoveProduct" action="RemoveCategoryServlet?categoryId=<category.getId()%>" method="POST">-->
                    <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Delete User</button>
                    <a href="#"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a>
                    <!--</form>-->

                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</section>
