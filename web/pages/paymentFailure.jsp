<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
System.out.println(request.getAttribute("requestId"));
int requestId = (Integer) request.getAttribute("requestId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Failed</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-red-50 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-md text-center">
        <div class="text-red-500 text-6xl mb-4">✘</div>
        <h2 class="text-2xl font-bold text-red-700 mb-2">Payment Failed!</h2>
        <p class="text-gray-600 mb-4">Your payment could not be processed.</p>
        <p class="font-semibold">Transaction ID: <span class="text-blue-500"><%= request.getAttribute("transactionId") %></span></p>
        <p class="text-gray-600">Please try again later.</p>
        <a href="pages/userDashboard.jsp?page=rentalDetail&requestId=<%=requestId%>" class="mt-6 inline-block bg-red-600 text-white py-2 px-6 rounded-lg hover:bg-red-700">Retry Payment</a>
    </div>
</body>
</html>
