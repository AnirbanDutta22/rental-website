<%-- 
    Document   : product
    Created on : 29 Sep, 2024, 12:32:01 PM
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Product"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.ProductDAO"%>
<%
    ProductDAO productDAO = new ProductDAO();
    ResponseHandler res;
    Product product = new Product();

    res = productDAO.getProduct(request.getParameter("productId"));

    if (res.isSuccess()) {
        product = (Product) res.getData();
        request.getSession().setAttribute("selectedProduct", product);
    } else {
        product = null;
    }

    List<Product.PriceTenure> priceTenures = new ArrayList<Product.PriceTenure>();
    priceTenures = product.getPriceTenures();

    List<Product.Details> detailsList = new ArrayList<Product.Details>();
    detailsList = product.getDetails();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Product Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">     
        <script src="../scripts/tailwind-config.js"></script>
        <link rel="stylesheet" href="../styles/utils.css">
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
            <jsp:include page="../components/header.jsp" />
            <div class="pt-44 max-w-[1480px] mx-auto flex mb-6 text-xl gap-x-2"><span class="font-semibold">Products > </span><span class="font-semibold"> <%= product.getCategory()%>  > </span><span><%= product.getName()%> </span></div>
            <main class="pb-12 max-w-[1480px] mx-auto h-[100vh] flex justify-center gap-x-6">
                <div class="relative flex flex-col basis-3/5 h-full justify-between">
                    <div class="absolute w-full top-2 left-[93%]">
                        <i class="fa-solid fa-heart text-gray-500 text-2xl bg-white shadow border border-black rounded-full p-2 flex justify-end mr-10 cursor-pointer"></i>
                    </div>
                    <div class="grid grid-cols-3 grid-rows-3 gap-5">
                        <div class="col-span-3 row-span-2"><img src="../<%= product.getImageUrl()[0]%>" alt="table1" class="w-full h-[34rem]"/></div>
                            <%
                                for (int img = 1; img < product.getImageUrl().length; img++) {
                            %>
                        <div class="col-span-1"><img src="../<%= product.getImageUrl()[img]%>" alt="table1" class="w-full h-[16rem]"/></div>
                            <%}%>
                    </div>
                    <div class="flex gap-5 items-center text-xl">
                        <span><span class="font-semibold">Owner :</span> <%= product.getLenderName()%></span>
                        <span><span class="font-semibold">Address :</span> <%=product.getLenderAddress()%></span>
                        <span><span class="font-semibold">Posting Date :</span> September 20, 2024</span>
                    </div>
                </div>
                <div class="basis-2/5 h-full flex flex-col gap-y-16 px-6">
                    <div class="h-[10rem] flex flex-col gap-y-5 items-start">
                        <h1 class="text-3xl"><%= product.getName()%> <span class="text-lg">(<%=product.getSpec()%>)</span></h1>
                        <span class="font-semibold text-primary -mt-3">
                            <%
                                for (int tag = 0; tag < product.getTags().length; tag++) {
                            %>
                            <%=product.getTags()[tag]%> |
                            <%}%>
                        </span>
                        <form action="/ProcessBorrowServlet?productId=<%=product.getId() %>" method="POST" class="flex flex-wrap gap-x-4 items-center">
                            <span id="priceDisplay" class="text-xl">
                                Rs. <%= priceTenures.isEmpty() ? "Unavailable" : priceTenures.get(priceTenures.size() - 1).getPrice()%>/month
                            </span>

                            <select id="tenureSelect" name="tenure" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="updatePrice()">
                                <% for (Product.PriceTenure pt : priceTenures) {%>
                                <option value="<%= pt.getTenure()%>" data-price="<%= pt.getPrice()%>" selected class="bg-white text-primary active:bg-primary active:text-white">upto <%= pt.getTenure()%> months</option>
                                <% }%>
                            </select>

                            <!-- Hidden fields to store selected tenure and price -->
                            <input type="hidden" id="selectedPrice" name="price" value="<%= priceTenures.isEmpty() ? "" : priceTenures.get(priceTenures.size() - 1).getPrice()%>">
                            <input type="hidden" id="selectedTenure" name="tenure" value="<%= priceTenures.isEmpty() ? "" : priceTenures.get(priceTenures.size() - 1).getTenure()%>">
                            <input type="hidden" id="prevTenure" name="prevTenure" value="<%= priceTenures.isEmpty() ? "" : priceTenures.get(priceTenures.size() - 1).getTenure()%>">

                            <div class="w-full mt-4">
                                <button type="submit" class="primary-btn">Borrow</button>
                            </div>
                        </form>
                    </div>
                    <div>
                        <span class="text-2xl mb-3">Description</span>
                        <p>
                            <%= product.getDescription()%> 
                        </p>
                    </div>
                    <div class="bg-darkColor/90 text-white flex-grow p-3">
                        <span class="relative text-3xl mb-3 before:content-[''] before:absolute before:w-full before:h-[3px] before:bg-light before:-bottom-1 before:left-0">Details</span>
                        <div class="grid grid-cols-2 grid-rows-3 gap-6 py-2">
                            <%
                                for (Product.Details details : detailsList) {%>
                            <div>
                                <span class="text-light text-lg"><%= details.getTitle()%> : </span>
                                <p class='font-light'><%= details.getDetails()%></p>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../components/footer.jsp"/>
        </section>
        <script>
                    window.addEventListener("load", function () {
                    document.body.classList.add('loaded');
                    });
                    function updatePrice() {
                    const tenureSelect = document.getElementById("tenureSelect");
                            const selectedOption = tenureSelect.options[tenureSelect.selectedIndex];
                            const previousOption = tenureSelect.options[tenureSelect.selectedIndex - 1];
                            // Retrieve price and tenure from the selected option
                            const selectedPrice = selectedOption.getAttribute("data-price");
                            const selectedTenure = selectedOption.value;
                            // Update the display and hidden fields if values are found
                            if (selectedPrice) {
                    document.getElementById("priceDisplay").innerText = "Rs. " + selectedPrice + "/month";
                            document.getElementById("selectedPrice").value = selectedPrice;
                            document.getElementById("selectedTenure").value = selectedTenure;
                            document.getElementById("prevTenure").value = previousOption.value;
                    }
                    }
        </script>
    </body>
</html>
