<%-- 
    Document   : header
    Created on : 28 Sep, 2024, 10:10:37 PM
    Author     : HP
--%>

<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User) session.getAttribute("user"); %>
<link href="../styles/utils.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/cb3d6578eb.js" crossorigin="anonymous"></script>
<nav class="text-xl font-medium text-darkColor backdrop-blur-2xl bg-white/80 shadow-md dark:bg-darkColor fixed w-full z-40 top-0 start-0 border-b border-gray-200 dark:bg-darkColor">
    <div class="max-w-screen-2xl flex items-center justify-between mx-auto p-2">
        <a href="/pages/index.jsp" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img src="../assets/images/logo.png" class="h-20" alt="Rentle Logo">
        </a>
        <div class="relative flex items-center md:order-2 space-x-3 md:space-x-4 rtl:space-x-reverse">
            <jsp:include page="./theme-toggle.jsp"/>

            <%
                if (user != null) {
            %>

            <img src="<%= user.getAvatar_image()!= null ? "../" + user.getAvatar_image(): "../assets/images/profile.jpg" %>" id="avatarButton" type="button" onclick="openProfileDropdown()" class="p-1 w-12 h-12 rounded-full cursor-pointer ring-2 ring-primary dark:ring-gray-500" alt="User dropdown">
                <%
                } else {
                %>
                <a href="/pages/login.jsp"><button type="button" class="text-white bg-primary hover:bg-primary-100 transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 whitespace-nowrap py-2 text-center dark:bg-light dark:text-darkColor">Login</button></a>
                <%
                    }%>

                <!-- Profile Dropdown menu -->
                <div id="profileDropdown" class="absolute top-14 -right-0 z-10 hidden bg-white divide-y divide-gray-100 rounded-lg shadow w-44 dark:bg-gray-700 dark:divide-gray-600">
                    <div class="px-4 py-3 text-sm text-gray-900 dark:text-white">
                        <div><% if (user != null) {%><%= user.getName()%><% } %></div>
                        <div class="font-medium truncate"><% if (user != null) {%><%= user.getEmail()%><% }%></div>
                    </div>

                    <ul class="py-2 text-sm text-gray-700 dark:text-gray-200">
                        <li>
                            <a href="/pages/userDashboard.jsp" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Dashboard</a>
                        </li>
                        <li>
                            <a href="#" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Settings</a>
                        </li>
                        <li>
                            <a href="#" class="block px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white">Earnings</a>
                        </li>
                    </ul>
                    <div class="py-1">
                        <form name="Logout" action="/pages/LogoutServlet" method="POST">
                            <button type="submit" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Sign out</button>
                        </form>
                    </div>
                </div>
                <button type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600">
                    <span class="sr-only">Open main menu</span>
                    <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
                    </svg>
                </button>
        </div>
        <div class="md:items-center md:justify-between hidden w-full md:flex md:w-auto" id="navbar-sticky">
            <ul id="navbar" class="flex flex-col p-4 md:p-0 mt-2 font-medium border md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0">
            </ul>
        </div>
    </div>
    <div class="sub-nav h-[3rem] max-w-screen-2xl mx-auto text-darkColor bg-white/70 flex justify-center items-center gap-x-10" id="subNav">
        <div class="basis-[25%] w-full flex justify-start items-center gap-x-2">   
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
                            <input type="text" class="bg-white text-darkColor text-base h-10 w-full px-12 rounded-lg border outline-none" name="" placeholder="Search products...">
                                <span class="absolute top-2 right-5 border-l pl-4"><i class="fa fa-microphone text-gray-500 hover:text-green-500 hover:cursor-pointer"></i></span>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
        <div class="flex justify-end items-center gap-x-8 basis-[30%]">
            <a href="/pages/requestDashboard.jsp" class="hover:text-primary transition-all ease-in-out duration-300"><i class="fa-solid fa-list mr-2"></i>Requests</a>
            <a href="/pages/wishlist.jsp" class="hover:text-primary transition-all ease-in-out duration-300"><i class="fa-solid fa-heart mr-2"></i>Wishlist</a>
            <a href="/pages/userDashboard.jsp?page=lendProduct"><button type="button" class="text-white bg-primary hover:bg-primary-100 transition-all ease-in-out duration-300 font-medium rounded-full text-base px-8 whitespace-nowrap py-2 text-center dark:bg-light dark:text-darkColor">Lend +</button></a>
        </div>
    </div>
</nav>

<script>
    // load nav items
    window.addEventListener("load", function () {
        var navItems = [
            {
                navItem: "Home",
                link: "/pages/index.jsp"
            },
            {
                navItem: "About",
                link: "/pages/about.html"
            },
            {
                navItem: "Support",
                link: "/pages/support.jsp"
            }
        ];

        var navbar = document.getElementById("navbar");
        var subNavbar = document.getElementById("subNav");

        if (window.location.pathname.includes("/pages/userDashboard.jsp") || window.location.pathname.includes("/pages/wishlist.jsp") || window.location.pathname.includes("/pages/support.jsp")) {
            subNavbar.classList.add("hidden");
        } else {
            //navbar on scroll behaviour
            window.addEventListener("scroll", function () {
                var subNav = document.getElementById("subNav");
                if (window.scrollY > 300) {
                    console.log("Hello");
                    subNav.classList.add("hidden");
                } else {
                    subNav.classList.remove("hidden");
                }
            });
        }
        navItems.forEach(function (item) {
            var li = document.createElement("li");  // Create list item
            var a = document.createElement("a");    // Create anchor tag

            // Set attributes and text for the anchor tag
            a.href = item.link;
            a.textContent = item.navItem;
            a.className = "block py-2 px-3 rounded md:bg-transparent md:p-0 hover:text-primary hover:text-primary transition-all ease-in-out duration-300";

            if (a.href.includes(window.location.pathname)) {
                a.classList.add("text-primary");
            } else {
                a.classList.remove("text-primary");
            }

            li.appendChild(a);  // Append anchor to list item
            navbar.appendChild(li);  // Append list item to navbar
        });
    });

    //profile dropdown open
    var profileDD = document.getElementById("profileDropdown");

    function openProfileDropdown() {
        if (profileDD.classList.contains('hidden')) {
            profileDD.classList.remove('hidden');
        } else {
            profileDD.classList.add('hidden');
        }
    }

</script>
