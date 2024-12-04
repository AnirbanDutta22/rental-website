<%-- 
    Document   : fetchCategory
    Created on : 23 Nov, 2024, 11:53:20 PM
    Author     : Srikanta
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Category"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%

    CategoryDAO categoryDAO = new CategoryDAO();
    ResponseHandler categoryRes;
    List<Category> categoryList;

    categoryRes = categoryDAO.getCategory();

    if (categoryRes.isSuccess()) {
        categoryList = (List<Category>) categoryRes.getData();
        session.setAttribute("categorylist", categoryList);
    } else {
        categoryList = new ArrayList<Category>();
    }

%>
<section id="manage-category">
    <h2 class="text-2xl font-semibold mb-6">Manage Category</h2>
    <form action="/CategoryServlet?type=add" method="post" id="add-category" class="mb-4 flex " style="display: flex;">
<!--        <div>
            <label for="category_id" class="block text-sm font-medium text-gray-800 mb-2">Category ID</label>
            <input type="text" id="category_id" name="categoryId" class="w-48 px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Enter Category ID" required/>
        </div>-->
        <div class="ml-7">
            <label for="category_name" class="block text-sm font-medium text-gray-800 mb-2">Name</label>
            <input type="text" id="category_id" name="category_name" class="w-48 px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Enter Category Name" required/>
        </div>
        <button type="submit"  class="px-4 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 mt-8 mb-1 ml-7">Add</button>
    </form>

    <table class="w-2/3 bg-white shadow-lg rounded-lg overflow-hidden">
        <thead>           
            <tr class="bg-gray-800 text-white">
                <th class="py-2 px-4">SL_NO</th>
                <th class="py-2 px-4">CATEGORY_ID</th>
                <th class="py-2 px-4">NAME</th>
                <th class="py-2 px-4">ACTION</th>
            </tr>
        </thead>
        <tbody>
            <%  int sl_no = 0;
                for (Category category : categoryList) {
                    sl_no++;
            %>
            <tr class="border-t">
                <td class="py-2 px-4 text-center"><%= sl_no%></td>
                <td class="py-2 px-4 text-center"><%=category.getId()%></td>
                <td class="py-2 px-4 text-center"><%=category.getName()%></td>
                <td class="py-2 px-4 text-center">
                    <form name="RemoveProduct" action="/CategoryServlet?categoryId=<%=category.getId()%>&type=remove" method="POST">
                        <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</section>