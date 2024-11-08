<%-- 
    Document   : category
    Created on : 7 Nov, 2024, 12:38:24 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category</title>
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
                    @apply text-white bg-primary hover:bg-primary-100 transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
                }
            }
        </style>
        <style>
            body.loaded #loader {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Loader -->
        <div id="loader" class="fixed inset-0 flex items-center justify-center bg-white z-50">
            <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-primary"></div>
        </div>
        <section class="font-lato">
            <!--header-->
            <jsp:include page="../components/header.jsp" />
            <!--hero section-->
            <div class="pt-40 max-w-screen-xl mx-auto min-h-screen">
                <h2 class="text-3xl font-semibold mb-4"><%= request.getParameter("category")%></h2>
                <jsp:include page="../components/productList.jsp" />
            </div>
            <!--footer-->
            <jsp:include page="../components/footer.jsp"/>
        </section>
        <script>
            window.addEventListener("load", function () {
                document.body.classList.add('loaded');
            });
        </script>
    </body>
</html>
