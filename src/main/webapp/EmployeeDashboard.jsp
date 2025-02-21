<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>

<%
    // Check if the session attribute "role" exists
    String userEmail = (String) session.getAttribute("email");

    // If the user is not logged in, redirect to the login page
    if (userEmail == null) {
        response.sendRedirect("Login.jsp"); // Change "login.jsp" to your actual login page
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">
    
    <%-- Header Section --%>
    <jsp:include page="Header.jsp" />

    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <%-- Sidebar --%>
        <jsp:include page="Sidebar.jsp" />
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <h2 class="text-2xl font-bold text-gray-800">Your Applications</h2>
            
            <%-- Static Applications --%>
            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Job ID:</strong> 101</p>
                <p class="text-gray-700"><strong>Resume:</strong> resume_101.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-blue-600">Pending</span></p>
            </div>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Job ID:</strong> 102</p>
                <p class="text-gray-700"><strong>Resume:</strong> resume_102.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-green-600">Accepted</span></p>
            </div>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Job ID:</strong> 103</p>
                <p class="text-gray-700"><strong>Resume:</strong> resume_103.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-red-600">Rejected</span></p>
            </div>

        </div>
    </div>

</body>
</html>
