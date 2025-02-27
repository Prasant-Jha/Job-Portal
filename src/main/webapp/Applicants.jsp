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

                    // Query to fetch applications with job title
                    String query = "SELECT a.id, a.resume_path, a.status, a.job_id, a.user_id, j.employer_email, j.job_title, u.full_name " +
                                   "FROM application a " +
                                   "JOIN jobs j ON a.job_id = j.id " +
                                   "JOIN users u ON user_id = u.id " +
                                   "WHERE j.employer_email = ?";

                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, userEmail);
                    rs = stmt.executeQuery();

                    if (rs.isBeforeFirst()) { // Check if result set has data
                        hasData = true;
                        while (rs.next()) {
                            int appId = rs.getInt("id");
                            String resumePath = rs.getString("resume_path");
                            String status = rs.getString("status");
                            String jobTitle = rs.getString("job_title"); // Get the job title
                            String username = rs.getString("full_name");
            %>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <h3 class="text-xl font-semibold text-gray-800"><%= jobTitle %></h3>
                <p class="text-gray-700"><strong>Username:</strong> <%= username %></p>
                <p class="text-gray-700"><strong>Resume:</strong> <%= resumePath %></p>
                <p class="text-gray-700"><strong>Status:</strong> 
                    <span class="<%= status.equals("Selected") ? "text-green-600" : status.equals("Rejected") ? "text-red-600" : "text-blue-600" %>">
                        <%= status %>
                    </span>
                </p>
                <div class="flex space-x-4 mt-4">
                    <button onclick="updateStatus(<%= appId %>, 'Selected')" class="bg-green-500 text-white px-4 py-2 rounded-md">Select</button>
                    <button onclick="updateStatus(<%= appId %>, 'Rejected')" class="bg-red-500 text-white px-4 py-2 rounded-md">Reject</button>
                   	<a href="DownloadServlet?file=<%= resumePath %>" class="bg-blue-500 text-white px-4 py-2 rounded-md">Download Resume</a>
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
                <p class="text-gray-500 text-lg">No job applications for your jobs yet.</p>
            <%
                }
            %>

        </div>
    </div>

    <%-- JavaScript for updating status --%>
    <script>
    function updateStatus(appId, newStatus) {
        console.log("Sending App ID:", appId);
        console.log("Sending New Status:", newStatus);

        fetch("updateStatus.jsp?appId=" + encodeURIComponent(appId) + "&newStatus=" + encodeURIComponent(newStatus), {
            method: "GET", // Change to GET since manual GET request is working
        })
        .then(response => response.text())
        .then(data => {
            console.log("Response from server:", data);
            alert(data);
            location.reload();
        })
        .catch(error => console.error("Error:", error));
    }



    </script>

</body>
</html>
