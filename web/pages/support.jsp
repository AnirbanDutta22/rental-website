<%-- 
    Document   : support
    Created on : 27 Oct, 2024, 11:38:05 PM
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
        <title>Help & Support</title>
        <style>
            body.loaded #loader {
                display: none;
            }
        </style>
    </head>
    <body class="font-lato">
        <!-- Loader -->
        <div id="loader" class="fixed inset-0 flex items-center justify-center bg-white z-50">
            <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-primary"></div>
        </div>
        <!--header-->
        <jsp:include page="../components/header.jsp" />
        <main class="w-full">
            <!--help-->
            <section class="section h-96 relative text-center">
                <div class="inset-0 absolute bg-cover bg-center opacity-10" style="background-image: url('../assets/images/help.jpg');"></div>
                <h1 class="text-5xl font-bold capitalize pt-36">
                    how can we <span class="text-primary">help</span> you ?
                </h1>
                <p class="w-2/3 mx-auto text-xl mt-6">
                    Here are a few of the questions we get the most. If you don&apos;t
                    see what&apos;s on your mind, reach out to us anytime on <a href="mailto:bcaminor2025@gmail.com" class="relative inset-0 text-blue-700 cursor-pointer underline">email</a>
                </p>
                <form class="max-w-2xl mx-auto my-6">
                    <label
                        for="default-search"
                        class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white"
                        >
                        Search
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 start-0 flex items-center ps-3 pointer-events-none">
                            <svg
                                class="w-4 h-4 text-gray-500 dark:text-gray-400"
                                aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 20 20"
                                >
                            <path
                                stroke="currentColor"
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth="2"
                                d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"
                                />
                            </svg>
                        </div>
                        <input
                            type="search"
                            id="default-search"
                            class="block w-full p-4 ps-10 text-sm text-gray-900 border border-gray-300 rounded-lg"
                            placeholder="Search..."
                            required
                            />
                    </div>
                </form>
            </section>
            <!--faq-->
            <section class="bg-white dark:bg-gray-900">
                <div class="py-8 px-4 mx-auto max-w-screen-xl sm:py-16 lg:px-6">
                    <h2 class="mb-8 text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white">Frequently asked questions</h2>
                    <div class="grid pt-8 text-left border-t border-gray-200 md:gap-16 dark:border-gray-700 md:grid-cols-2">
                        <div id="faq-container">

                        </div>
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp"/>
        <script>
            window.addEventListener("load", function () {
                document.body.classList.add('loaded');
            });
        </script>
        <script src="../scripts/supportcontent.js"></script>
    </body>
</html>
