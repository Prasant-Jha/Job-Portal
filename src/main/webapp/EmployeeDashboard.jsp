<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Ensure user is logged in
    String userEmail = (String) session.getAttribute("email");
    Integer userId = (Integer) session.getAttribute("userId");

    if (userEmail == null || userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // PostgreSQL Database connection parameters
    String dbURL = "jdbc:postgresql://localhost:5432/Job";
    String dbUser = "postgres";
    String dbPass = "prashant";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Map<String, String>> applications = new ArrayList<>();

    try {
        // Load PostgreSQL Driver
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        
        // Query to fetch applications for the logged-in user
        String sql = "SELECT job_id, resume_path, status FROM application WHERE user_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> appData = new HashMap<>();
            appData.put("jobId", rs.getString("job_id"));
            appData.put("resume", rs.getString("resume_path"));
            appData.put("status", rs.getString("status"));
            applications.add(appData);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
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
            
            <%-- Display dynamic applications --%>
            <% if (applications.isEmpty()) { %>
                <p class="text-gray-600">You have not applied for any jobs yet.</p>
            <% } else { %>
                <% for (Map<String, String> app : applications) { %>
                    <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                        <p class="text-gray-700"><strong>Job ID:</strong> <%= app.get("jobId") %></p>
                        <p class="text-gray-700"><strong>Resume:</strong> <%= app.get("resume") %></p>
                        <p class="text-gray-700"><strong>Status:</strong>
                            <% if ("Pending".equalsIgnoreCase(app.get("status"))) { %>
                                <span class="text-blue-600">Pending</span>
                            <% } else if ("Accepted".equalsIgnoreCase(app.get("status"))) { %>
                                <span class="text-green-600">Accepted</span>
                            <% } else { %>
                                <span class="text-red-600">Rejected</span>
                            <% } %>
                        </p>
                    </div>
                <% } %>
            <% } %>

        </div>
    </div>

</body>
</html>
