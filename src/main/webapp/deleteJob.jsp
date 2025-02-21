<%@ page import="java.sql.*" %>

<%
    // Retrieve job ID from request
    String jobId = request.getParameter("jobId");

    if (jobId == null || jobId.isEmpty()) {
        response.sendRedirect("JobPostspage.jsp?error=InvalidJobID");
        return;
    }

    // Database connection details
    String url = "jdbc:postgresql://localhost:5432/Job";
    String user = "postgres";
    String password = "prashant";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establish database connection
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Delete job post query
        String query = "DELETE FROM jobs WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(jobId));

        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("JobPostsPage.jsp?success=JobDeleted");
        } else {
            response.sendRedirect("JobPostsPage.jsp?error=JobNotFound");
        }

    } catch (Exception e) {
        response.sendRedirect("JobPostsPage.jsp?error=" + e.getMessage());
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
