<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<%
    // Check if the user is logged in
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String searchQuery = request.getParameter("search");
    
    // Database Connection
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        // ✅ Establish Connection to PostgreSQL
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Job", "postgres", "prashant");
        
        String sql;
        
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
        	sql = "SELECT * FROM jobs";
            pst = conn.prepareStatement(sql);
        } else {
        	 // ✅ Prepare Query (Case-Insensitive Search)
            sql = "SELECT * FROM jobs WHERE job_title ILIKE ? OR description ILIKE ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, "%" + searchQuery + "%");
            pst.setString(2, "%" + searchQuery + "%");
        }

        rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <!-- Header Section -->
    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-[calc(100vh-80px)]">
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Job Listings -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-5 space-y-6">
            <%
            boolean found = false;
            while (rs.next()) { 
                found = true;
            %>
                <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                    <div class="text-lg font-semibold"><%= rs.getString("job_title") %></div>
                    <div class="text-gray-600 text-sm"><%= rs.getString("company") %></div>
                    <div class="text-gray-500 text-sm mb-3"><%= rs.getString("location") %></div>
                    <a href="JobDetailsPage.jsp?jobId=<%= rs.getInt("id") %>" 
                       class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">
                        View details
                    </a>
                </div>
            <% } %>

            <!-- No results message -->
            <% if (!found) { %>
                <div class="text-gray-600 text-lg font-semibold">
                    No jobs found for "<%= searchQuery %>".
                </div>
            <% } %>

        </div>
    </div>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>
