<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>


<%
    // Check if the session attribute "email" exists
    String userEmail = (String) session.getAttribute("email");

    // Redirect to login if not logged in
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get job_id from request
   String jobId = request.getParameter("jobId");
if (jobId == null || jobId.isEmpty()) {
    out.println("Job ID is missing");
    return;
}

    // PostgreSQL Database Connection
    String jdbcURL = "jdbc:postgresql://localhost:5432/Job"; // Change if your DB is hosted elsewhere
    String dbUser = "postgres"; // Your PostgreSQL username
    String dbPass = "prashant"; // Your PostgreSQL password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String jobTitle = "", company = "", location = "", salary = "", jobType = "", description = "", image = "", postDate = "", dueDate = "";

    try {
        Class.forName("org.postgresql.Driver"); // Load PostgreSQL Driver
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

        String sql = "SELECT job_title, company, location, salary, job_type, description, image, post_date, due_date FROM jobs WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(jobId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            jobTitle = rs.getString("job_title");
            company = rs.getString("company");
            location = rs.getString("location");
            salary = rs.getString("salary");
            jobType = rs.getString("job_type");
            description = rs.getString("description");
            image = rs.getString("image");
            postDate = rs.getString("post_date");
            dueDate = rs.getString("due_date");
        } else {
            response.sendRedirect("Job.jsp"); // Redirect if job is not found
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Details</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <!-- Header -->
    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-[calc(100vh-80px)]">

        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Job Details Section -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <div class="bg-white w-11/12 p-8 border border-gray-300 rounded-lg shadow-lg">

                <!-- Job Header -->
                <div class="flex justify-between items-center mb-6">
                    <div class="flex items-center space-x-4">
                        <img src="<%= request.getContextPath() %>/<%= image %>" alt="Company Logo" class="w-20 h-20 object-cover rounded-full border border-gray-300">
                        <div>
                            <h2 class="text-2xl font-bold text-gray-800"><%= jobTitle %></h2>
                            <p class="text-gray-500"><%= company %> - <%= location %></p>
                        </div>
                    </div>
                </div>

                <!-- Job Details -->
                <div class="text-gray-600 space-y-3">
                    <p><strong>Salary:</strong> <%= salary %></p>
                    <p><strong>Job Type:</strong> <%= jobType %></p>
                    <p><strong>Posted on:</strong> <%= postDate %></p>
                    <p><strong>Application Deadline:</strong> <%= dueDate %></p>
                </div>

                <!-- Job Description -->
                <h3 class="text-xl font-semibold text-gray-700 mt-6 mb-3">Job Description</h3>
                <p class="text-gray-600 leading-relaxed"><%= description %></p>

                <!-- Apply Button -->
                <div class="mt-8 flex justify-center">
                    <a href="ApplyJob.jsp?jobId=<%= jobId %>" class="bg-blue-600 text-white px-6 py-3 rounded-lg text-lg font-medium shadow-md hover:bg-blue-700 transition">
                        Apply Now
                    </a>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
