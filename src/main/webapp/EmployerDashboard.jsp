<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Check if the session attribute "email" exists
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="w-full min-h-screen">
        <%-- Header Section --%>
        <jsp:include page="Header.jsp" />
        
        <div class="flex w-full h-[calc(100vh-80px)]">
            <%-- Sidebar --%>
            <jsp:include page="Sidebar.jsp" />
            
            <%-- Job Posts Table Section --%>
            <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
                <h2 class="text-3xl font-bold text-gray-800">Manage Job Posts</h2>
                <div class="w-full bg-white p-6 rounded-xl shadow-lg">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="p-3 text-left">Image</th>
                                <th class="p-3 text-left">Job Title</th>
                                <th class="p-3 text-left">Company</th>
                                <th class="p-3 text-left">Location</th>
                                <th class="p-3 text-left">Salary</th>
                                <th class="p-3 text-left">Job Type</th>
                                <th class="p-3 text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Job", "postgres", "prashant");
            String sql = "SELECT * FROM jobs WHERE employer_email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) { // No data found
    %>
    <tr>
        <td colspan="7" class="text-center p-4 text-gray-600">No job posts found.</td>
    </tr>
    <%
            } else {
                while (rs.next()) {
    %>
    <tr class="border-b">
        <td class="p-3"><img src="<%= rs.getString("image") %>" alt="Job" class="w-10 h-10 rounded-full" /></td>
        <td class="p-3"><%= rs.getString("job_title") %></td>
        <td class="p-3"><%= rs.getString("company") %></td>
        <td class="p-3"><%= rs.getString("location") %></td>
        <td class="p-3"><%= rs.getString("salary") %></td>
        <td class="p-3"><%= rs.getString("job_type") %></td>
        <td class="p-3 text-center">
            <a href="UpdatePost.jsp?id=<%= rs.getInt("id") %>" class="text-blue-600 hover:text-blue-800">
                &#9998; <!-- Edit Icon -->
            </a>
            <form action="JobDelete.jsp" method="POST" style="display:inline;">
                <input type="hidden" name="jobId" value="<%= rs.getInt("id") %>" />
                <button type="submit" class="text-red-600 hover:text-red-800">
                    &#128465; <!-- Trash Icon -->
                </button>
            </form>
        </td>
    </tr>
    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the error in console
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</tbody>
                        
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
