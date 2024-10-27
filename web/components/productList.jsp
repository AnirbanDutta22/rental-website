<%-- 
    Document   : productList
    Created on : 29 Sep, 2024, 10:00:27 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdn.tailwindcss.com"></script>
<%@ page import="java.util.List" %>
<%@ page import="models.product.Product" %>

<!-- Products -->
                <div class="mt-8">
                    <h2 class="text-3xl font-semibold mb-4">Furniture</h2>
                    <div class="h-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <%List<Product> products = (List<Product>) request.getAttribute("products");
                           if (products != null && !products.isEmpty()) {
                            for (Product product : products) {%>
                                <div class="bg-white p-4 relative h-84 rounded shadow-md hover:shadow-lg transition-shadow">
                                    <div class="absolute w-full top-2 left-[85%] z-20">
                                        <i class="fa-solid fa-heart text-primary text-2xl bg-white shadow border border-black rounded-full p-2 flex justify-end mr-10 cursor-pointer"></i>
                                    </div>
                                    <div class="h-56 overflow-hidden">
                                    <a href="/pages/product.jsp"><img src="<%=product.getImageUrl()%>" alt="" class="w-full h-56 object-cover rounded-md hover:scale-110 transition-all ease-in-out duration-300"/></a>
                                    </div>
                                    <h3 class="font-semibold text-2xl mt-2"><%= product.getName() %></h3>
                                    <p class="text-gray-600 text-lg">Description of Item 1.</p>
                                    <p class="text-blue-500 font-semibold text-md">Rs. <%= product.getPrice() %>/day</p>
                                    <div class="flex justify-between items-center mt-3">
                                        <a href="/pages/product.jsp">
                                            <button class="primary-btn rounded-md">Rent Now</button>
                                        </a>
                                        <p class="text-sm">Date: 09-09-2024</p>
                                    </div>
                                </div>
                    <%}
                    } else {%>
                        <p>No products available.</p>
                    <%}%>
                    </div>
                </div>

