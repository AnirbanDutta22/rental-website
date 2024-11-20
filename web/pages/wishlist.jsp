<%-- 
    Document   : wishlist
    Created on : 26 Oct, 2024, 12:32:43 AM
    Author     : HP
--%>

<%@page import="responses.ResponseHandler"%>
<%@page import="dao.ProductDAO"%>
<%@page import="models.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User) session.getAttribute("user");
    ProductDAO productDAO = new ProductDAO();
    ResponseHandler wishlistRes;
    List<Product> wishlist;

    if (user != null) {
        wishlistRes = productDAO.getWishlist(user.getId());

        if (wishlistRes.isSuccess()) {
            wishlist = (List<Product>) wishlistRes.getData();
            session.setAttribute("wishlist",wishlist);
        } else {
            wishlist = new ArrayList<Product>();
        }
    } else {
        wishlist = new ArrayList<Product>();
    }

%>
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
            <h1 class="font-semibold text-3xl text-center my-10">
                <i class="fa-solid fa-heart mr-2 text-primary"></i>My Wishlist (<%=wishlist.size()%>)
            </h1>

            <div class="flex flex-col gap-y-5 w-full my-10">
                <% if (user != null && wishlist.size() != 0) {
                        for (Product product : wishlist) {
                            List<Product.PriceTenure> priceTenures = product.getPriceTenures();
                            if (!priceTenures.isEmpty()) {
                                double firstPrice = priceTenures.get(0).getPrice();
                                int firstTenure = priceTenures.get(0).getTenure();
                %>     
                <div class="wishlist-item flex flex-wrap items-center bg-white rounded-lg gap-x-6 gap-y-3">

                    <!-- Image Section -->
                    <div class="image-container w-28 h-20 flex-shrink-0">
                        <img src="../<%= product.getImageUrl()[0]%>" alt="<%= product.getName()%>" class="w-full h-full object-cover rounded-md"/>
                    </div>

                    <!-- Product Details Section -->
                    <div class="flex-grow text-left">
                        <h2 class="text-lg font-semibold"><%= product.getName()%></h2>
                        <p class="text-sm text-gray-600"><%= product.getSpec()%></p>
                    </div>

                    <!-- Price Section -->
                    <div class="text-md">
                        <span class="font-semibold text-blue-500">Rs. <%= firstPrice%>/month</span> upto <%=firstTenure%> months
                    </div>

                    <!-- Action Buttons Section -->
                    <div class="flex gap-3">
                        <a href="/pages/product.jsp?productId=<%= product.getId()%>" class="primary-btn px-4 py-2 rounded-md">
                            Rent Now
                        </a>
                        <form name="RemoveProduct" action="/RemoveWishlistServlet?productId=<%=product.getId()%>" method="POST" class="remove-btn primary-btn px-4 py-2 rounded-md">
                            <button type="submit">Remove</button>
                        </form>
                    </div>
                </div>

                <%}
                    }
                } else { %>
                <p class="text-center">No items found. <a href="/pages/index.jsp" class="text-blue-700">Add from here</a></p>
                <% }%>
            </div>
        </div>

        <!--footer-->
        <jsp:include page="../components/footer.jsp"/>
        <script>
            window.addEventListener("load", function () {
                document.body.classList.add('loaded');
            });
        </script>
    </body>
</html>
