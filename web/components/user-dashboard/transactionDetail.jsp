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

<div class="container mx-auto font-lato">
    <!-- Transaction Details Header -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold">Transaction Details</h1>
    </div>
    
    <!-- Transaction Details Content -->
    <div class="flex flex-col md:flex-row gap-6 bg-white p-6 rounded-lg shadow-lg">

        <!-- Product Image Section -->
        <div class="md:w-1/3">
            <img src="https://via.placeholder.com/150" alt="Product Image" class="w-full h-full object-cover rounded-lg shadow-md">
        </div>

        <!-- Product and Borrower Details Section -->
        <div class="md:w-2/3 space-y-4">
            <h2 class="text-xl font-semibold">Product Name</h2>
            <p class="text-lg">Price: $120 / month</p>
            <p class="text-sm text-gray-500">Tenure: 6 months</p>
            
            <div class="border-t border-gray-300 pt-4 space-y-1">
                <h3 class="font-semibold">Borrower Details:</h3>
                <p>Name: John Doe</p>
                <p>Address: 123 Main St, Springfield</p>
                <p>Contact: (123) 456-7890</p>
            </div>
        </div>
    </div>

    <!-- Progress Tracking Section -->
    <div class="mt-6 bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-lg font-semibold">Progress Tracking</h3>
        <div class="flex items-center justify-between mt-3">
            <div class="flex items-center w-full space-x-4">
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-semibold">1</div>
                    <p class="text-xs text-center mt-1">Lending</p>
                </div>
                <div class="flex-1 h-1 bg-blue-300"></div>
                <div class="flex flex-col items-center">
                    <div class="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-semibold">2</div>
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
    <div class="mt-6 bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-lg font-semibold">Rent Payment History</h3>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border rounded-lg">
                <thead>
                    <tr class="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">Date</th>
                        <th class="py-3 px-6 text-left">Amount</th>
                        <th class="py-3 px-6 text-left">Status</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <tr class="border-b border-gray-200">
                        <td class="py-3 px-6 text-left">01/01/2023</td>
                        <td class="py-3 px-6 text-left">$120</td>
                        <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center rounded">Paid</span></td>
                    </tr>
                    <tr class="border-b border-gray-200">
                        <td class="py-3 px-6 text-left">01/02/2023</td>
                        <td class="py-3 px-6 text-left">$120</td>
                        <td class="py-3 px-6 text-left"><span class="text-green-700 bg-green-200 px-1.5 py-1 text-center rounded">Paid</span></td>
                    </tr>
                    <tr class="border-b border-gray-200">
                        <td class="py-3 px-6 text-left">01/03/2023</td>
                        <td class="py-3 px-6 text-left">$120</td>
                        <td class="py-3 px-6 text-left"><span class="text-red-700 bg-red-200 px-1.5 py-1 text-center rounded">Pending</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
