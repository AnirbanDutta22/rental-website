<%-- 
    Document   : lendProduct
    Created on : 26 Oct, 2024, 12:43:50 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String pageId = request.getParameter("page");%>
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
        <%
            if ("editProduct".equals(pageId)) {
        %>
        <h1 class="text-2xl font-bold">Edit Product</h1>
        <%
        } else {
        %>
        <h1 class="text-2xl font-bold">Add Product</h1>
        <%
                    }%>
        <div class="">   
            <button class="secondary-btn mr-5"><i class="fa-solid fa-floppy-disk mr-2 text-primary"></i>Save as draft</button>
            <button class="primary-btn"><i class="fa-solid fa-check mr-2 text-white"></i><%
                if ("editProduct".equals(pageId)) {
                %>
                Update
                <%
                } else {
                %>
                Add Product
                <%
                    }%>
            </button>
        </div>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

        <!-- General Information -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">General Information</h2>
            <label class="block mb-2 text-sm font-medium text-gray-600">Product Name</label>
            <input type="text" id="productName" class="w-full p-2 mb-4 border rounded" placeholder="Enter product name">
            <label class="block mb-2 text-sm font-medium text-gray-600">Description</label>
            <textarea id="productDescription" class="w-full p-2 border rounded" rows="3" placeholder="Enter product description"></textarea>
        </div>

        <!-- Upload Images -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">Upload Images</h2>
            <input type="file" id="imageUpload" multiple class="w-full p-2 mb-4 border rounded" onchange="previewImages()">
            <div id="imagePreview" class="flex flex-wrap gap-2"></div>
        </div>

        <!-- More Details -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">More Details</h2>
            <div id="moreDetailsContainer">
                <div class="detail-item mb-4">
                    <label class="block mb-2 text-sm font-medium text-gray-600">Title</label>
                    <input type="text" class="w-full p-2 mb-2 border rounded" placeholder="Detail title">
                    <label class="block mb-2 text-sm font-medium text-gray-600">Description</label>
                    <textarea class="w-full p-2 border rounded" rows="2" placeholder="Detail description"></textarea>
                </div>
            </div>
            <button onclick="addDetail()" class="primary-btn">Add</button>
        </div>

        <!-- Category and Price -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">Category and Price</h2>
            <label class="block mb-2 text-sm font-medium text-gray-600">Category</label>
            <input type="text" id="category" class="w-full p-2 mb-4 border rounded" placeholder="Enter category">
            <label class="block mb-2 text-sm font-medium text-gray-600">Price</label>
            <div class="flex gap-2">
                <input type="number" id="price" class="w-full p-2 border rounded" placeholder="Enter price">
                <select id="tenure" class="p-2 border rounded">
                    <option value="hour">Per Hour</option>
                    <option value="day">Per Day</option>
                    <option value="month">Per Month</option>
                </select>
            </div>
        </div>
    </div>
</div>

<script>
            window.addEventListener("load", function(){
            document.body.classList.add('loaded');
            });
            // Function to preview uploaded images
                    function previewImages() {
                    const imageUpload = document.getElementById('imageUpload');
                            const imagePreview = document.getElementById('imagePreview');
                            imagePreview.innerHTML = ''; // Clear previous images

                            for (const file of imageUpload.files) {
                    const reader = new FileReader();
                            reader.onload = function(e) {
                            const img = document.createElement('img');
                                    img.src = e.target.result;
                                    img.classList.add('w-20', 'h-20', 'object-cover', 'rounded');
                                    imagePreview.appendChild(img);
                            };
                            reader.readAsDataURL(file);
                    }
                    }

            // Function to add more detail fields
            function addDetail() {
            const moreDetailsContainer = document.getElementById('moreDetailsContainer');
                    const detailItem = document.createElement('div');
                    detailItem.classList.add('detail-item', 'mb-4');
                    detailItem.innerHTML = `
                    < label class = "block mb-2 text-sm font-medium text-gray-600" > Title < /label>
                    < input type = "text" class = "w-full p-2 mb-2 border rounded" placeholder = "Detail title" >
                    < label class = "block mb-2 text-sm font-medium text-gray-600" > Description < /label>
                    < textarea class = "w-full p-2 border rounded" rows = "2" placeholder = "Detail description" > < /textarea>
                    `;
                    moreDetailsContainer.appendChild(detailItem);
            }
</script>

