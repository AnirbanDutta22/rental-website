<%-- 
    Document   : about
    Created on : 15 Jan, 2025, 1:50:32 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <title>About Us</title>
        <style type="text/tailwindcss">
            @layer components {
                .primary-btn {
                    @apply text-white bg-primary font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
                }
            }
        </style>
        <style>
            body.loaded #loader {
                display: none;
            }
        </style>
    </head>
    <body class="text-gray-800 font-lato">
        <jsp:include page="../components/header.jsp" />

        <!-- About Us Section -->
        <section class="pt-20 relative h-96 flex items-center justify-center text-white bg-cover bg-center" style="background-image: url('../../assets/images/about.jpg');">
            <div class="absolute inset-0 bg-black opacity-10"></div>
            <div class="relative z-10 text-center px-4">
                <h1 class="text-4xl font-bold mb-2">About Us</h1>
                <p class="text-lg max-w-2xl mx-auto">Our rental platform is a project built by six passionate team members aiming to revolutionize the rental experience. We bring you a user-friendly platform to discover rental opportunities seamlessly.</p>
            </div>
        </section>

        <!-- Project Description Section -->
        <section class="py-12 px-4 text-center bg-white">
            <h2 class="text-3xl font-semibold mb-4">Our Project</h2>
            <p class="max-w-3xl mx-auto text-lg leading-relaxed">This project is a comprehensive rental platform designed to connect users with various rental opportunities, making the process efficient and enjoyable. From cars to appliances, our team has crafted an intuitive platform that simplifies the rental process.</p>
        </section>

        <!-- Team Members Section -->
        <section class="py-12 px-4 bg-light">
            <h2 class="text-3xl font-semibold text-center mb-10">Meet the Team</h2>
            <div class="max-w-6xl mx-auto grid gap-8 sm:grid-cols-2 lg:grid-cols-3">

                <!-- Team Member Card -->
                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member1.jpg" alt="Member 1" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Srikanta Roy (Leader)</h3>
                    <p class="text-gray-500">Role: Full Stack Developer</p>
                    <p class="mt-2 text-sm text-gray-600">Responsible for both front-end and back-end development, our Full Stack Developer ensures a seamless, responsive experience for users. Bridge design and functionality, making the platform robust and user-friendly.</p>
                </div>

                <!-- Repeat for each team member -->
                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member2.jpg" alt="Member 2" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Anirban Dutta</h3>
                    <p class="text-gray-500">Role: Full Stack Developer</p>
                    <p class="mt-2 text-sm text-gray-600">Responsible for both front-end and back-end development, our Full Stack Developer ensures a seamless, responsive experience for users. Bridge design and functionality, making the platform robust and user-friendly.</p>
                </div>

                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member3.jpg" alt="Member 3" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Sneha Saha</h3>
                    <p class="text-gray-500">Role: Database Administrator</p>
                    <p class="mt-2 text-sm text-gray-600">Responsible for managing and optimizing our database for fast and reliable data access.</p>
                </div>

                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member4.jpg" alt="Member 4" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Suvranil Chowdhury</h3>
                    <p class="text-gray-500">Role: Backend Developer</p>
                    <p class="mt-2 text-sm text-gray-600">Skilled in server-side development, ensuring a robust and secure backend structure.</p>
                </div>

                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member5.jpg" alt="Member 5" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Shreya Das</h3>
                    <p class="text-gray-500">Role: Backend Developer</p>
                    <p class="mt-2 text-sm text-gray-600">Skilled in server-side development, ensuring a robust and secure backend structure.</p>
                </div>

                <div class="bg-white shadow-lg rounded-lg p-6 text-center">
                    <img src="member6.jpg" alt="Member 6" class="w-24 h-24 mx-auto rounded-full mb-4">
                    <h3 class="text-xl font-semibold">Saptarshi Sarkar</h3>
                    <p class="text-gray-500">Role: Project Manager</p>
                    <p class="mt-2 text-sm text-gray-600">Ensures smooth coordination among team members and timely project completion.</p>
                </div>

            </div>
        </section>
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>

