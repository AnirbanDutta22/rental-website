<%@page import="java.util.ArrayList"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.ProductDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script src="../scripts/tailwind-config.js"></script>
<style type="text/tailwindcss">
    @layer components {
        .primary-btn {
            @apply text-white bg-primary hover:bg-primary-100 transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
        }
    }
</style>

<!-- Products -->
<div class="mt-8">
    <div class="h-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

        <%
            ProductDAO productDAO = new ProductDAO();
            ResponseHandler res;
            if (request.getParameter("category") != null) {
                res = productDAO.getAllProducts(request.getParameter("category"));
            } else {
                res = productDAO.getAllProducts();
            }

            List<Product> productList = new ArrayList<Product>();

            if (res.isSuccess()) {
                productList = (List<Product>) res.getData();
            } else {
                productList = null;
            }

            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
                    List<Product.PriceTenure> priceTenures = product.getPriceTenures();
                    if (!priceTenures.isEmpty()) {
                        Product.PriceTenure firstPriceTenure = priceTenures.get(0);
        %>

        <div class="bg-white p-4 relative h-84 rounded shadow-md hover:shadow-lg transition-shadow flex flex-col">

            <!-- Heart Icon at the Top Right -->
            <div class="absolute w-full top-2 left-[85%] z-20">
                <i class="fa-solid fa-heart text-primary text-2xl bg-white shadow border border-black rounded-full p-2 flex justify-end mr-10 cursor-pointer"></i>
            </div>

            <!-- Image Section -->
            <div class="h-56 overflow-hidden">
                <a href="/pages/product.jsp?productId=<%= product.getName()%>">
                    <img src="../<%= product.getImageUrl()[0]%>" alt="<%= product.getName()%>" class="w-full h-56 object-cover rounded-md hover:scale-110 transition-all ease-in-out duration-300"/>
                </a>
            </div>

            <!-- Main Content with Product Name, Description, and Price -->
            <div class="flex-grow mt-2">
                <h3 class="font-semibold text-2xl"><%= product.getName()%> <span class="text-base font-normal">(<%=product.getSpec()%>)</span></h3>
                <p class="text-gray-600 text-lg"><%= product.getDescription()%></p>
                <p class="text-blue-500 font-semibold text-md"><%= firstPriceTenure.getPrice()%>/<%= firstPriceTenure.getTenure()%></p>
            </div>

            <!-- Footer with Button and Date, Stays at the Bottom -->
            <div class="flex justify-between items-center mt-3">
                <a href="/pages/product.jsp?productId=<%= product.getId()%>">
                    <button class="primary-btn rounded-md">Rent Now</button>
                </a>
                <p class="text-sm">Date: 09/09/2024</p>
            </div>
        </div>


        <%}
            }
        }
        %><%else {%>

        <p>No products</p>
        <%}%>

    </div>
</div>
