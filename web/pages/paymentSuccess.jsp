<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-green-50 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md text-center">
        <div class="text-green-500 text-6xl mb-4">✔</div>
        <h2 class="text-2xl font-bold text-green-700 mb-2">Payment Successful!</h2>
        <p class="text-gray-600 mb-4">Your payment has been processed successfully.</p>
        <p class="font-semibold">Transaction ID: <span class="text-blue-500"><%= request.getAttribute("transactionId") %></span></p>
        <p class="font-semibold">Payment Method: <span class="text-blue-500"><%= request.getAttribute("paymentMethod") %></span></p>
        <a href="/pages/paymentGateway.jsp" class="mt-6 inline-block bg-green-600 text-white py-2 px-6 rounded-lg hover:bg-green-700">Return to Home</a>
    </div>
</body>
</html>
