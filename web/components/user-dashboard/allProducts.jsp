<%-- 
    Document   : allProducts.jsp
    Created on : 31 Oct, 2024, 5:24:05 PM
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Product"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.ProductDAO"%>
<%@page import="models.User"%>
<%
    User user = (User) session.getAttribute("user");
    ProductDAO productDAO = new ProductDAO();
    ResponseHandler allProductsLentRes;
    List<Product> lentProducts;

    if (user != null) {
        allProductsLentRes = productDAO.getAllProductsLent(user.getId());

        if (allProductsLentRes.isSuccess()) {
            lentProducts = (List<Product>) allProductsLentRes.getData();
            session.setAttribute("allLentProducts", lentProducts);
        } else {
            lentProducts = new ArrayList<Product>();
        }
    } else {
        lentProducts = new ArrayList<Product>();
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://cdn.tailwindcss.com"></script>
<script src="../scripts/tailwind-config.js"></script>
<style type="text/tailwindcss">
    @layer components {
        .primary-btn {
            @apply text-white bg-primary font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
        }
        .secondary-btn {
            @apply text-black bg-white font-medium rounded-full text-base px-8 py-2 text-center border border-primary dark:bg-light dark:text-darkColor;
        }
    }
</style>
<div class="container mx-auto font-lato">
    <div class="flex justify-between items-center mb-4">
        <h1 class="text-2xl font-bold">All Products</h1>
        <div>  
            <button class="primary-btn"><i class="fa-solid fa-filter mr-2 text-white"></i>Filter</button>
        </div>
    </div>
    <!-- All Products Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white border rounded-lg">
            <thead>
                <tr class="w-full bg-light text-gray-600 uppercase text-sm leading-normal">
                    <th class="py-3 px-6 text-left">Product ID</th>
                    <th class="py-3 px-6 text-left">Product Image</th>
                    <th class="py-3 px-6 text-left">Name</th>
                    <th class="py-3 px-6 text-left">Price/tenure</th>
                    <th class="py-3 px-6 text-left">Category</th>
                    <th class="py-3 px-6 text-left">Status</th>
                    <th class="py-3 px-6 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="text-gray-600 text-sm font-light">
                <% if (user != null && lentProducts.size() != 0) {
                        for (Product product : lentProducts) {
                            List<Product.PriceTenure> priceTenures = product.getPriceTenures();
                            if (!priceTenures.isEmpty()) {
                                double firstPrice = priceTenures.get(0).getPrice();
                                int firstTenure = priceTenures.get(0).getTenure();
                %>     
                <tr class="border-b border-gray-200">
                    <td class="py-3 px-6 text-left"><%=product.getId()%></td>
                    <td class="py-3 px-6 text-center">
                        <img src="../<%=product.getImageUrl()[0]%>" alt="Product Image" class="w-12 h-12 rounded">
                    </td>
                    <td class="py-3 px-6 text-left"><%=product.getName()%> (<%=product.getSpec()%>)</td>
                    <td class="py-3 px-6 text-left"><%=firstPrice%>/month upto <%=firstTenure%> month</td>
                    <td class="py-3 px-6 text-left"><%=product.getCategory()%></td>
                    <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center">Added</span></td>
                    <td class="py-3 px-6 text-right flex text-base items-center">
                        <button class="primary-btn px-4 py-1"><a href="/pages/product.jsp?productId=<%=product.getId()%>">
                                <i class="fa-solid fa-eye"></i></a>
                        </button>
                        <button class="primary-btn px-4 py-1 ml-2"><a href="userDashboard.jsp?page=editProduct">Edit</a></button>
                        <form name="RemoveProductServlet" action="/RemoveProductServlet?product_id=<%=product.getId()%>&lender_id=<%=product.getLenderUsername()%>" method="POST"><button type="submit" class="primary-btn hover:bg-primary-100 transition-all ease-in-out duration-300 px-4 py-1 ml-2">Remove</button></form>
                    </td>
                </tr>
                <%
                            }
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
