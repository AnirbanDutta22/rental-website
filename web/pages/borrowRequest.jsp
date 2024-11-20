<%-- 
    Document   : borrowRequest
    Created on : 29 Sep, 2024, 8:25:48 PM
    Author     : HP
--%>
<%@page import="models.Product"%>
<%@page import="models.SelectedProduct"%>
<%@page import="dao.ProductDAO"%>
<%
    SelectedProduct selectedProduct = (SelectedProduct) session.getAttribute("selectedProduct");
    Product product = selectedProduct.getProduct();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Borrow Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">     
        <script src="../scripts/tailwind-config.js"></script>
        <link rel="stylesheet" href="../styles/utils.css">
    </head>
    <body>
        <section class="font-lato">
            <jsp:include page="../components/header.jsp" />
            <div class="pt-44 max-w-screen-lg mx-auto flex mb-6 text-2xl px-5"><span class="font-semibold">Borrow Request</span></div>
            <main class="pt-2 pb-12 max-w-screen-lg mx-auto flex justify-center gap-x-6">
                <form name="" method="POST" action="/SendBorrowRequestServlet" class="h-full w-full">
                    <div class="grid grid-cols-4 grid-rows-6 h-fit p-5 gap-5">
                        <div class="col-span-1 row-span-4">
                            <img src="../<%=product.getImageUrl()[0]%>" alt="table1" class="w-full h-[12rem]"/>
                        </div>
                        <h1 class="col-span-3 text-2xl"><%=product.getName()%> (<%=product.getSpec()%>)</h1>
                        <h1 class="col-span-3 text-xl">Ownner : <%=product.getLenderName()%>, Address : <%=product.getLenderAddress()%></h1>
                        <h1 class="col-span-3 text-xl">Rs. <%=selectedProduct.getSelectedPrice()%>/month</h1>
                        <div class="col-span-3 text-base flex justify-between items-center gap-x-5">

                            <label for="tenure">Preffered Tenure : </label>
                            <input id="tenure" name="tenure" type="number" min="<%=(selectedProduct.getPrevTenure() >= selectedProduct.getSelectedTenure() ? 1 : selectedProduct.getPrevTenure() + 1 )%>" max="<%=selectedProduct.getSelectedTenure()%>" class="block w-1/4 p-1.5 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 text-base focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"/>

                            <label for="offeredPrice">Offer your Price : </label>
                            <input id="offeredPrice" name="offeredPrice" type="text" class="block w-1/4 p-1.5 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 text-base focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"/>

                        </div>
                        <div class="flex flex-col col-span-4 row-span-2 h-full gap-y-2">
                            <label for="msg">Send a Message : </label>
                            <textarea id="msg" name="msg" type="textarea" class="block w-full h-[6rem] p-1.5 text-gray-900 border border-gray-300 rounded-lg bg-gray-50 text-base focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"></textarea>
                        </div>
                    </div>
                            <button type="submit" class="primary-btn ml-5">Send Borrow Request</button>
                </form>
            </main>
            <jsp:include page="../components/footer.jsp"/>
        </section>
    </body>
</html>

