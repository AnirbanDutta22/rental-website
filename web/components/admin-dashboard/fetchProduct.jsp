<%-- 
    Document   : fetchProduct
    Created on : 24 Nov, 2024, 11:52:04 AM
    Author     : Srikanta
--%>

<%@page import="dao.AdminDAO"%>
<%@page import="models.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="responses.ResponseHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%
    AdminDAO adminDAO = new AdminDAO();
    ResponseHandler productRes;
    List<Product> productList;

    productRes = adminDAO.getAllProducts();

    if (productRes.isSuccess()) {
        productList = (List<Product>) productRes.getData();
        session.setAttribute("productlist", productList);
    } else {
        productList = new ArrayList<Product>();
    }
%>
<section id="manage-products">
    <h2 class="text-2xl font-semibold mb-6">Manage Products</h2>
    <div id="listed-products">
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
            <thead>           
                <tr class="bg-gray-800 text-white">
                    <th class="py-2 px-4">SL_NO</th>
                    <th class="py-2 px-4">PRODUCT_ID</th>
                    <th class="py-2 px-4">NAME</th>
                    <th class="py-2 px-4">CATEGORY_ID</th>
                    <th class="py-2 px-4">LENDER_ID</th>
                    <th class="py-2 px-4">STATUS</th>

                    <th class="py-2 px-4">ACTION</th>
                </tr>
            </thead>
            <tbody>
                <%        int sl_no = 0;
                    for (Product product : productList) {
                        sl_no++;
                %>
                <tr class="border-t">
                    <td class="py-2 px-4 text-center"><%= sl_no%></td>
                    <td class="py-2 px-4 text-center"><%=product.getId()%></td>
                    <td class="py-2 px-4 text-center"><%=product.getName()%></td>
                    <td class="py-2 px-4 text-center"><%=product.getCategoryId()%></td>
                    <td class="py-2 px-4 text-center"><%=product.getLenderId()%></td>
                    <td class="py-2 px-4 text-center"><%=product.getStatus()%></td>
                    <td class="py-2 px-4 text-left w-44">
                        <%
                            if (product.getStatus().equals("PENDING")) {
                        %>
                        <div class="flex gap-2">
                            <form name="ApproveProduct" action="/ApproveProductServlet?productId=<%= product.getId()%>" method="POST">
                                <button class="px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600">Approve</button>
                            </form>
                            <form name="RejectProduct" action="/RejectProductServlet?productId=<%=product.getId()%>" method="POST">
                                <button class="px-3 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600">Reject</button>
                            </form>
                        </div>
                        <%
                        } else {
                        %>
                        <!--<form name="RemoveProduct" action="RemoveCategoryServlet?categoryId=<category.getId()%>" method="POST">-->
                        <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Delete product</button>
                        <!--</form>-->
                        <%
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</section>