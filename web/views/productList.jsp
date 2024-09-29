<%-- 
    Document   : productList
    Created on : 29 Sep, 2024, 10:00:27 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdn.tailwindcss.com"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="h-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
    <c:forEach var="product" items="${products}">
    <div class="bg-white p-4 relative h-84 rounded shadow-md hover:shadow-lg transition-shadow">
        <div class="absolute w-full">
            <i class="fa-regular fa-heart text-2xl flex justify-end mr-10"></i>
        </div>
        <a href="/pages/product.jsp"><img src="${product.imageUrl}" alt="${product.name}" class="w-full h-56 object-cover rounded-md"/></a>
        <h3 class="font-semibold text-2xl mt-2">${product.name}</h3>
        <p class="text-gray-600 text-lg">Description of Item 1.</p>
        <p class="text-blue-500 font-semibold text-md">Rs. ${product.price}/day</p>
        <div class="flex justify-between items-center">
            <a href="/pages/product.jsp">
                <button class="primary-btn">Rent Now</button>
            </a>
            <p class="text-sm">Date: 09-09-2024</p>
        </div>
    </div>
    </c:forEach>
</div>

