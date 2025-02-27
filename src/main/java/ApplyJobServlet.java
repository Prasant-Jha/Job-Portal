import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 10 * 1024 * 1024, maxRequestSize = 50 * 1024 * 1024)
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session email
        String userEmail = (String) request.getSession().getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Ensure jobId is retrieved correctly
        String jobId = request.getParameter("jobId");

        if (jobId == null || jobId.trim().isEmpty()) {
        	response.sendRedirect("ApplyJob.jsp?error=Missing Job ID");
            return;
        }

        int jobIdInt;
        try {
            jobIdInt = Integer.parseInt(jobId);
        } catch (NumberFormatException e) {
        	response.sendRedirect("ApplyJob.jsp?error=Invalid Job ID format");
            return;
        }

        String jdbcURL = "jdbc:postgresql://localhost:5432/Job";
        String dbUser = "postgres";
        String dbPass = "prashant";

        int userId = -1;
        String resumePath = "";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass)) {
            Class.forName("org.postgresql.Driver");

            // Fetch user ID from email
            String getUserQuery = "SELECT id FROM users WHERE email = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(getUserQuery)) {
                pstmt.setString(1, userEmail);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("id");
                    } else {
                        response.sendRedirect("Login.jsp");
                        return;
                    }
                }
            }

            // Handle file upload
            Part filePart = request.getPart("resume");
            if (filePart == null || filePart.getSize() == 0) {
            	response.sendRedirect("ApplyJob.jsp?error=File upload failed");
                return;
            }

            String originalFileName = filePart.getSubmittedFileName();
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String fileName = userId + "_" + jobIdInt + "_resume" + fileExtension;

            // Define upload directory
            String uploadDir = getServletContext().getRealPath("/") + "assets";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists() && !uploadFolder.mkdirs()) {
            	response.sendRedirect("ApplyJob.jsp?error=Failed to create upload directory");
                return;
            }

            // Save file
            String savePath = uploadDir + File.separator + fileName;
            filePart.write(savePath);
            resumePath = "assets/" + fileName;

            // Insert into application table
            String insertQuery = "INSERT INTO application (user_id, job_id, resume_path, status) VALUES (?, ?, ?, 'Pending')";
            try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, jobIdInt);
                pstmt.setString(3, resumePath);
                pstmt.executeUpdate();
            }

            response.sendRedirect("EmployeeDashboard.jsp?message=Application Submitted Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ApplyJob.jsp?error=An error occurred: " + e.getMessage());
        }
    }
}
