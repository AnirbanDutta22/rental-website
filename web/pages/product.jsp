<%-- 
    Document   : product
    Created on : 29 Sep, 2024, 12:32:01 PM
    Author     : HP
--%>

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
    </head>
    <body>
        <section class="font-lato">
            <jsp:include page="../components/header.jsp" />
            <div class="pt-44 max-w-[1480px] mx-auto flex mb-6 text-xl gap-x-2"><span class="font-semibold">Products > </span><span class="font-semibold"> Furniture > </span><span>Table</span></div>
            <main class="pb-12 max-w-[1480px] mx-auto h-[100vh] flex justify-center gap-x-6">
                <div class="relative flex flex-col basis-3/5 h-full justify-between">
                    <div class="absolute w-full top-2 left-[93%]">
                                        <i class="fa-solid fa-heart text-primary text-2xl bg-white shadow border border-black rounded-full p-2 flex justify-end mr-10 cursor-pointer"></i>
                                    </div>
                    <div class="grid grid-cols-3 grid-rows-3 gap-5">
                        <div class="col-span-3 row-span-2"><img src="../assets/images/fur/table/table1.jpeg" alt="table1" class="w-full h-[34rem]"/></div>
                        <div class="col-span-1"><img src="../assets/images/fur/table/table2.jpeg" alt="table1" class="w-full h-[16rem]"/></div>
                        <div class="col-span-1"><img src="../assets/images/fur/table/table3.jpeg" alt="table1" class="w-full h-[16rem]"/></div>
                        <div class="col-span-1"><img src="../assets/images/fur/table/table4.jpeg" alt="table1" class="w-full h-[16rem]"/></div>
                    </div>
                    <div class="flex gap-5 items-center text-xl">
                        <span><span class="font-semibold">Owner :</span> Raju Sribastav</span>
                        <span><span class="font-semibold">Address :</span> Karolbagh, Delhi</span>
                        <span><span class="font-semibold">Posting Date :</span> September 20, 2024</span>
                    </div>
                </div>
                <div class="basis-2/5 h-full flex flex-col gap-y-16 px-6">
                    <div class="h-[10rem] flex flex-col gap-y-5 items-start">
                        <h1 class="text-3xl">Center Table <span class="text-lg">(Wooden, 20x16 inches)</span></h1>
                        <span class="font-semibold text-primary -mt-3">Rectangular | Wood | Glass</span>
                        <div class="flex gap-x-4 items-center">
                            <span class="text-xl">Rs. 1000</span>
                            <label for="tenure" class="hidden"></label>
  <select id="tenure" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
    <option value="3" selected>3 Months</option>
    <option value="6">6 Months</option>
    <option value="12">12 Months</option>
    <option value="18">18 Months</option>
  </select>
                        </div>
                        <a href="/pages/borrowRequest.jsp"><button class="primary-btn">Borrow</button></a>
                    </div>
                    <div>
                        <span class="text-2xl mb-3">Description</span>
                        <p>
                            Transform your home with our premium Wooden Center Table adorned with a sleek glass top. Elevate your living space with this exquisite center table that combines modern design with classic craftsmanship for a touch of luxury. Dimensions: 32D x 16W x 12H inches Note - All our products are made to order & can be customized as per availability. Delivery – 7 to 12 days Easy Shipping, Easy Returns Well Packed, No breakage
                        </p>
                    </div>
                    <div class="bg-darkColor/90 text-white flex-grow p-3">
                        <span class="relative text-3xl mb-3 before:content-[''] before:absolute before:w-full before:h-[3px] before:bg-light before:-bottom-1 before:left-0">Details</span>
                        <div class="grid grid-cols-2 grid-rows-3 gap-6 py-2">
                            <div>
                                <span class="text-light text-lg">Material : </span>
                                <p class='font-light'>Sheesham Wood, Tempered Glass</p>
                            </div>
                            <div>
                                <span class="text-light text-lg">Disclaimer :</span>
                                <p class='font-light'>Original product finish might slightly vary from the website image.</p>
                            </div>
                            <div>
                                <span class="text-light text-lg">Product Dimension :</span>
                                <p class='font-light'>L= 91.5cm; W=61cm ;H=38cm (36 inches x 24 inches x 14.9 inches)</p>
                            </div>
                            <div>
                                <span class="text-light text-lg">Weight without packaging :</span>
                                <p class='font-light'>14.5 kg</p>
                            </div>
                            <div class="col-span-2">
                                <span class="text-light text-lg">Colour :</span>
                                <p class='font-light'>Sheesham Finish
Product color and texture may vary slightly due to the difference in screen calibrations and resolutions across different displays owing to the photographic lighting sources or your device settings</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../components/footer.jsp"/>
        </section>
            <script>
                window.addEventListener('load', function () {
    window.scrollTo(0, 0); // Scroll to top when the page is loaded
});
  </script>
    </body>
</html>
