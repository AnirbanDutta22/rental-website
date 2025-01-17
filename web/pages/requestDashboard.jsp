<%-- 
    Document   : requestPage
    Created on : 3 Oct, 2024, 12:31:31 AM
    Author     : HP
--%>

<%@page import="utils.DateFormatter"%>
<%@page import="responses.ResponseHandler"%>
<%@page import="dao.ProductDAO"%>
<%@page import="models.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="models.Product"%>
<%@page import="models.SelectedProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User) session.getAttribute("user");
    ProductDAO productDAO = new ProductDAO();
    ResponseHandler ownBorrowReqRes, borrowReqRes;
    List<SelectedProduct> ownBRList, BRList;

    if (user != null) {
        ownBorrowReqRes = productDAO.getOwnBorrowRequests(user.getId());
        borrowReqRes = productDAO.getBorrowRequests(user.getId());

        if (ownBorrowReqRes.isSuccess()) {
            ownBRList = (List<SelectedProduct>) ownBorrowReqRes.getData();
            session.setAttribute("ownBorrowRequestList", ownBRList);
        } else {
            ownBRList = new ArrayList<SelectedProduct>();
        }
        if (borrowReqRes.isSuccess()) {
            BRList = (List<SelectedProduct>) borrowReqRes.getData();
            session.setAttribute("borrowRequestList", BRList);
        } else {
            BRList = new ArrayList<SelectedProduct>();
        }
    } else {
        ownBRList = new ArrayList<SelectedProduct>();
        BRList = new ArrayList<SelectedProduct>();
    }

%>
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
        <section class="min-h-screen font-lato bg-gray-50">
            <jsp:include page="../components/header.jsp"/>
            <div class="flex items-start max-w-screen-2xl mx-auto pt-40 pb-10 min-h-[40rem] gap-x-8">
                <!-- Sidebar Tabs -->
                <div class="w-[15rem] text-lg font-semibold bg-white rounded-lg shadow p-4">
                    <ul>
                        <li id="yourRequestTab" class="px-4 py-3 rounded cursor-pointer mb-2 transition-all duration-300 ease-in-out bg-primary/40 hover:bg-primary/40"
                            onclick="showSection('yourRequests')">Your Requests</li>
                        <li id="borrowRequestTab" class="px-4 py-3 rounded cursor-pointer transition-all duration-300 ease-in-out hover:bg-primary/40"
                            onclick="showSection('borrowRequests')">Borrow Requests</li>
                    </ul>
                </div>

                <!-- Request Sections -->
                <div class="flex flex-col gap-y-8 w-full">
                    <!-- Your Requests Section -->
                    <div id="yourRequests" class="space-y-6">
                        <% if (user != null && ownBRList.size() != 0) {
                                for (SelectedProduct product : ownBRList) {
                                    String status = product.getStatus();
                        %>
                        <form name="BorrowerActionServlet" action="/BorrowerActionServlet?type=<%=status%>&product_id=<%=product.getProduct().getId()%>&request_id=<%=product.getRequestId()%>" method="POST" class="flex items-center gap-x-6 p-3 bg-white shadow-md rounded-lg transition duration-200 hover:shadow-lg">
                            <!-- Product Image -->
                            <div class="w-24 h-24 rounded-lg overflow-hidden">
                                <img src="../"<%=product.getProduct().getImageUrl()[0]%>" alt="Product Image" class="w-full h-full object-cover"/>
                            </div>

                            <!-- Product Details -->
                            <div class="flex-grow">
                                <div class="text-lg text-gray-800"><span class="font-semibold"><%=product.getProduct().getName()%></span> (<%=product.getProduct().getSpec()%>)</div>
                                <div class="text-gray-500 mt-1">Rs. <%=product.getSelectedPrice()%>/month | Offered: Rs. <%=product.getOfferedPrice()%>/month | For <%=product.getSelectedTenure()%> months</div>
                            </div>

                            <!-- Request Status -->
                            <span class="w-1/7 text-center px-3 py-1 rounded font-semibold text-sm <%=(product.getStatus().equals("pending") ? "bg-yellow-100 text-yellow-600" : product.getStatus().equals("accepted") ? "bg-green-100 text-green-600" : "bg-red-100 text-red-600")%>">
                                <%=product.getStatus().substring(0, 1).toUpperCase() + product.getStatus().substring(1)%>
                            </span>

                            <!-- Date -->
                            <div class="text-sm text-gray-400"><%= DateFormatter.getRelativeDate(product.getDate())%></div>

                            <!-- Action Button -->
                            <% if (product.getStatus().equals("pending")) {%>
                            <button type="button" class="cancel-btn bg-red-500 text-white px-6 py-1.5 rounded-full hover:bg-red-600 transition duration-300" onclick="openCancelModal(<%=product.getRequestId()%>,<%=product.getProduct().getId()%>, '<%=status%>', this)">
                                Cancel
                            </button>
                            <% } else if (product.getStatus().equals("accepted")) {%>
                            <a href="userDashboard.jsp?page=rentalDetail&requestId=<%=product.getRequestId()%>" class="bg-green-500 hover:bg-green-600 px-6 py-1.5 text-white rounded-full transition duration-300">
                                View
                            </a>
                            <% } else {%>
                            <button type="button" class="bg-primary hover:bg-primary-100 px-6 py-1.5 text-white rounded-full transition duration-300">
                                Request again
                            </button>
                            <%}%>
                        </form>
                        <% }
                        } else { %>
                        <p class="text-center text-gray-500">No requests found.</p>
                        <% } %>
                        <!-- Modal for Confirmation -->
                        <div id="cancelModal" class="fixed inset-0 bg-black/50 z-50 hidden flex justify-center items-center">
                            <div class="bg-white p-6 rounded-lg shadow-lg max-w-sm w-full">
                                <div class="text-lg text-center text-gray-800">Are you sure you want to cancel this request?</div>
                                <div class="flex justify-between mt-4">
                                    <button onclick="closeCancelModal()" class="bg-gray-300 text-gray-800 px-6 py-1.5 rounded-full hover:bg-gray-400">Cancel</button>
                                    <form id="cancelForm" method="POST" action="" class="flex">
                                        <button type="submit" class="bg-red-500 text-white px-6 py-1.5 rounded-full hover:bg-red-600">Confirm</button>
                                        <input type="hidden" name="requestId" id="requestId">
                                        <input type="hidden" name="productId" id="productId">
                                        <input type="hidden" name="status" id="status">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Borrow Requests Section -->
                    <div id="borrowRequests" class="space-y-6 hidden">
                        <% if (user != null && BRList.size() != 0) {
                                for (SelectedProduct product : BRList) {
                        %>
                        <div class="flex items-center gap-x-6 p-5 bg-white shadow-md rounded-lg transition duration-200 hover:shadow-lg">
                            <!-- Product Image -->
                            <div class="w-20 h-20 rounded-lg overflow-hidden">
                                <img src="../<%=product.getProduct().getImageUrl()[0]%>" alt="Product Image" class="w-full h-full object-cover"/>
                            </div>

                            <!-- Product Details -->
                            <div class="flex-grow">
                                <div class="text-lg text-gray-800"><span class="font-semibold"><%=product.getProduct().getName()%></span> (<%=product.getProduct().getSpec()%>)</div>
                                <div class="text-gray-500 mt-1">Offered Price: Rs. <%=product.getOfferedPrice()%>/month | For <%=product.getSelectedTenure()%> months</div>
                            </div>

                            <!--Message section-->
                            <div class="text-sm text-gray-400 truncate">Message: <%=product.getMessage()%></div>

                            <!-- Date -->
                            <div class="text-sm text-gray-400"><%= DateFormatter.getRelativeDate(product.getDate())%></div>

                            <!-- Action Buttons -->
                            <div class="flex gap-3">
                                <% if (product.getStatus().equals("accepted")) {%>
                                <!-- Request Status -->
                                <span class="flex items-center w-1/7 text-center px-3 py-1 rounded font-semibold text-sm <%=(product.getStatus().equals("pending") ? "bg-yellow-100 text-yellow-600" : product.getStatus().equals("accepted") ? "bg-green-100 text-green-600" : "bg-red-100 text-red-600")%>">
                                    <%=product.getStatus().substring(0, 1).toUpperCase() + product.getStatus().substring(1)%>
                                </span>
                                <a href="userDashboard.jsp?page=rentalDetail&requestId=<%=product.getRequestId()%>" class="bg-green-500 hover:bg-green-600 px-6 py-1.5 text-white rounded-full transition duration-300">
                                    View
                                </a>
                                <%} else {%>
                                <button name="accept" value="accept" class="bg-green-600 text-white px-6 py-1.5 rounded-full hover:bg-green-700 transition duration-300" onclick="openLenderReplyModal(<%=product.getRequestId()%>,<%=product.getProduct().getId()%>, this)">Accept</button>
                                <button name="reject" value="reject" class="bg-red-500 text-white px-6 py-1.5 rounded-full hover:bg-red-600 transition duration-300" onclick="openLenderReplyModal(<%=product.getRequestId()%>,<%=product.getProduct().getId()%>, this)">Reject</button>
                                <%}%>
                            </div>
                        </div>
                        <% }
                        } else { %>
                        <p class="text-center text-gray-500">No borrow requests found.</p>
                        <% }%>
                        <!-- Modal for reject/accept Confirmation -->
                        <div id="lenderReplyModal" class="fixed inset-0 bg-black/50 z-50 hidden flex justify-center items-center">
                            <div class="bg-white p-6 rounded-lg shadow-lg max-w-sm w-full">
                                <div class="text-lg text-center text-gray-800">Are you sure ?</div>
                                <div class="flex justify-between mt-4">
                                    <button onclick="closeLenderReplyModal()" class="bg-gray-300 text-gray-800 px-6 py-1.5 rounded-full hover:bg-gray-400">Cancel</button>
                                    <form id="replyForm" method="POST" action="" class="flex">
                                        <button type="submit" class="text-white px-6 py-1.5 rounded-full"></button>
                                        <input type="hidden" name="requestId" id="requestId">
                                        <input type="hidden" name="productId" id="productId">
                                        <input type="hidden" name="type" id="type">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../components/footer.jsp"/>
        </section>
        <script>
                    //TOGGLE BETWEEN REQUEST SECTIONS
                            function showSection(sectionId) {
                            const yourRequests = document.getElementById('yourRequests');
                                    const borrowRequests = document.getElementById('borrowRequests');
                                    document.getElementById('yourRequestTab').classList.toggle('bg-primary/40', sectionId === 'yourRequests');
                                    document.getElementById('borrowRequestTab').classList.toggle('bg-primary/40', sectionId === 'borrowRequests');
                                    yourRequests.classList.toggle('hidden', sectionId !== 'yourRequests');
                                    borrowRequests.classList.toggle('hidden', sectionId !== 'borrowRequests');
                            }

                    // Open the CANCEL REQUEST MODAL and set form values
                    function openCancelModal(requestId, productId, status, button) {
                    // Show the modal
                    document.getElementById("cancelModal").classList.remove("hidden");
                            // Set the action and form values dynamically
                            document.getElementById("cancelForm").action = "/BorrowerActionServlet?type=" + status + "&request_id=" + requestId + "&product_id=" + productId;
                            document.getElementById("requestId").value = requestId;
                            document.getElementById("productId").value = productId;
                            document.getElementById("status").value = status;
                            // Optionally, you can pass the button text to dynamically change it
                            document.getElementById("cancelForm").querySelector('button').innerText = "Confirm Cancellation";
                    }

                    // Close the CANCEL REQUEST MODAL
                    function closeCancelModal() {
                    document.getElementById("cancelModal").classList.add("hidden");
                    }

                    // Open the REJECT/ACCEPT MODAL and set form values
                    function openLenderReplyModal(requestId, productId, button) {
                    // Show the modal
                    document.getElementById("lenderReplyModal").classList.remove("hidden");
                            //set buttonType
                            // Get the button's name or value
                            const buttonType = button.getAttribute("name") || button.getAttribute("value");
                            console.log(buttonType);
                            // Set the action and form values dynamically
                            document.getElementById("replyForm").action = "/LenderReplyServlet?type=" + buttonType + "&request_id=" + requestId + "&product_id=" + productId;
                            document.getElementById("requestId").value = requestId;
                            document.getElementById("productId").value = productId;
                            document.getElementById("type").value = buttonType;
                            // Optionally, you can pass the button text to dynamically change it
                            document.getElementById("replyForm").querySelector('button').innerText = buttonType.toString().toUpperCase();
                            if (buttonType.toString() === 'accept'){
                    document.getElementById("replyForm").querySelector('button').classList.remove("bg-red-500")
                            document.getElementById("replyForm").querySelector('button').classList.add("bg-green-500")
                    } else{
                    document.getElementById("replyForm").querySelector('button').classList.remove("bg-green-500");
                            document.getElementById("replyForm").querySelector('button').classList.add("bg-red-500");
                    };
                    }

                    // Close the REJECT/ACCEPT MODAL
                    function closeLenderReplyModal() {
                    document.getElementById("lenderReplyModal").classList.add("hidden");
                    }
        </script>
    </body>
</html>

