<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.sql.*, java.util.*" %>
<%
    // Check if the session attribute "email" exists
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get job ID
    String jobId = request.getParameter("jobId");

    // Database credentials
    String jdbcURL = "jdbc:postgresql://localhost:5432/Job";
    String dbUser = "postgres";
    String dbPass = "prashant";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Get User ID from database
    int userId = -1;

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

        // File Upload Handling
        String resumePath = "uploads/" + userId + "_" + jobId + "_resume.pdf";
        Part filePart = request.getPart("resume");
        String savePath = application.getRealPath("/") + resumePath;
        filePart.write(savePath);

        // Insert application into database
        String insertQuery = "INSERT INTO application (user_id, job_id, resume_path, status) VALUES (?, ?, ?, 'Pending')";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, Integer.parseInt(jobId));
        pstmt.setString(3, resumePath);
        pstmt.executeUpdate();

        response.sendRedirect("EmployeeDashboard.jsp?message=Application+Submitted+Successfully");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ApplyJob.jsp?error=Application+Failed");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
