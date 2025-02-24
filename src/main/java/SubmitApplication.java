import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/SubmitApplication")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold before writing to disk
                 maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB max request size
public class SubmitApplication extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Change to a valid directory on your server
    private static final String UPLOAD_DIRECTORY = "assets/";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("email");
        String jobIdStr = request.getParameter("jobId");

        if (jobIdStr == null || jobIdStr.isEmpty()) {
            response.sendRedirect("ApplyJob.jsp?error=Missing+Job+ID");
            return;
        }

        int jobId;
        try {
            jobId = Integer.parseInt(jobIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("ApplyJob.jsp?error=Invalid+Job+ID");
            return;
        }

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

            // Check if user already applied
            String checkQuery = "SELECT id FROM application WHERE user_id = ? AND job_id = ?";
            pstmt = conn.prepareStatement(checkQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, jobId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                response.sendRedirect("ApplyJob.jsp?error=You+have+already+applied+for+this+job");
                return;
            }
            rs.close();
            pstmt.close();

            // Handle file upload
            Part filePart = request.getPart("resume");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect("ApplyJob.jsp?error=No+file+uploaded");
                return;
            }

            // Ensure upload directory exists
            File uploadDir = new File(UPLOAD_DIRECTORY);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save file to server
            String fileName = userId + "_" + jobId + "_resume.pdf";
            resumePath = UPLOAD_DIRECTORY + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, new File(resumePath).toPath());
            }

            // Insert application into database
            String insertQuery = "INSERT INTO application (user_id, job_id, resume_path, status) VALUES (?, ?, ?, 'Pending')";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, jobId);
            pstmt.setString(3, resumePath);
            pstmt.executeUpdate();

            response.sendRedirect("EmployeeDashboard.jsp?message=Application+Submitted+Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ApplyJob.jsp?error=" + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}
