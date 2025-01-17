<%@page import="models.Transaction"%>
<%@page import="dao.TransactionDAO"%>
<%@page import="models.User"%>
<%@page import="dao.RentalDAO"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="java.util.List"%>
<%@page import="models.Rental"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@100;300;400;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://cdn.tailwindcss.com"></script>
<script src="../scripts/tailwind-config.js"></script>

<style type="text/tailwindcss">
    @layer components {
        .primary-btn {
            @apply text-white bg-primary font-medium rounded-full text-base px-6 py-1.5 text-center dark:bg-light dark:text-darkColor;
        }
    }
</style>
<%
    User user = (User) session.getAttribute("user");
    Integer userId = user.getId();
    
    // Fetch rental details using DAO
    int requestId = Integer.parseInt(request.getParameter("requestId"));
    
    RentalDAO rentalDAO = new RentalDAO();
    Rental rentalProduct;

    rentalProduct = rentalDAO.getRentalProduct(requestId);

    TransactionDAO transactionDAO = new TransactionDAO();
    ResponseHandler transactionRes;
    List<Transaction> transactionList;

    transactionRes = transactionDAO.getTransactions(rentalProduct.getId());

    if (transactionRes.isSuccess()) {
        transactionList = (List<Transaction>) transactionRes.getData();
        session.setAttribute("transactionList", transactionList);
    } else {
        transactionList = new ArrayList<Transaction>();
        
    }
%>

<div class="container mx-auto font-lato">
    <!-- Transaction Details Header -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold">Rental Details</h1>
    </div>

    <!-- Transaction Details Content -->
    <div class="flex flex-col md:flex-row gap-6 bg-white p-6 rounded-lg shadow-lg">

        <!-- Product Image Section -->
        <div class="md:w-1/3">
            <img src="../uploads/bijunovel1.jpg" alt="Product Image" class="w-full h-80 object-contain bg-gray-300 backdrop-blur-2xl rounded-lg shadow-md">
        </div>

        <!-- Product and Borrower Details Section -->
        <div class="md:w-2/3 space-y-4">
            <h2 class="text-xl font-semibold"><%=rentalProduct.getProductName() %></h2>
            <p class="text-lg">Price: <%=rentalProduct.getOfferedPrice()%> / month</p>
            <p class="text-sm text-gray-500">Tenure: <%=rentalProduct.getTenure()%> months</p>
            <%
                if (rentalProduct.getLenderId() == userId) {
            %>
            <div class="border-t border-gray-300 pt-4 space-y-1">
                <h3 class="font-semibold">Borrower Details:</h3>
                <p>Name: <%=rentalProduct.getBorrowerName()%></p>
                <p>Address: <%=rentalProduct.getBorrowerAddress()%>, <%=rentalProduct.getBorrowerDist()%>, <%=rentalProduct.getBorrowerState()%>, <%=rentalProduct.getBorrowerPin()%></p>
                <p>Contact: <%=rentalProduct.getBorrowerPhone()%></p>
            </div>
            <%
            } else {
            %>
            <div class="border-t border-gray-300 pt-4 space-y-1">
                <h3 class="font-semibold">Lender Details:</h3>
                <p>Name: <%=rentalProduct.getLenderName()%></p>
                <p>Address: <%=rentalProduct.getLenderAddress()%>, <%=rentalProduct.getLenderDist()%>, <%=rentalProduct.getLenderState()%>, <%=rentalProduct.getLenderPin()%></p>
                <p>Contact: <%=rentalProduct.getLenderPhone()%></p>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Progress Tracking Section -->
    <div class="mt-6 bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-lg font-semibold">Progress Tracking</h3>
        <div class="flex items-center justify-between mt-3">
            <div class="flex items-center w-full space-x-4">
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-medium text-white rounded-full flex items-center justify-center font-semibold">1</div>
                    <p class="text-xs text-center mt-1">Lending</p>
                </div>
                <div class="flex-1 h-1 bg-medium"></div>
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-medium text-white rounded-full flex items-center justify-center font-semibold">2</div>
                    <p class="text-xs text-center mt-1">In Transit</p>
                </div>
                <div class="flex-1 h-1 bg-gray-300"></div>
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-gray-300 text-gray-500 rounded-full flex items-center justify-center font-semibold">3</div>
                    <p class="text-xs text-center mt-1">Delivered</p>
                </div>
                <div class="flex-1 h-1 bg-gray-300"></div>
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-gray-300 text-gray-500 rounded-full flex items-center justify-center font-semibold">4</div>
                    <p class="text-xs text-center mt-1">Returned</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Payment Transaction History Section -->
    <div class="mt-6 min-w-full bg-white border rounded-lg p-6">
        <h3 class="text-lg font-semibold">Rent Payment History</h3>
        <div class="overflow-x-auto mt-3">
            <table class="min-w-full">
                <thead>
                    <tr class="w-full bg-light text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">Date</th>
                        <th class="py-3 px-6 text-left">Amount</th>
                        <th class="py-3 px-6 text-left">Status</th>
                        <th class="py-3 px-6 text-left">Action</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <%
                        for (Transaction transaction : transactionList) {
                    %>
                    <tr class="border-b border-gray-200">
                        <td class="py-3 px-6 text-left"><%=transaction.getDate() %></td>
                        <td class="py-3 px-6 text-left">$<%=transaction.getAmount() %></td>
                        <td class="py-3 px-6 text-left"><span class="text-yellow-700 bg-yellow-200 px-1.5 py-1 text-center rounded"><%=transaction.getStatus() %></span></td>
                        <td class="py-3 px-6 text-left"> <button class="primary-btn px-4 py-1"><a href="#">Pay</a></button></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>