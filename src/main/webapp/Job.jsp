<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("Login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add your CSS file -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <!-- Header Section -->
    <%@ include file="Header.jsp" %>

    <!-- Hero Section -->
    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Job Posts Section -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-5 space-y-6">

            <!-- Static Job Listings -->
            <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                <div class="text-lg font-semibold">Frontend Developer</div>
                <div class="text-gray-600 text-sm">Google</div>
                <div class="text-gray-500 text-sm mb-3">California, USA</div>
                <a href="JobDetailsPage.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                    View details
                </a>
            </div>

            <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                <div class="text-lg font-semibold">Backend Developer</div>
                <div class="text-gray-600 text-sm">Microsoft</div>
                <div class="text-gray-500 text-sm mb-3">Redmond, USA</div>
                <a href="JobDetailsPage.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                    View details
                </a>
            </div>

            <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                <div class="text-lg font-semibold">UI/UX Designer</div>
                <div class="text-gray-600 text-sm">Apple</div>
                <div class="text-gray-500 text-sm mb-3">Cupertino, USA</div>
                <a href="JobDetailsPage.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                    View details
                </a>
            </div>

            <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                <div class="text-lg font-semibold">Software Engineer</div>
                <div class="text-gray-600 text-sm">Amazon</div>
                <div class="text-gray-500 text-sm mb-3">Seattle, USA</div>
                <a href="JobDetailsPage.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                    View details
                </a>
            </div>

            <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                <div class="text-lg font-semibold">Data Scientist</div>
                <div class="text-gray-600 text-sm">Facebook</div>
                <div class="text-gray-500 text-sm mb-3">Menlo Park, USA</div>
                <a href="JobDetailsPage.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                    View details
                </a>
            </div>

        </div>
    </div>

</body>
</html>
