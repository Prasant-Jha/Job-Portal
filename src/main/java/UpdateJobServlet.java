import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/UpdateJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/Job";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "prashant";

    private static final String UPLOAD_DIR = "C:/uploads/";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String jobTitle = request.getParameter("jobTitle");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String salary = request.getParameter("salary");
        String jobType = request.getParameter("jobType");
        String description = request.getParameter("description");
        String dueDateString = request.getParameter("dueDate");

        // Ensure upload directory exists
        File uploadPath = new File(UPLOAD_DIR);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        // Parse the due date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dueDate;
        try {
            dueDate = sdf.parse(dueDateString);
        } catch (ParseException e) {
            throw new ServletException("Invalid Date Format", e);
        }

        // Handle file upload
        Part imagePart = request.getPart("image");
        String imageName = null;
        String filePath = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            imageName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            filePath = UPLOAD_DIR + imageName;
            imagePart.write(filePath);
        }

        // SQL query update
        String sql = "UPDATE jobs SET job_title=?, company=?, location=?, salary=?, job_type=?, description=?, due_date=?";
        boolean hasImage = imageName != null && !imageName.isEmpty();
        if (hasImage) {
            sql += ", image=?";
        }
        sql += " WHERE id=?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, jobTitle);
            stmt.setString(2, company);
            stmt.setString(3, location);
            stmt.setString(4, salary);
            stmt.setString(5, jobType);
            stmt.setString(6, description);
            stmt.setDate(7, new java.sql.Date(dueDate.getTime()));

            if (hasImage) {
                stmt.setString(8, imageName);
                stmt.setInt(9, jobId);
            } else {
                stmt.setInt(8, jobId);
            }

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("EmployerDashboard.jsp?success=true");
            } else {
                response.sendRedirect("EmployerDashboard.jsp?error=not_found");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
