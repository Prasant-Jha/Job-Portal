<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Session check to verify admin authentication
    String userEmail = (String) session.getAttribute("email");

    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Database connection details
    String url = "jdbc:postgresql://localhost:5432/Job";
    String user = "postgres";
    String password = "prashant";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Job Posts</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="w-full min-h-screen">
        <%-- Include header and sidebar --%>
        <jsp:include page="Header.jsp" />
        <div class="flex w-full h-[calc(100vh-80px)]">
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
                                try {
                                    // Establish connection
                                    Class.forName("org.postgresql.Driver");
                                    conn = DriverManager.getConnection(url, user, password);

                                    // Query to fetch all job posts
                                    String query = "SELECT id, image, job_title, company, location, salary, job_type FROM jobs";
                                    stmt = conn.prepareStatement(query);
                                    rs = stmt.executeQuery();

                                    if (!rs.isBeforeFirst()) { // No records found
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
                                    <form action="deleteJob.jsp" method="POST">
                                        <input type="hidden" name="jobId" value="<%= rs.getInt("id") %>" />
                                        <button type="submit" class="text-red-600 hover:text-red-800">
                                            &#128465; <!-- Trash icon -->
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                        }
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='7' class='text-red-500 text-center'>Error: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    // Close resources
                                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
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
