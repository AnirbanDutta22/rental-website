<%-- 
    Document   : lenderDetails
    Created on : 3 Dec, 2024, 6:47:42 PM
    Author     : Neil
--%>

<%@page import="dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Product"%>
<%@page import="models.OtherProfile"%>
<%@page import="dao.ProductDAO"%>
<%@page import="responses.ResponseHandler"%>

<%
    // Initialize DAO and response handler
    UserDAO userDAO = new UserDAO();
    ResponseHandler res;
    OtherProfile productWithLendDtl;

    // Log controller call
    System.out.println("Controller called");

    // Fetch lenderId from the request parameter
    String lenderId = (String) request.getParameter("lenderId");
    System.out.println("Lender ID: " + lenderId);

    // Fetch lender details and products
    productWithLendDtl = userDAO.getLenderDetails(lenderId);
    System.out.println("Name : " + productWithLendDtl.getName());
    System.out.println("Name : " + productWithLendDtl.getUsername());
    System.out.println("Name : " + productWithLendDtl.getAddress());
    for (Product product : productWithLendDtl.getProductList()) {
        System.out.println("Product Name : " + product.getName());
    }


%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lender Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f5f5;
            }
            .profile-card, .product-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .product-card {
                transition: transform 0.3s ease;
            }
            .product-card:hover {
                transform: translateY(-5px);
            }
            .stat-card {
                transition: all 0.3s ease;
            }
            .stat-card:hover {
                transform: scale(1.05);
            }
            @media (max-width: 640px) {
                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen flex flex-col">
            <div class="flex-grow container mx-auto px-4 py-8">
                <!-- Profile Section -->
                <div class="profile-card p-6 mb-8">
                    <div class="flex flex-col md:flex-row items-start gap-6">
                        <div class="w-full md:w-1/4">
                            <div class="relative">
                                <img src="../assets/images/slide6.jpg" alt="#" class="h-40 w-40 rounded-full object-cover mx-auto shadow-lg ">
                                <!-- alt="Profile Picture" -->
                                <span class="w-40 h-40 rounded-full object-cover mx-auto shadow-lg">
                                    <span class="absolute bottom-2 right-1/3 bg-green-500 w-4 h-4 rounded-full border-2 border-white"></span>
                            </div>
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between items-start">
                                <div>
                                    <h1 class="text-3xl font-bold mb-2">
                                        <%=productWithLendDtl.getName()%>
                                    </h1>
                                    <p class="text-gray-600 mb-2">
                                        <%=productWithLendDtl.getAddress()%>
                                    </p>

                                </div>
                                <div class="flex gap-2">
                                    <button class="p-2 rounded-full hover:bg-gray-100">
                                        <i class="bi bi-bookmark text-xl"></i>
                                    </button>
                                    <button class="p-2 rounded-full hover:bg-gray-100">
                                        <i class="bi bi-three-dots-vertical text-xl"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="grid grid-cols-2 md:grid-cols-4 gap-4 stats-grid mb-4">
                                <div class="stat-card text-center p-3 bg-blue-50 rounded-lg">
                                    <i class="bi bi-box-seam text-blue-600 text-xl mb-1"></i>
                                    <p class="font-semibold text-xl"><%=productWithLendDtl.getProductList().size()%></p>
                                    <p class="text-sm text-gray-600">Items Listed</p>
                                </div>
                                <div class="stat-card text-center p-3 bg-green-50 rounded-lg">
                                    <i class="bi bi-graph-up text-green-600 text-xl mb-1"></i>
                                    <p class="font-semibold text-xl">98%</p>
                                    <p class="text-sm text-gray-600">Success Rate</p>
                                </div>
                                <div class="stat-card text-center p-3 bg-yellow-50 rounded-lg">
                                    <i class="bi bi-star-fill text-yellow-600 text-xl mb-1"></i>
                                    <p class="font-semibold text-xl">4.9</p>
                                    <p class="text-sm text-gray-600">Rating</p>
                                </div>
                                <div class="stat-card text-center p-3 bg-purple-50 rounded-lg">
                                    <i class="bi bi-chat-square-text text-purple-600 text-xl mb-1"></i>
                                    <p class="font-semibold text-xl">324</p>
                                    <p class="text-sm text-gray-600">Reviews</p>
                                </div>
                            </div>

                            <div class="flex gap-4">
                                <button class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition flex items-center">
                                    <i class="bi bi-chat-dots me-2"></i>Message
                                </button>
                                <button class="border border-gray-300 px-6 py-2 rounded-lg hover:bg-gray-50 transition flex items-center">
                                    <i class="bi bi-share me-2"></i>Share Profile
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Listed Items Section -->
                <div class="mb-8">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold">Listed Items</h2>
                        <select class="border rounded-lg px-4 py-2">
                            <option>Sort by: Latest</option>
                            <option>Price: Low to High</option>
                            <option>Price: High to Low</option>
                        </select>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <%
                            if (productWithLendDtl != null && productWithLendDtl.getProductList() != null
                                    && !productWithLendDtl.getProductList().isEmpty()) {
                                for (Product product : productWithLendDtl.getProductList()) {
                        %>
                        <div class="product-card">
                            <div class="relative">
                                <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "../assets/images/default.jpg"%>" 
                                     alt="<%= product.getName()%>" 
                                     class="w-full h-48 object-cover rounded-t-xl">
                                <!--                                <span class="absolute top-4 right-4 bg-white px-3 py-1 rounded-full text-sm font-semibold shadow-md">
                                                                    Rs <%--product.getPrice()--%>/day
                                                                </span>-->
                            </div>
                            <div class="p-4">
                                <h3 class="font-semibold text-lg mb-2"><%= product.getName()%></h3>
                                <p class="text-gray-600 text-sm mb-3"><%= product.getDescription()%></p>
                                <div class="flex justify-between items-center">
                                    <span class="text-green-600 flex items-center">
                                        <i class="bi bi-check-circle me-1"></i><%= product.getStatus()%>
                                    </span>
                                    <button class="text-blue-600 hover:underline">View Details</button>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <p class="text-gray-600 text-center col-span-full">No items listed by this lender.</p>
                        <% }%>
                    </div>

                </div>
            </div>

            <!-- Footer -->
            <footer class="bg-gray-900 text-white py-12">
                <div class="container mx-auto px-4">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                        <div>
                            <h3 class="text-xl font-bold mb-4">About Us</h3>
                            <p class="text-gray-400">Connecting people through reliable lending services since 2020.</p>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold mb-4">Quick Links</h3>
                            <ul class="space-y-2">
                                <li><a href="#" class="text-gray-400 hover:text-white transition">Home</a></li>
                                <li><a href="#" class="text-gray-400 hover:text-white transition">Browse Items</a></li>
                                <li><a href="#" class="text-gray-400 hover:text-white transition">How It Works</a></li>
                                <li><a href="#" class="text-gray-400 hover:text-white transition">Support</a></li>
                            </ul>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold mb-4">Contact</h3>
                            <ul class="space-y-2">
                                <!--<li class="text-gray-400"><i class="bi bi-envelope me-2"></i></li>-->
                                <!-- <li class="text-gray-400"><i class="bi bi-telephone me-2"></i></li> -->
                                <li class="text-gray-400"><i class="bi bi-geo-alt me-2"></i><%=productWithLendDtl.getAddress()%></li>
                            </ul>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold mb-4">Follow Us</h3>
                            <div class="flex space-x-4">
                                <a href="#" class="text-gray-400 hover:text-white transition"><i class="bi bi-facebook text-xl"></i></a>
                                <a href="#" class="text-gray-400 hover:text-white transition"><i class="bi bi-twitter text-xl"></i></a>
                                <a href="#" class="text-gray-400 hover:text-white transition"><i class="bi bi-instagram text-xl"></i></a>
                                <a href="#" class="text-gray-400 hover:text-white transition"><i class="bi bi-linkedin text-xl"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
                        <p>&copy; 2024 Rental Platform. All rights reserved.</p>
                    </div>
                </div>
            </footer>
        </div>
    </body>
</html>