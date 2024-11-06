<%-- 
    Document   : profile
    Created on : 26 Oct, 2024, 12:42:37 PM
    Author     : HP
--%>

<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User) session.getAttribute("user");%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="../scripts/tailwind-config.js"></script>
        <style type="text/tailwindcss">
            @layer components {
      .primary-btn {
        @apply text-white bg-primary font-medium rounded-full text-base px-8 py-2 text-center dark:bg-light dark:text-darkColor;
      }
}
        </style>
    <div class="container mx-auto font-lato">
        <h1 class="text-2xl font-bold mb-6">Profile Dashboard</h1>
        <form  name="EditProfile" method="POST" action="EditProfileServlet" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 grid-rows-3 gap-6">

            <!-- Avatar of User with Upload Button -->
            <div class="p-4 border rounded-lg text-center max-h-72">
                <h2 class="text-lg font-semibold mb-4">Profile Picture</h2>
                <div class="relative flex">
                    <img id="avatarImg" src="<%= user.getAvatar_image()!= null ? "../" + user.getAvatar_image(): "../assets/images/profile.jpg" %>" alt="User Avatar Image" class="w-32 h-32 object-cover rounded-full mx-auto mb-4">
                    <input type="file" accept="image/*" id="avatar" name="avatar" class="hidden" onchange="previewProfileImage(event)">
                </div>
                    <button type="button" onclick="document.getElementById('avatar').click()" class="primary-btn">
                        <i class="fa-solid fa-upload"></i>
                    </button>
            </div>

            <!-- Score, Achievements, Total Rent, Total Borrowed -->
            <div class="p-4 border rounded-lg row-span-3 flex flex-col gap-y-5">
                <h2 class="text-lg font-semibold">Statistics</h2>
                <div class="grid grid-cols-2 gap-4">
                    <div class="text-center p-4 bg-gray-100 max-h-36 rounded-lg">
                        <p class="text-sm text-gray-600">Score</p>
                        <p class="text-xl font-bold">00</p>
                    </div>
                    <div class="text-center p-4 bg-gray-100 max-h-36 rounded-lg">
                        <p class="text-sm text-gray-600">Achievements</p>
                        <p class="text-xl font-bold">00</p>
                    </div>
                    <div class="text-center p-4 bg-gray-100 max-h-36 rounded-lg">
                        <p class="text-sm text-gray-600">Total Rent</p>
                        <p class="text-xl font-bold">00</p>
                    </div>
                    <div class="text-center p-4 bg-gray-100 max-h-36 rounded-lg">
                        <p class="text-sm text-gray-600">Total Borrowed</p>
                        <p class="text-xl font-bold">00</p>
                    </div>
                </div>
                <!-- Get Premium and Register as Org Buttons -->
            <div class="flex items-center justify-center gap-x-4">
                <button class="w-full px-6 py-2 bg-yellow-500 text-white font-semibold rounded">Get Premium</button>
                <button class="w-full px-6 py-2 bg-blue-500 text-white font-semibold rounded">Register as Organization</button>
            </div>
            </div>
            
            
            <!-- User Information -->
            <div class="p-4 border rounded-lg row-span-2">
                <h2 class="text-lg font-semibold mb-4">User Information</h2>
                <label class="block mb-2 text-sm font-medium text-gray-600" id="name">Name</label>
                <input type="text" id="userName" class="w-full p-2 mb-4 border rounded" name="name" id="name" placeholder="Enter your name" value="<%=user.getName()%>">
                <label class="block mb-2 text-sm font-medium text-gray-600" id="email">Email</label>
                <input type="email" id="userEmail" class="w-full p-2 mb-4 border rounded" name="email" id="email" placeholder="Enter your email" value="<%=user.getEmail()%>">
                <label class="block mb-2 text-sm font-medium text-gray-600" id="phone">Phone Number</label>
                <input type="tel" id="userPhone" class="w-full p-2 mb-4 border rounded" name="phone" id="phone" placeholder="Enter your phone number" value="<%=user.getPhno()%>">
                <label class="block mb-2 text-sm font-medium text-gray-600" id="address">Address</label>
                <textarea type="text" id="address" rows="5" class="w-full p-2 border rounded" name="address" id="address"><%=user.getAddress()%></textarea>
                <button type="submit" class="primary-btn">Save</button>
            </div>
        </form>
    </div>

    <script>
        // Function to preview the profile image when uploaded
        function previewProfileImage(event) {
            event.preventDefault();
            const fileInput = document.getElementById('avatar');
            const avatarImage = document.getElementById('avatarImg');
            const file = fileInput.files[0];

            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    avatarImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>

