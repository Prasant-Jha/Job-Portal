<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.sql.*" %>

<%
    // Check if the session attribute "email" exists
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get job ID from request parameter and validate
    String jobId = request.getParameter("id");
    int jobIdInt = -1; // Default invalid value

    try {
        if (jobId != null && !jobId.trim().isEmpty()) {
            jobIdInt = Integer.parseInt(jobId);
        } else {
            response.sendRedirect("EmployerDashboard.jsp");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("EmployerDashboard.jsp");
        return;
    }

    // Database connection details
    String DB_URL = "jdbc:postgresql://localhost:5432/Job";
    String DB_USER = "postgres";
    String DB_PASSWORD = "prashant";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    String jobTitle = "", company = "", location = "", salary = "", jobType = "", description = "", image = "", dueDate = "";
    
    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        
        String sql = "SELECT * FROM jobs WHERE id = ? AND employer_email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, jobIdInt);
        stmt.setString(2, userEmail);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            jobTitle = rs.getString("job_title");
            company = rs.getString("company");
            location = rs.getString("location");
            salary = rs.getString("salary");
            jobType = rs.getString("job_type");
            description = rs.getString("description");
            image = rs.getString("image");
            dueDate = rs.getString("due_date");
        } else {
            response.sendRedirect("EmployerDashboard.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources properly
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Job</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <%@ include file="Header.jsp" %>
    <div class="flex w-full h-[calc(100vh-80px)]">
        <%@ include file="Sidebar.jsp" %>
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <div class="w-full bg-white p-8 border border-gray-300 rounded-lg shadow-lg">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Update Job</h2>
                
                <form id="jobForm" action="UpdateJobServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="jobId" value="<%= jobIdInt %>">
                    <input type="hidden" name="employerEmail" value="<%= userEmail %>">

                    <label for="jobTitle" class="block font-semibold text-gray-700">Job Title*</label>
                    <input type="text" id="jobTitle" name="jobTitle" value="<%= jobTitle %>" required class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <label for="company" class="block font-semibold text-gray-700">Company Name*</label>
                    <input type="text" id="company" name="company" value="<%= company %>" required class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <label for="location" class="block font-semibold text-gray-700">Location*</label>
                    <input type="text" id="location" name="location" value="<%= location %>" required class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <label for="salary" class="block font-semibold text-gray-700">Salary</label>
                    <input type="text" id="salary" name="salary" value="<%= salary %>" class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <label for="jobType" class="block font-semibold text-gray-700">Job Type</label>
                    <select id="jobType" name="jobType" class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                        <option value="Full-time" <%= jobType.equals("Full-time") ? "selected" : "" %>>Full-time</option>
                        <option value="Part-time" <%= jobType.equals("Part-time") ? "selected" : "" %>>Part-time</option>
                        <option value="Contract" <%= jobType.equals("Contract") ? "selected" : "" %>>Contract</option>
                        <option value="Internship" <%= jobType.equals("Internship") ? "selected" : "" %>>Internship</option>
                    </select>
                    
                    <label for="description" class="block font-semibold text-gray-700">Job Description*</label>
                    <textarea id="description" name="description" required class="w-full p-3 border border-gray-300 rounded-lg mb-4"><%= description %></textarea>
                    
                    <label for="image" class="block font-semibold text-gray-700">Update Image (Optional)</label>
                    <input type="file" id="image" name="image" class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <label for="dueDate" class="block font-semibold text-gray-700">Due Date*</label>
                    <input type="date" id="dueDate" name="dueDate" value="<%= dueDate %>" required class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>
                    
                    <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700 transition">
                        Update Job
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
