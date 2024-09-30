<%-- 
    Document   : header
    Created on : 28 Sep, 2024, 10:10:37 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String[] navitems = new String[]{"Home","About","Support"};
    String[] navLinks = new String[]{"home","about","support"};
%>
<script src="https://kit.fontawesome.com/cb3d6578eb.js" crossorigin="anonymous"></script>
<nav class="text-xl font-medium text-darkColor backdrop-blur-2xl bg-medium/10 shadow-md dark:bg-darkColor fixed w-full z-20 top-0 start-0 border-b border-gray-200 dark:bg-darkColor">
  <div class="max-w-screen-2xl flex flex-wrap items-center justify-between mx-auto p-2">
  <a href="/home" class="flex items-center space-x-3 rtl:space-x-reverse">
      <img src="../assets/images/logo.png" class="h-20" alt="Rentle Logo">
  </a>
  <div class="flex md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
      <jsp:include page="./theme-toggle.jsp"/>
      <a href="/pages/login.jsp"><button type="button" class="text-white bg-primary font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor">Login</button></a>
      <button type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600">
        <span class="sr-only">Open main menu</span>
        <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
        </svg>
    </button>
  </div>
  <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-sticky">
    <ul class="flex flex-col p-4 md:p-0 mt-2 font-medium border md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0">
      <%for ( int item = 0; item < navitems.length; item++){ %>
         <li>
        <a href="/<%= navLinks[item] %>" class="block py-2 px-3 rounded md:bg-transparent md:p-0"><%= navitems[item] %></a>
      </li>
      <%}%>
    </ul>
  </div>
  </div>
    <div class="sub-nav h-[3rem] w-full mx-auto text-darkColor bg-white/70 flex justify-center items-center gap-x-10" id="subNav">
        <div class="basis-[25%] w-full flex justify-center items-center gap-x-2">   
            <label for="location" class="block"><i class="fa-solid fa-location-dot"></i></label>
            <select id="location" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-blue-500 focus:border-blue-500 block p-1.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                <option value="kol">Kolkata</option>
                <option value="del">Delhi</option>
                <option value="asm">Assam</option>
            </select>
        </div>
        <div class="searchbar px-2 py-2 basis-[50%]">
  <div class="max-w-md mx-auto rounded-lg overflow-hidden md:max-w-xl">
  <div class="md:flex">
      <div class="w-full">
        <div class="relative">
          <i class="absolute fa fa-search text-gray-400 top-2.5 left-4"></i>
          <input type="text" class="bg-white text-darkColor text-base h-10 w-full px-12 rounded-lg outline" name="" placeholder="Search products...">
          <span class="absolute top-2 right-5 border-l pl-4"><i class="fa fa-microphone text-gray-500 hover:text-green-500 hover:cursor-pointer"></i></span>
        </div> 
      </div>
  </div>
</div>
</div>
        <div class="flex justify-center items-center gap-x-10 basis-[25%]">
            <a href="/product-requests"><i class="fa-solid fa-list mr-2"></i>Requests</a>
            <a href="/my-products"><i class="fa-solid fa-cart-shopping mr-2"></i>Cart</a>

        </div>
    </div>
</nav>
    
    <script>
        window.addEventListener("scroll",function(){
            var subNav = document.getElementById("subNav");
            if(window.scrollY > 300){
                console.log("Hello");
                subNav.classList.add("hidden");
            }else{
                subNav.classList.remove("hidden");
            }
        });
    </script>
