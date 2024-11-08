<%-- 
    Document   : allProducts.jsp
    Created on : 31 Oct, 2024, 5:24:05 PM
    Author     : HP
--%>

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

                <!-- Sample Row 1 -->
                <tr class="border-b border-gray-200">
                    <td class="py-3 px-6 text-left">#0001</td>
                    <td class="py-3 px-6 text-center">
                        <img src="https://via.placeholder.com/50" alt="Product Image" class="w-12 h-12 rounded">
                    </td>
                    <td class="py-3 px-6 text-left">Product Name 1</td>
                    <td class="py-3 px-6 text-left">1000/month</td>
                    <td class="py-3 px-6 text-left">Furniture</td>
                    <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center">Added</span></td>
                    <td class="py-3 px-6 text-right">
                        <button onclick="openModal()" class="primary-btn px-6 py-1">
                            <i class="fa-solid fa-eye"></i>
                        </button>
                        <a href="userDashboard.jsp?page=editProduct" class="primary-btn px-6 py-1.5">Edit</a>
                    </td>
                </tr>

                <!-- Sample Row 2 -->
                <tr class="border-b border-gray-200">
                    <td class="py-3 px-6 text-left">#0001</td>
                    <td class="py-3 px-6 text-center">
                        <img src="https://via.placeholder.com/50" alt="Product Image" class="w-12 h-12 rounded">
                    </td>
                    <td class="py-3 px-6 text-left">Product Name 1</td>
                    <td class="py-3 px-6 text-left">1000/month</td>
                    <td class="py-3 px-6 text-left">Furniture</td>
                    <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center">Added</span></td>
                    <td class="py-3 px-6 text-right">
                        <button onclick="openModal()" class="primary-btn px-6 py-1">
                            <i class="fa-solid fa-eye"></i>
                        </button>
                        <a href="userDashboard.jsp?page=editProduct" class="primary-btn px-6 py-1.5">Edit</a>
                    </td>
                </tr>

                <!-- Sample Row 3 -->
                <tr class="border-b border-gray-200">
                    <td class="py-3 px-6 text-left">#0001</td>
                    <td class="py-3 px-6 text-center">
                        <img src="https://via.placeholder.com/50" alt="Product Image" class="w-12 h-12 rounded">
                    </td>
                    <td class="py-3 px-6 text-left">Product Name 1</td>
                    <td class="py-3 px-6 text-left">1000/month</td>
                    <td class="py-3 px-6 text-left">Furniture</td>
                    <td class="py-3 px-6 text-left"><span class="text-yellow-700 bg-yellow-200 px-1.5 py-1 text-center">Drafted</span></td>
                    <td class="py-3 px-6 text-right">
                        <button onclick="openModal()" class="primary-btn px-6 py-1">
                            <i class="fa-solid fa-eye"></i>
                        </button>
                        <a href="userDashboard.jsp?page=editProduct" class="primary-btn px-6 py-1.5">Edit</a>
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
</div>
