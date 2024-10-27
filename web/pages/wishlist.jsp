<%-- 
    Document   : wishlist
    Created on : 26 Oct, 2024, 12:32:43 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <style type="text/tailwindcss">
            @layer components {
      .primary-btn {
        @apply text-white bg-primary font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
      }
}</style>
        <style>
        body.loaded #loader {
            display: none;
        }</style>
        <title>Wishlist</title>
    </head>
    <body class="font-lato">
        <!-- Loader -->
    <div id="loader" class="fixed inset-0 flex items-center justify-center bg-white z-50">
        <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-primary"></div>
    </div>
        <!--header-->
            <jsp:include page="../components/header.jsp" />
            <div class="pt-20 max-w-4xl mx-auto">
                <h1 class="font-semibold text-3xl text-center my-10"><i class="fa-solid fa-heart mr-2 text-primary"></i>My Wishlist (5)</h1>
                <div class="flex flex-col gap-y-5 w-full my-10">
                <div class="w-full flex flex-col gap-y-3">
                    <div class="flex w-full justify-between items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span>Fancy Sofa</span>
                    <span>Rs. 1000/month</span>
                    <a href="/pages/product.jsp">
                    <button class="primary-btn px-4">Rent Now</button>
                    </a>
                    <button class="primary-btn px-4">Remove</button>
                    </div>
                </div>
                    <div class="w-full flex flex-col gap-y-3">
                    <div class="flex w-full justify-between items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span>Fancy Sofa</span>
                    <span>Rs. 1000/month</span>
                    <a href="/pages/product.jsp">
                    <button class="primary-btn px-4">Rent Now</button>
                    </a>
                    <button class="primary-btn px-4">Remove</button>
                    </div>
                </div>
                    <div class="w-full flex flex-col gap-y-3">
                    <div class="flex w-full justify-between items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span>Fancy Sofa</span>
                    <span>Rs. 1000/month</span>
                    <a href="/pages/product.jsp">
                        <button class="primary-btn px-4">Rent Now</button>
                    </a>
                    <button class="primary-btn px-4">Remove</button>
                    </div>
                </div>
                    <div class="w-full flex flex-col gap-y-3">
                    <div class="flex w-full justify-between items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span>Fancy Sofa</span>
                    <span>Rs. 1000/month</span>
                    <a href="/pages/product.jsp">
                        <button class="primary-btn px-4">Rent Now</button>
                    </a>
                    <button class="primary-btn px-4">Remove</button>
                    </div>
                </div>
                    <div class="w-full flex flex-col gap-y-3">
                    <div class="flex w-full justify-between items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span>Fancy Sofa</span>
                    <span>Rs. 1000/month</span>
                    <a href="/pages/product.jsp">
                        <button class="primary-btn px-4">Rent Now</button>
                    </a>
                    <button class="primary-btn px-4">Remove</button>
                    </div>
                </div>
                </div>
            </div>
            <!--footer-->
        <jsp:include page="../components/footer.jsp"/>
        <script>
            window.addEventListener("load",function(){
                document.body.classList.add('loaded');
            });
        </script>
    </body>
</html>
