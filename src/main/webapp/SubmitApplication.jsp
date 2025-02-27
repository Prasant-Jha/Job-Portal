<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.annotation.MultipartConfig" %>
<%@ page import="jakarta.servlet.http.Part" %>

<%@ page import="java.io.*, java.sql.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<%@ MultipartConfig %>


<%
    // Ensure session exists
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get job ID safely
    String jobId = request.getParameter("jobId");
if (jobId == null || jobId.isEmpty()) {
    response.sendRedirect("ApplyJob.jsp?error=missingJobId");
    return;
}

    int jobIdInt = 0;
    try {
        jobIdInt = Integer.parseInt(jobId);
    } catch (NumberFormatException e) {
        response.sendRedirect("ApplyJob.jsp?error=Invalid Job ID format");
        return;
    }

    // Database credentials
    String jdbcURL = "jdbc:postgresql://localhost:5432/Job";
    String dbUser = "postgres";
    String dbPass = "prashant";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int userId = -1;
    String resumePath = "";

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

        // Fetch user ID from email
        String getUserQuery = "SELECT id FROM users WHERE email = ?";
        pstmt = conn.prepareStatement(getUserQuery);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("id");
        } else {
            response.sendRedirect("Login.jsp");
            return;
        }
        rs.close();
        pstmt.close();

        // Handle file upload
        Part filePart = request.getPart("resume");
        if (filePart != null) {
            resumePath = "uploads/" + userId + "_" + jobIdInt + "_resume.pdf";
            String savePath = application.getRealPath("/") + resumePath;
            filePart.write(savePath);
        } else {
            response.sendRedirect("ApplyJob.jsp?error=File upload failed");
            return;
        }

        // Insert application into database
        String insertQuery = "INSERT INTO application (user_id, job_id, resume_path, status) VALUES (?, ?, ?, 'Pending')";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, jobIdInt);
        pstmt.setString(3, resumePath);
        pstmt.executeUpdate();

        response.sendRedirect("EmployeeDashboard.jsp?message=Application+Submitted+Successfully");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ApplyJob.jsp?error=" + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>