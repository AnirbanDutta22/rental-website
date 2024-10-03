<%-- 
    Document   : requestPage
    Created on : 3 Oct, 2024, 12:31:31 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <link rel="stylesheet" href="../styles/utils.css">
       <title>Request Dashboard</title>
    </head>
    <body>
        <section class="h-screen font-lato">
        <jsp:include page="../components/header.jsp"/>
        <div class="flex items-start max-w-screen-2xl mx-auto pt-44 pb-3 min-h-[40rem] gap-x-8">
            <div class="w-[15rem] text-xl font-semibold">
                <ul>
                    <li id="yourRequestTab" class="px-4 py-2.5 bg-gray-300/50 cursor-pointer" onclick="showSection('yourRequests')">Your Requests</li>
                    <li id="borrowRequestTab" class="px-4 py-2.5 cursor-pointer" onclick="showSection('borrowRequests')">Borrow Requests</li>
                </ul>
            </div>
            <!--your requests-->
            <div class="flex flex-col gap-y-5 w-full" id="yourRequests">
                <!--your requests content goes here-->
                <!--request rejected-->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/fur/SOFA/sofa1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span class="w-[15%]">Fancy Sofa</span>
                    <span class="w-[10%]">Rs. 1000/month</span>
                    <span class="w-[10%]">3 months</span>
                    <span class="w-[15%] text-red-700 bg-red-200 px-1.5 py-1 text-center">Request Rejected</span>
                    <span class="w-[10%]">12/09/2024</span>
                    <button class="primary-btn px-4 w-[12%]">Request Again</button>
                    </div>
                    <div class="bg-blue-300 w-full h-0 hidden">
                        
                    </div>
                </div>
                <!--request pending-->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/home/TV/tv1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span class="w-[15%]">Sony TV</span>
                    <span class="w-[10%]">Rs. 1000/month</span>
                    <span class="w-[10%]">3 months</span>
                    <span class="w-[15%] text-yellow-700 bg-yellow-200 px-1.5 py-1 text-center">Request Pending</span>
                    <span class="w-[10%]">12/09/2024</span>
                    <button class="primary-btn bg-red-500 px-4 w-[12%]">Cancel Request</button>
                    </div>
                    <div class="bg-blue-300 w-full h-0 hidden">
                        
                    </div>
                </div>
                <!--requested accepted-->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/home/AC/ac1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span class="w-[15%]">Voltus AC</span>
                    <span class="w-[10%]">Rs. 1000/month</span>
                    <span class="w-[10%]">3 months</span>
                    <span class="w-[15%] text-green-700 bg-green-200 px-1.5 py-1 text-center">Request Accepted</span>
                    <span class="w-[10%]">30/08/2024</span>
                    <button class="primary-btn bg-darkColor px-4 w-[12%]" id="contactBtn" onclick="detailsOpen(event)">Contact <i class="fa-solid fa-chevron-down"></i></button>
                    </div>
                    <div class="flex justify-between w-full h-0 px-5 transition-all ease-in-out duration-300" id="contactDetails">
                                    <!--contact details-->
                                    <div class="hidden" id="details">
                           <span class="font-bold">Contact Details : </span>
                        <h2>
                            Owner Name : Raju Sribastav
                        </h2>
                        <h2>
                            Product Address : Sector 3, Saltlake, Kolkata, 700091
                        </h2>
                        <h2>
                            Phone Number : +919876564531
                        </h2> 
                        </div>
                        <div class="bg-medium/60 h-full w-1/2 hidden" id="chatBox">
                                    <!--chatbox-->
                                    <div class="flex flex-col w-full h-full">
                                        <header class="bg-blue-300">
                                            <span class="text-base">Raju Sribastav</span>
                                            <p class="text-sm">online</p>
                                        </header>
                                        <main class="flex-grow">
                                            
                                        </main>
                                        <footer class="bg-blue-500">
                                            <input type="text" class="bg-blue-500 w-full p-2">
                                        </footer>
                                    </div>
                        </div>
                    </div>
                </div>
                <!--completed and ongoing deal -->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-10">
                        <div class="w-28 h-20">
                        <img src="../assets/images/home/TV/tv1.jpeg" alt="item1" class="w-full h-20"/>
                    </div>
                    <span class="w-[15%]">Wheelchair</span>
                    <span class="w-[10%]">Rs. 1000/month</span>
                    <span class="w-[10%]">3 months</span>
                    <span class="w-[15%] text-green-600 bg-green-100 px-1.5 py-1 text-center">On Rental</span>
                    <span class="w-[10%]">10/07/2024</span>
                    <button class="primary-btn bg-green-600 px-4 w-[12%]">View<i class="ml-3 fa-solid fa-eye"></i></button>
                    </div>
                    <div class="bg-blue-300 w-full h-0">
                    </div>
                </div>
            </div>
            
            <!--borrow requests-->
            <div class="flex flex-col gap-y-5 w-full hidden" id="borrowRequests">
        <!-- Borrow Requests content goes here -->
        <div class="flex flex-col gap-y-3 text-sm">
            <div class="flex w-full justify-start items-center px-3 gap-x-8">
                <div class="w-20 h-14">
                    <img src="../assets/images/fur/SOFA/sofa2.jpeg" alt="item1" class="w-full h-14"/>
                </div>
                <span class="w-[10%]">Office Chair</span>
                <span class="w-[20%]"><span class="font-semibold">Offered Price :</span> Rs. 800/month
                                      <span class="font-semibold">Preferred Date : </span>01/10/2024</span>
                <span class="w-[10%]">12 months</span>
                <span class="w-[30%] text-xs">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta
                ullam minus perspiciatis? Iste vel, quaerat, at minima molestias
                voluptas perferendis cum architecto dolore, dolorem repellendus.</span>
                <span class="w-[10%]">05/09/2024</span>
                <div class="flex-grow flex justify-end gap-x-2.5">
                <button class="primary-btn bg-green-600 px-4">Accept</button>
                <button class="primary-btn bg-red-500 px-4">Reject</button>
                </div>
            </div>
        </div>
        <!--requested accepted-->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-14">
                        <div class="w-20 h-18">
                        <img src="../assets/images/home/AC/ac1.jpeg" alt="item1" class="w-20 h-18"/>
                    </div>
                    <span class="w-[10%]">Voltus AC</span>
                    <span class="w-[10%]">Rs. 700/month</span>
                    <span class="w-[10%]">6 months</span>
                    <span class="w-[15%] text-green-700 bg-green-200 px-1.5 py-1 text-center">Request Accepted</span>
                    <span class="w-[10%]">30/08/2024</span>
                    <button class="primary-btn bg-darkColor px-4 flex-grow" id="contactBtn" onclick="detailsOpen(event)">Contact <i class="ml-3 fa-solid fa-chevron-down"></i></button>
                    </div>
                    <div class="flex justify-between w-full h-0 px-5 transition-all ease-in-out duration-300" id="contactDetails">
                                    <!--contact details-->
                                    <div class="flex flex-col hidden" id="details">
                           <span class="font-bold">Contact Details : </span>
                        <h2>
                            Borrower Name : Amit Baba
                        </h2>
                        <h2>
                            Borrower Address : Belghoria , Kolkata, 700102
                        </h2>
                        <h2>
                            Phone Number : +919876123431
                        </h2> 
                           <div class="flex-grow flex items-end gap-x-6">
                               <button class="primary-btn bg-green-600 px-4">Deal Final</button>
                               <button class="primary-btn bg-red-500 px-4">Deal Cancel</button>
                           </div>
                        </div>
                        <div class="bg-medium/60 h-full w-1/2 hidden" id="chatBox">
                                    <!--chatbox-->
                                    <div class="flex flex-col w-full h-full">
                                        <header class="bg-blue-300">
                                            <span class="text-base">Amit Baba</span>
                                            <p class="text-sm">offline</p>
                                        </header>
                                        <main class="flex-grow">
                                            
                                        </main>
                                        <footer class="bg-blue-500">
                                            <input type="text" class="bg-blue-500 w-full p-2">
                                        </footer>
                                    </div>
                        </div>
                    </div>
                </div>
        <!--completed and ongoing deal -->
                <div class="flex flex-col gap-y-3">
                    <div class="flex w-full justify-start items-center px-3 gap-x-14">
                        <div class="w-20 h-18">
                        <img src="../assets/images/home/TV/tv1.jpeg" alt="item1" class="w-20 h-18"/>
                    </div>
                    <span class="w-[10%]">Wheelchair</span>
                    <span class="w-[10%]">Rs. 1000/month</span>
                    <span class="w-[10%]">3 months</span>
                    <span class="w-[15%] text-green-600 bg-green-100 px-1.5 py-1 text-center">On Rental</span>
                    <span class="w-[10%]">10/07/2024</span>
                    <button class="primary-btn bg-green-600 px-4 flex-grow">View<i class="ml-3 fa-solid fa-eye"></i></button>
                    </div>
                    <div class="bg-blue-300 w-full h-0">
                    </div>
                </div>
    </div>
        </div>
        <jsp:include page="../components/footer.jsp"/>
        </section>
        <script>
            function showSection(sectionId) {
    
    var yourRequests = document.getElementById('yourRequests');
    var yourRequestTab = document.getElementById('yourRequestTab');
    var borrowRequests = document.getElementById('borrowRequests');
    var borrowRequestTab = document.getElementById('borrowRequestTab');
    
    // Hide both sections initially
    yourRequests.classList.add('hidden');
    borrowRequests.classList.add('hidden');
    
    if(sectionId === 'yourRequests') {
        borrowRequestTab.classList.remove('bg-gray-300/50');
        yourRequestTab.classList.add('bg-gray-300/50');
        yourRequests.classList.remove('hidden');
    } else if(sectionId === 'borrowRequests') {
        yourRequestTab.classList.remove('bg-gray-300/50');
        borrowRequestTab.classList.add('bg-gray-300/50');
        borrowRequests.classList.remove('hidden');
    }
}
            
            function detailsOpen(e){
                console.log(e.target.parentElement);
                var container = e.target.parentElement.parentElement.parentElement;
                console.log(container);
            //my requests
            var contactDetails = container.querySelector("#contactDetails");
            var detailsPart = container.querySelector("#details");
            var chatBox = container.querySelector("#chatBox");
            
                if(contactDetails.classList.contains("h-[32rem]")){
                 contactDetails.classList.remove("h-[32rem]");
                 detailsPart.classList.add("hidden");
                 chatBox.classList.add("hidden");
                }else{
                    contactDetails.classList.add("h-[32rem]");
                    detailsPart.classList.remove("hidden");
                    chatBox.classList.remove("hidden");
                }
            }
        </script>
    </body>
</html>

