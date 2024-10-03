<%-- 
    Document   : index
    Created on : 28 Sep, 2024, 10:14:17 PM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.product.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
}
        </style>
    </head>
    <body>
        <section class="font-lato">
            <jsp:include page="../components/header.jsp" />
            <div class="pt-40 max-w-screen mx-auto">
                <!--Sliders-->
                <div class="w-full">
                    <div class="swiper mySwiper max-w-screen-2xl relative h-[40rem]">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <img src="../assets/images/slide1.jpg" alt="#" class="h-full w-full object-cover rounded-2xl">
              </div>
              <div class="swiper-slide">
                <img src="../assets/images/slide2.jpg" alt="#" class="h-full w-full object-cover rounded-2xl">
              </div>
              <div class="swiper-slide">
                <img src="../assets/images/slide3.jpg" alt="#" class="h-full w-full object-cover rounded-2xl">
              </div>
              
            </div>
            
            <div class="swiper-pagination"></div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        </div>
                </div>
            </div>
            <main class="pt-8 max-w-screen-xl mx-auto min-h-screen">
                <!-- Categories -->
                <jsp:include page="../components/categories.jsp" />
                <!-- Items -->
                <div class="mt-8">
                    <h2 class="text-3xl font-semibold mb-4">Fresh Recommendations</h2>
                    <div class="h-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <%List<Product> products = (List<Product>) request.getAttribute("products");
                           if (products != null && !products.isEmpty()) {
                            for (Product product : products) {%>
                                <div class="bg-white p-4 relative h-84 rounded shadow-md hover:shadow-lg transition-shadow">
                                    <div class="absolute w-full top-2 left-[85%] z-30">
                                        <i class="fa-solid fa-heart text-primary text-2xl bg-white shadow border border-black rounded-full p-2 flex justify-end mr-10 cursor-pointer"></i>
                                    </div>
                                    <div class="w-full h-56 overflow-hidden">
                                        <a href="/pages/product.jsp">
                                        <img src="<%=product.getImageUrl()%>" alt="" class="w-full h-56 object-cover rounded-md hover:scale-110 transition-all ease-in-out duration-300"/>
                                    </a>
                                    </div>
                                    <h3 class="font-semibold text-2xl mt-2"><%= product.getName() %></h3>
                                    <p class="text-gray-600 text-lg">Description of Item 1.</p>
                                    <p class="text-blue-500 font-semibold text-md">Rs. <%= product.getPrice() %>/day</p>
                                    <div class="flex justify-between items-center">
                                        <a href="/pages/product.jsp">
                                            <button class="primary-btn mt-3 rounded-md">Rent Now</button>
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
                <div class="w-full text-center">
        <p class="text-3xl">...</p>
        <button class="bg-primary w-36 h-12 text-xl rounded-full m-4 text-white">Load more</button>
        
    </div>
            </main>
                    <jsp:include page="../components/footer.jsp"/>
        </section>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="../scripts/swiper-script.js"></script>
    </body>
</html>

