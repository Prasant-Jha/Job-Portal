<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    // Ensure user is logged in
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Database connection variables
    String dbURL = "jdbc:postgresql://localhost:5432/Job";
    String dbUser = "postgres";
    String dbPassword = "prashant";
    
    Connection conn = null;
    int userCount = 0, jobPostsCount = 0, applicationsCount = 0;
    List<Integer> userGrowthData = new ArrayList<>();
    List<Integer> applicationsData = new ArrayList<>();

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch User Count
        String userQuery = "SELECT COUNT(*) FROM users";
        try (PreparedStatement stmt = conn.prepareStatement(userQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                userCount = rs.getInt(1);
            }
        }

        // Fetch Job Posts Count
        String jobQuery = "SELECT COUNT(*) FROM jobs";
        try (PreparedStatement stmt = conn.prepareStatement(jobQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                jobPostsCount = rs.getInt(1);
            }
        }

        // Fetch Applications Count
        String applicationQuery = "SELECT COUNT(*) FROM application";
        try (PreparedStatement stmt = conn.prepareStatement(applicationQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                applicationsCount = rs.getInt(1);
            }
        }

        // Fetch Monthly User Growth Data (Last 6 Months)
        String userGrowthQuery = "SELECT COUNT(*) FROM users WHERE created_at >= date_trunc('month', current_date) - interval '6 months' GROUP BY date_trunc('month', created_at) ORDER BY date_trunc('month', created_at)";
        try (PreparedStatement stmt = conn.prepareStatement(userGrowthQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                userGrowthData.add(rs.getInt(1));
            }
        }

        // Fetch Monthly Applications Data (Last 6 Months)
        String applicationsQuery = "SELECT COUNT(*) FROM applications WHERE created_at >= date_trunc('month', current_date) - interval '6 months' GROUP BY date_trunc('month', created_at) ORDER BY date_trunc('month', created_at)";
        try (PreparedStatement stmt = conn.prepareStatement(applicationsQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                applicationsData.add(rs.getInt(1));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
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
                    <p class="text-3xl font-bold"><%= userCount %></p>
                </div>
                <div class="bg-green-500 p-6 text-white rounded-xl shadow-lg text-center">
                    <h2 class="text-lg font-semibold">Job Posts</h2>
                    <p class="text-3xl font-bold"><%= jobPostsCount %></p>
                </div>
                <div class="bg-blue-500 p-6 text-white rounded-xl shadow-lg text-center">
                    <h2 class="text-lg font-semibold">Applications</h2>
                    <p class="text-3xl font-bold"><%= applicationsCount %></p>
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
                    data: <%= userGrowthData %>,
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
                    data: <%= applicationsData %>,
                    borderColor: "#3182ce",
                    backgroundColor: "rgba(49, 130, 206, 0.2)",
                    fill: true,
                }]
            }
        });
    </script>
</body>
</html>
