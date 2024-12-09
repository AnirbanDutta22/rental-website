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
                    <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center"><%=product.getStatus()%></span></td>
                    <td class="py-3 px-6 text-right flex text-base items-center">
                        <button class="primary-btn px-4 py-1"><a href="/pages/product.jsp?productId=<%=product.getId()%>">
                                <i class="fa-solid fa-eye"></i></a>
                        </button>
                        <button class="primary-btn px-4 py-1 ml-2"><a href="userDashboard.jsp?page=editProduct">Edit</a></button>
                        <button class="primary-btn hover:bg-primary-100 transition-all ease-in-out duration-300 px-4 py-1 ml-2" onclick="openRemoveModal(<%=product.getId()%>,'<%=product.getLenderUsername()%>',this)">Remove</button>
                    </td>
                </tr>
                <%
                            }
                        }
                    }
                %>
            </tbody>
        </table>
            <!-- Modal for Confirmation -->
                        <div id="removeModal" class="fixed inset-0 bg-black/50 z-50 hidden flex justify-center items-center">
                            <div class="bg-white p-6 rounded-lg shadow-lg max-w-sm w-full">
                                <div class="text-lg text-center text-gray-800">Are you sure you want to remove this product?</div>
                                <div class="flex justify-between mt-4">
                                    <button onclick="closeRemoveModal()" class="bg-gray-300 text-gray-800 px-6 py-1.5 rounded-full hover:bg-gray-400">Cancel</button>
                                    <form id="removeForm" method="POST" action="" class="flex">
                                        <button type="submit" class="bg-red-500 text-white px-6 py-1.5 rounded-full hover:bg-red-600">Confirm</button>
                                        <input type="hidden" name="productId" id="productId">
                                        <input type="hidden" name="lenderUsername" id="lenderUsername">
                                    </form>
                                </div>
                            </div>
                        </div>
    </div>
</div>
            <script>
                // Open the CANCEL REQUEST MODAL and set form values
                    function openRemoveModal(productId, lenderUsername, button) {
                    // Show the modal
                    console.log("Opening modal for:", { productId, lenderUsername });
                    document.getElementById("removeModal").classList.remove("hidden");
                            // Set the action and form values dynamically
                            document.getElementById("removeForm").action = "/RemoveProductServlet?lenderUsername=" + lenderUsername + "&product_id=" + productId;
                            document.getElementById("productId").value = productId;
                            document.getElementById("lenderUsername").value = lenderUsername;
                    }

                    // Close the CANCEL REQUEST MODAL
                    function closeRemoveModal() {
                    document.getElementById("removeModal").classList.add("hidden");
                    }
            </script>
