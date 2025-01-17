<%-- 
    Document   : lendProduct
    Created on : 26 Oct, 2024, 12:43:50 PM
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String pageId = request.getParameter("page");
    
    CategoryDAO categoryDAO = new CategoryDAO();
    ResponseHandler categoryRes;
    List<Category> categoryList;

    categoryRes = categoryDAO.getCategory();

    if (categoryRes.isSuccess()) {
        categoryList = (List<Category>) categoryRes.getData();
    } else {
        categoryList = new ArrayList<Category>();
    }

%>

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
<form class="container mx-auto font-lato" name="AddProductServlet" action="/AddProductServlet" method="POST" enctype="multipart/form-data">
    <div class="flex justify-between items-center mb-4">
        <h1 class="text-2xl font-bold">Add Product</h1>
        <% if (request.getAttribute("lendErrorMessage") != null) {%>
        <div class="my-2 font-medium text-red-500">
            <%= request.getAttribute("lendErrorMessage")%>
        </div>
        <% }%>
        <div class="">   
            <button class="secondary-btn mr-5 relative" onclick="launch()"><i class="fa-solid fa-floppy-disk mr-2 text-primary"></i>Save as draft <span class="absolute text-xs font-bold bg-green-100 -top-2 text-green-500">BETA</span></button>
            <button type="submit" class="primary-btn"><i class="fa-solid fa-check mr-2 text-white"></i>
                Add Product
            </button>
        </div>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

        <!-- General Information -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">General Information</h2>
            <label class="block mb-2 text-sm font-medium text-gray-600">Product Name</label>
            <input type="text" id="productName" name="name" class="w-full p-2 mb-4 border rounded" placeholder="Enter product name" required>
            <label class="block mb-2 text-sm font-medium text-gray-600">Description</label>
            <textarea id="productDescription" name="description" class="w-full p-2 border rounded" rows="3" placeholder="Enter product description" required></textarea>
        </div>

        <!-- Upload Images -->
        <div class="p-4 border rounded-lg">
            <label class="block mb-2 text-sm font-medium text-gray-600">Product specification</label>
            <input type="text" id="productSpec" name="spec" class="w-full p-2 mb-4 border rounded" placeholder="Enter product specification" required>
            <div id="tags">
                <label class="block mb-2 text-sm font-medium text-gray-600">Tags</label>
                <div class="flex gap-2">
                    <input type="text" id="tagInput" class="w-full p-2 mb-2 border rounded" name="tag" placeholder="tag" required>
                    <button type="button" onclick="addTag()" class="primary-btn mb-2">Add</button>
                </div>
            </div>
            <h2 class="text-lg font-semibold mb-4">Upload Images</h2>
            <input type="file" id="imageUpload" name="imageUrl" multiple class="w-full p-2 mb-4 border rounded" onchange="previewImages()" required>
            <div id="imagePreview" class="flex flex-wrap gap-2"></div>
        </div>

        <!-- More Details -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">Details</h2>
            <div id="moreDetailsContainer">
                <div class="detail-item mb-4">
                    <label class="block mb-2 text-sm font-medium text-gray-600">Title</label>
                    <input type="text" class="w-full p-2 mb-2 border rounded" name="title" placeholder="Detail title" required>
                    <label class="block mb-2 text-sm font-medium text-gray-600">Description</label>
                    <textarea class="w-full p-2 border rounded" name="details" rows="2" placeholder="Detail description" required></textarea>
                </div>
            </div>
            <button type="button" onclick="addDetail()" class="primary-btn">Add more details</button>
        </div>

        <!-- Category and Price -->
        <div class="p-4 border rounded-lg">
            <h2 class="text-lg font-semibold mb-4">Category and Price</h2>
            <label class="block mb-2 text-sm font-medium text-gray-600">Category</label>
            <select type="text" id="category" name="category" class="w-full p-2 mb-4 border rounded" placeholder="Enter category" required>
                <%
                    for (Category category : categoryList) {
                %>
                <option value="<%=category.getId()%>"><%=category.getName()%></option>
                <%
                    }
                %>
            </select>
            <label class="block mb-2 text-sm font-medium text-gray-600">Price</label>
            <div id="nextTenureContainer">
                <div class="flex gap-2 mb-4">
                    <input type="number" id="price" class="w-full p-2 border rounded" name="price" placeholder="Enter price" required>
                    <select id="tenure" name="tenure" class="p-2 border rounded" required>
                        <option value="3">3 months</option>
                        <option value="6">6 months</option>
                        <option value="12">12 Months</option>
                        <option value="18">18 Months</option>
                    </select>
                </div>
            </div>
            <button type="button" onclick="addTenure()" class="primary-btn">Add more tenure</button>
        </div>
    </div>
</form>
            <!-- Include SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function launch() {
        event.preventDefault();
        Swal.fire({
            title: "Coming Soon!",
            text: "This feature will be launched soon. Stay tuned!",
            icon: "info",
            confirmButtonText: "OK",
            confirmButtonColor: "#C80036",
            background: "#f9f9f9",
            backdrop: `rgba(0, 0, 0, 0.4)`,
            showClass: {
                popup: "animate__animated animate__fadeInDown"
            },
            hideClass: {
                popup: "animate__animated animate__fadeOutUp"
            }
        });
    }
</script>

<script src="../../scripts/lend.js"></script>
