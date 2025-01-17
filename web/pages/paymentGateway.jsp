<%-- 
    Document   : paymentGateway
    Created on : 17 Jan, 2025, 1:59:12 PM
    Author     : Srikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <header class="bg-green-600 p-4 flex justify-between items-center">
        <a href="/pages/userDashboard.jsp?page=rentalDetail&requestId=123<%--rental.getRequestId()--%>" class="text-white">✕ Cancel</a>
        <div class="text-white flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
            Secure Payments by PayU
        </div>
    </header>
    <main class="max-w-2xl mx-auto mt-8 p-4">
        <div class="text-center mb-8">
            <div class="bg-white rounded-lg p-4 inline-block mb-4">
                <div class="w-20 h-20 bg-orange-500 rounded-lg mx-auto flex items-center justify-center text-black text-2xl font-bold">
                    <img src="/assets/images/logo.png">
                </div>
            </div>
            <div class="text-2xl font-bold">PAY ₹799</div>
        </div>
        <div class="bg-white p-4 rounded-lg mb-4 flex justify-between items-center">
            <div class="flex items-center gap-2">
                <span class="text-gray-600">rentleofficiall@citruspay.com</span>
            </div>
            <button class="text-blue-500">Show Details</button>
        </div>
        <div class="bg-white rounded-lg p-4">
            <h2 class="text-lg font-semibold mb-4">Payment Options : Cards (Credit/Debit) & UPI</h2>
            <div class="flex">
                <div class="w-1/4 border-r">
                    <div class="mb-4 text-gray-600 cursor-pointer bg-gray-100 p-2 rounded" id="cards-option">
                        Cards
                    </div>
                    <div class="mb-4 text-gray-600 cursor-pointer hover:bg-gray-100 p-2 rounded" id="upi-option">
                        UPI
                    </div>
                </div>
                <div class="w-3/4 pl-6" id="payment-form">
                    <form action="/PaymentServlet" method="post">
                        <div class="mb-4">
                            <input type="text" class="w-full p-2 border rounded" name="cardNumber" placeholder="Card Number" pattern="\d{16}" required />
                        </div>
                        <div class="flex gap-4 mb-4">
                            <input type="text" class="w-1/3 p-2 border rounded" name="expiry" placeholder="MM/YY" pattern="(0[1-9]|1[0-2])/[0-9]{2}" required />
                            <input type="password" class="w-1/3 p-2 border rounded" name="cvv" placeholder="CVV" pattern="\d{3}" required />
                        </div>
                        <div class="mb-4">
                            <input type="text" class="w-full p-2 border rounded" name="cardHolder" placeholder="Card Holder Name" required />
                        </div>
                        <button class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700" type="submit">Pay Now</button>
                    </form>
                </div>
            </div>
        </div>
    </main>
    <script>
        document.getElementById('cards-option').addEventListener('click', function() {
            document.getElementById('payment-form').innerHTML = `
                <form action="/PaymentServlet" method="post">
                    <div class="mb-4">
                        <input type="text" class="w-full p-2 border rounded" name="cardNumber" placeholder="Card Number" pattern="\\d{16}" required />
                    </div>
                    <div class="flex gap-4 mb-4">
                        <input type="text" class="w-1/3 p-2 border rounded" name="expiry" placeholder="MM/YY" pattern="(0[1-9]|1[0-2])/[0-9]{2}" required />
                        <input type="password" class="w-1/3 p-2 border rounded" name="cvv" placeholder="CVV" pattern="\\d{3}" required />
                    </div>
                    <div class="mb-4">
                        <input type="text" class="w-full p-2 border rounded" name="cardHolder" placeholder="Card Holder Name" required />
                    </div>
                    <button class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700" type="submit">Pay Now</button>
                </form>`;
        });
        
        document.getElementById('upi-option').addEventListener('click', function() {
            document.getElementById('payment-form').innerHTML = `
                <form action="/PaymentServlet" method="post">
                    <div class="mb-4">
                        <input type="text" class="w-full p-2 border rounded" name="upiId" placeholder="Enter UPI ID" pattern="^[a-zA-Z0-9.]+@[a-zA-Z]+$" required />
                    </div>
                    <button class="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700" type="submit">Pay Now</button>
                </form>`;
        });
    </script>
</body>
</html>
