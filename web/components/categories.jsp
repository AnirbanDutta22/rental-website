<%-- 
    Document   : categories
    Created on : 29 Sep, 2024, 8:53:28 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String[] categories = new String[]{"Furniture","Electronics","Cars","Fashion","Furniture","Electronics","Cars","Fashion"};
    String[] categoryImages = new String[]{"../assets/images/fur/bed/bed3.jpeg","../assets/images/home/AC/ac1.jpeg","../assets/images/vehicals/scooty/scooty1.jpeg","../assets/images/fur/bed/bed3.jpeg","../assets/images/home/AC/ac1.jpeg","../assets/images/vehicals/scooty/scooty1.jpeg","../assets/images/fur/bed/bed3.jpeg","../assets/images/home/AC/ac1.jpeg"};
%>
    <div class="mt-8">
        <h2 class="text-2xl font-semibold mb-4">Browse Categories</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 lg:grid-cols-8 gap-6"> 
                <% for(int cat=0;cat < categories.length; cat++){
                    %>
                    <div class="bg-white h-36 w-36 p-4 text-center flex justify-center items-center rounded-md shadow-md hover:scale-105 hover:shadow-lg transition-all ease-in-out duration-300 cursor-pointer bg-cover bg-no-repeat bg-center" style="background-image:linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.7)), url('<%= categoryImages[cat] %>')">
                        <h3 class="font-semibold text-white text-lg"><%= categories[cat]%></h3>
                    </div><%
                }%>
        </div>
    </div>