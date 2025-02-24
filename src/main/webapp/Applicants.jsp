<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.io.*" %>

<%
    // Session check
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
    <title>Applicants</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <%-- Header Section --%>
    <jsp:include page="Header.jsp" />

    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <%-- Sidebar --%>
        <jsp:include page="Sidebar.jsp" />
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <h2 class="text-2xl font-bold text-gray-800">Manage Job Applications</h2>

            <%-- Fetch and Display Applications Dynamically --%>
            <%
                boolean hasData = false;
                try {
                    Class.forName("org.postgresql.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    String query = "SELECT id, resume_path, status FROM application";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    if (rs.isBeforeFirst()) { // Check if result set has data
                        hasData = true;
                        while (rs.next()) {
                            int appId = rs.getInt("id");
                            String resumePath = rs.getString("resume_path");
                            String status = rs.getString("status");
            %>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Resume:</strong> <%= resumePath %></p>
                <p class="text-gray-700"><strong>Status:</strong> 
                    <span class="<%= status.equals("Selected") ? "text-green-600" : status.equals("Rejected") ? "text-red-600" : "text-blue-600" %>">
                        <%= status %>
                    </span>
                </p>
                <div class="flex space-x-4 mt-4">
                    <button onclick="updateStatus(<%= appId %>, 'Selected')" class="bg-green-500 text-white px-4 py-2 rounded-md">Select</button>
                    <button onclick="updateStatus(<%= appId %>, 'Pending')" class="bg-yellow-500 text-white px-4 py-2 rounded-md">Pending</button>
                    <button onclick="updateStatus(<%= appId %>, 'Rejected')" class="bg-red-500 text-white px-4 py-2 rounded-md">Reject</button>
                    <a href="<%= resumePath %>" download class="bg-blue-500 text-white px-4 py-2 rounded-md">Download Resume</a>
                </div>
            </div>

            <%
                        } // Close while loop
                    } // Close if (rs.isBeforeFirst())
                } catch (Exception e) {
                    out.println("<p class='text-red-500'>Error fetching applications: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }

                // If no data is found, show message
                if (!hasData) {
            %>
                <p class="text-gray-500 text-lg">No job applications for any jobs yet.</p>
            <%
                }
            %>

        </div>
    </div>

    <%-- JavaScript for updating status --%>
    <script>
        function updateStatus(appId, newStatus) {
            fetch("updateStatus.jsp", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `appId=${appId}&newStatus=${newStatus}`
            })
            .then(response => response.text())
            .then(data => {
                alert(data);
                location.reload();
            })
            .catch(error => console.error("Error:", error));
        }
    </script>

</body>
</html>
