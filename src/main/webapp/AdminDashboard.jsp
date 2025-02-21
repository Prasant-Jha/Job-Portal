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
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100">
    
    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-[calc(100vh-80px)]">
        <%@ include file="Sidebar.jsp" %>

        <!-- Main Dashboard Section -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <h2 class="text-3xl font-bold text-gray-800">Admin Dashboard</h2>

            <!-- Statistics Cards -->
            <div class="grid grid-cols-3 gap-6 w-full">
                <div class="bg-purple-500 p-6 text-white rounded-xl shadow-lg text-center">
                    <h2 class="text-lg font-semibold">Users</h2>
                    <p class="text-3xl font-bold">562</p>
                </div>
                <div class="bg-green-500 p-6 text-white rounded-xl shadow-lg text-center">
                    <h2 class="text-lg font-semibold">Job Posts</h2>
                    <p class="text-3xl font-bold">1,200</p>
                </div>
                <div class="bg-blue-500 p-6 text-white rounded-xl shadow-lg text-center">
                    <h2 class="text-lg font-semibold">Applications</h2>
                    <p class="text-3xl font-bold">7,514</p>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="grid grid-cols-2 gap-6 w-full">
                <div class="bg-white p-6 rounded-xl shadow-lg w-full">
                    <h3 class="text-xl font-semibold mb-4">User Growth</h3>
                    <canvas id="userGrowthChart"></canvas>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-lg w-full">
                    <h3 class="text-xl font-semibold mb-4">Applications Over Time</h3>
                    <canvas id="applicationsChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script>
        // User Growth Chart
        const userGrowthCtx = document.getElementById('userGrowthChart').getContext('2d');
        new Chart(userGrowthCtx, {
            type: 'line',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                datasets: [{
                    label: "Users",
                    data: [10, 20, 30, 40, 50, 60],
                    borderColor: "#6b46c1",
                    backgroundColor: "rgba(107, 70, 193, 0.2)",
                    fill: true,
                }]
            }
        });

        // Applications Over Time Chart
        const applicationsCtx = document.getElementById('applicationsChart').getContext('2d');
        new Chart(applicationsCtx, {
            type: 'line',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                datasets: [{
                    label: "Applications",
                    data: [5, 15, 25, 35, 45, 55],
                    borderColor: "#3182ce",
                    backgroundColor: "rgba(49, 130, 206, 0.2)",
                    fill: true,
                }]
            }
        });
    </script>
</body>
</html>
