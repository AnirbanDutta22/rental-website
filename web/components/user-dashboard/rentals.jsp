<%-- 
    Document   : rentals
    Created on : 26 Oct, 2024, 2:03:48 PM
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="models.User"%>
<%@page import="models.Rental"%>
<%@page import="java.util.List"%>
<%@page import="dao.RentalDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        .secondary-btn {
            @apply text-black bg-white font-medium rounded-full text-base px-8 py-2 text-center border border-primary dark:bg-light dark:text-darkColor;
        }
    }
</style>

<%
    User user = (User) session.getAttribute("user");
    // Get the current user ID (assuming it's stored in the session)
    Integer userId = user.getId();
    System.out.println(userId);
    // Fetch rental details using DAO
    RentalDAO rentalDAO = new RentalDAO();
    ResponseHandler rentalRes;
    List<Rental> rentalList;

    rentalRes = rentalDAO.getRentalDetails(userId);

    if (rentalRes.isSuccess()) {
        rentalList = (List<Rental>) rentalRes.getData();
        System.out.println(rentalList);
        for (Rental rent : rentalList) {
            System.out.println(rent.getProductName());
        }
        session.setAttribute("rentalList", rentalList);
    } else {
        rentalList = new ArrayList<Rental>();
    }


%>

<div class="container mx-auto font-lato">
    <div class="flex justify-between items-center mb-4">
        <h1 class="text-2xl font-bold">Rentals</h1>
        <div>  
            <button class="primary-btn"><i class="fa-solid fa-filter mr-2 text-white"></i>Filter</button>
        </div>
    </div>
    <!-- Transaction Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white border rounded-lg">
            <thead>
                <tr class="w-full bg-light text-gray-600 uppercase text-sm leading-normal">
                    <th class="py-3 px-6 text-left">Product Image</th>
                    <th class="py-3 px-6 text-left">Name</th>
                    <th class="py-3 px-6 text-left">Status</th>
                    <th class="py-3 px-6 text-left">Type</th>
                    <th class="py-3 px-6 text-left">Last Transaction Date</th>
                    <th class="py-3 px-6 text-center">Details</th>
                </tr>
            </thead>
            <tbody class="text-gray-600 text-sm font-light">

                <%                    for (Rental rental : rentalList) {
                %>
                <!-- Sample Row 1 -->
                <tr class="border-b border-gray-200">
                    <td class="py-3 px-6 text-left">
                        <img src="/assets/images/logo.png" alt="Product Image" class="w-12 h-12 rounded">
                    </td>
                    <td class="py-3 px-6 text-left"><%=rental.getProductName()%><br>(<%=rental.getProductSpec()%>)</td>
                    <td class="py-3 px-6 text-left">
                        <%
                            String status;
                            String statusClass = "";
                            String statusText = "";
                            if (rental.getStatus() == null) {
                                status = "canceled";
                            } else {
                                status = rental.getStatus();
                            }

                            switch (status) {
                                case "completed":
                                    statusClass = "text-green-700 bg-green-200";
                                    statusText = "Completed";
                                    break;
                                case "pending":
                                    statusClass = "text-yellow-700 bg-yellow-200";
                                    statusText = "Ongoing";
                                    break;
                                case "canceled":
                                    statusClass = "text-red-700 bg-red-200";
                                    statusText = "Canceled";
                                    break;
                                default:
                                    break;
                            }
                        %>
                        <span class="<%= statusClass%> px-1.5 py-1 text-center"><%= statusText%></span>
                    </td>
                    <%
                        if (rental.getBorrowerId() == userId) {
                    %>
                    <td class="py-3 px-6 text-left">Borrow</td>
                    <%
                    } else {
                    %>
                    <td class="py-3 px-6 text-left">Lend</td>
                    <%
                        }
                    %>
                    <td class="py-3 px-6 text-left">2023-10-15</td>
                    <td class="py-3 px-6 text-center">
                        <a href="userDashboard.jsp?page=rentalDetail&requestId=<%=rental.getRequestId()%>" class="text-xl text-primary hover:text-primary-100">
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </td>
                    <%
                        }
                    %>
                </tr>

            </tbody>
        </table>
    </div>
</div>