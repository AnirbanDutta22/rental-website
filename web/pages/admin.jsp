
<%@page import="java.sql.DriverManager"%>
<%@page import="oracle.jdbc.OracleResultSetMetaData"%>
<%@page import="oracle.jdbc.OracleResultSet"%>
<%@page import="oracle.jdbc.OraclePreparedStatement"%>
<%@page import="oracle.jdbc.OracleConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    /* Hide all sections */
    .section {
      display: none;
    }
    /* Show the active section */
    .active {
      display: block;
    }
  </style>
</head>

<body class="bg-gray-100">
    
    
    
    <%!
    // Declare objects and variables for database
    OracleConnection oconn;
    OraclePreparedStatement ops;
    OracleResultSet ors;
    OracleResultSetMetaData orsmd;
    int counter;
    int rowCount;
    String query;
    
    
    // Method to execute query and fetch data
    void fetchData(String tableName) {
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@Ami-Anirban:1522:orcl", "minor", "project");
            query = "SELECT * FROM " + tableName;
            ops = (OraclePreparedStatement) oconn.prepareStatement(query);
            ors = (OracleResultSet) ops.executeQuery();
            orsmd = (OracleResultSetMetaData) ors.getMetaData();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    void fetchRowCount(String tableName){
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@Ami-Anirban:1522:orcl", "minor", "project");
            query = "SELECT COUNT(*) FROM " + tableName;
            ops = (OraclePreparedStatement) oconn.prepareStatement(query);
            ors = (OracleResultSet) ops.executeQuery();
//            orsmd = (OracleResultSetMetaData) ors.getMetaData();
            if (ors.next()) {
            rowCount = ors.getInt(1); // Store the row count in rowCount variable
        }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>


  <!-- Top Navbar -->
  <nav class="bg-gray-800 text-white py-4 px-6 flex justify-between items-center">
    <div class="text-lg font-bold">
      <a href="#" class="hover:text-yellow-500">RentalAdmin</a>
    </div>
    <ul class="flex space-x-4">
      <li><a href="#" class="hover:text-yellow-500">Dashboard</a></li>
      <li><a href="#" class="hover:text-yellow-500">Profile</a></li>
      <li><a href="#" class="hover:text-yellow-500">Logout</a></li>
    </ul>
  </nav>

  <!-- Sidebar and Main Content Wrapper -->
  <div class="flex">
    
    <!-- Sidebar -->
    <div class="w-64 bg-gray-800 text-white h-screen p-6">
      <h2 class="text-2xl font-semibold mb-8">Admin Panel</h2>
      <ul>
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('dashboard')">Dashboard</a>
        </li>
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('manage-users')">Manage Users</a>
        </li>
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('manage-products')">Manage Products</a>
        </li>
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('manage-disputes')">Manage Disputes</a>
        </li>
<!--        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('database-overview')">Database Overview</a>
        </li>-->
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('database-overview')">Settings</a>
        </li>
        <li class="mb-4">
          <a href="#" class="hover:bg-gray-700 block px-4 py-2 rounded" onclick="showSection('database-overview')">Logout</a>
        </li>
      </ul>
    </div>

    <!-- Main part -->
    <div class="flex-1 p-6">
      <!-- Dashboard Overview -->
      <section id="dashboard" class="section active">
        <h2 class="text-2xl font-semibold mb-6">Dashboard Overview</h2>
        <div class="grid grid-cols-3 gap-6">
          <div class="bg-blue-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Total Users</h3>
            <p class="text-3xl mt-4">1200</p>
          </div>
          <div class="bg-green-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Total Products</h3>
            <p class="text-3xl mt-4">300</p>
          </div>
          <div class="bg-yellow-500 text-white p-6 rounded-lg shadow-lg text-center">
            <h3 class="text-xl font-bold">Active Rentals</h3>
            <p class="text-3xl mt-4">50</p>
          </div>
        </div>
        
        <div class="mt-16">
        <h2 class="text-2xl font-semibold mb-6">Database Overview</h2>
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
          <thead>
            <tr class="bg-gray-800 text-white">
              <th class="py-2 px-4">Table Name</th>
              <th class="py-2 px-4">Records</th>
              <th class="py-2 px-4">Last Updated</th>
              <th class="py-2 px-4">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr class="border-t">
               <% 
                    fetchRowCount("USER1");
                %>
              <td class="py-2 px-4 text-center">Users</td>
              <td class="py-2 px-4 text-center"><%= rowCount %></td>
              <td class="py-2 px-4 text-center">25/09/2024</td>
              <td class="py-2 px-4 text-center">
              <a href="#" onclick="showSection('manage-users')"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a> 
              </td>
            </tr>
            <tr class="border-t">
                <% 
                    fetchRowCount("ITEM");
                %>
              <td class="py-2 px-4 text-center">Products</td>
              <td class="py-2 px-4 text-center"><%= rowCount %></td>
              <td class="py-2 px-4 text-center">24/09/2024</td>
               <td class="py-2 px-4 text-center">
              <a href="#" onclick="showSection('manage-products')"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a> 
              </td>
            </tr>
            <tr class="border-t">
                <% 
                    fetchRowCount("DISPUTE");
                %>
              <td class="py-2 px-4 text-center">Disputes</td>
              <td class="py-2 px-4 text-center"><%= rowCount %></td>
              <td class="py-2 px-4 text-center">24/09/2024</td>
               <td class="py-2 px-4 text-center">
              <a href="#" onclick="showSection('manage-disputes')"><button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">view</button></a> 
              </td>
            </tr>
          </tbody>
        </table>
        </div>
      </section>

      <!-- Manage Users  -->
      <section id="manage-users" class="section">
        <h2 class="text-2xl font-semibold mb-6">Manage Users</h2>
        <button class="mb-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">+ Add New User</button>
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
          <thead>           
             <tr class="bg-gray-800 text-white">
                    <%
                        //  BRINGING THE TABLE HEADINGS
                        fetchData("user1");
                        
                        for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <th class="py-2 px-4"><%=orsmd.getColumnName(counter)%></th>
                        <%
                            }
                        %>
                     <th class="py-2 px-4">ACTION</th>
                </tr>
          </thead>
          <tbody>
            <%
                    //  BRINGING ALL THE RECORDS AND DISPLAYING AS TABLE ROWS
                    while(ors.next() == true)
                    {
                    %>
                <tr class="border-t">
                    <%
                       for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <td class="py-2 px-4 text-center"><%=ors.getString(counter)%></td>
                        <%
                            }
                        %>
                    <td class="py-2 px-4 text-center">
                        <button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
                        <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Delete</button>
                    </td>
                </tr>
                <%
                    }
                    %>
                
          </tbody>
        </table>
      </section>

      <!-- Manage Products  -->
      <section id="manage-products" class="section">
        <h2 class="text-2xl font-semibold mb-6">Manage Products</h2>
        <button class="mb-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">+ Add New Product</button>
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
          <thead>           
             <tr class="bg-gray-800 text-white">
                    <%
                        //  BRINGING THE TABLE HEADINGS
                        fetchData("item");
                        for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <th class="py-2 px-4"><%=orsmd.getColumnName(counter)%></th>
                        <%
                            }
                        %>
                     <th class="py-2 px-4">ACTION</th>
                </tr>
          </thead>
          <tbody>
            <%
                    //  BRINGING ALL THE RECORDS AND DISPLAYING AS TABLE ROWS
                    while(ors.next() == true)
                    {
                    %>
                <tr class="border-t">
                    <%
                       for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <td class="py-2 px-4 text-center"><%=ors.getString(counter)%></td>
                        <%
                            }
                        %>
                    <td class="py-2 px-4 text-center">
                        <button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
                        <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Delete</button>
                    </td>
                </tr>
                <%
                    }
                    %>
                
          </tbody>
        </table>
      </section>
      <!-- Manage disputes  -->
      <section id="manage-disputes" class="section">
        <h2 class="text-2xl font-semibold mb-6">Manage Disputes</h2>
        <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
          <thead>           
             <tr class="bg-gray-800 text-white">
                    <%
                        //  BRINGING THE TABLE HEADINGS
                        fetchData("dispute");
                        for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <th class="py-2 px-4"><%=orsmd.getColumnName(counter)%></th>
                        <%
                            }
                        %>
                     <th class="py-2 px-4">ACTION</th>
                </tr>
          </thead>
          <tbody>
            <%
                    //  BRINGING ALL THE RECORDS AND DISPLAYING AS TABLE ROWS
                    while(ors.next() == true)
                    {
                    %>
                <tr class="border-t">
                    <%
                       for(counter = 1; counter <= orsmd.getColumnCount(); counter ++)
                        {
                        %>
                        <td class="py-2 px-4 text-center"><%=ors.getString(counter)%></td>
                        <%
                            }
                        %>
                    <td class="py-2 px-4 text-center">
                        <button class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
                        <button class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600">Delete</button>
                    </td>
                </tr>
                <%
                    }
                    %>
                
          </tbody>
        </table>
      </section>

      <!-- Database Overview -->
<section id="database-overview" class="section">
    
  </section>
    </div>
  </div>

  <!-- JavaScript for handling section visibility -->
  <script>
    function showSection(sectionId) {
      document.querySelectorAll('.section').forEach(section => section.classList.remove('active'));
      document.getElementById(sectionId).classList.add('active');
    }
  </script>

</body>
</html>

