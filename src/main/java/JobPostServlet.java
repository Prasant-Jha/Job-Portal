import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/JobPostServlet")
@MultipartConfig
public class JobPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/Job";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "prashant";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employerEmail = request.getParameter("employerEmail");
        String jobTitle = request.getParameter("jobTitle");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String salary = request.getParameter("salary");
        String jobType = request.getParameter("jobType");
        String description = request.getParameter("description");
        Part imagePart = request.getPart("image");

        // Ensure the "assets" directory exists
        String uploadDir = getServletContext().getRealPath("/") + "assets/";
        File uploadPath = new File(uploadDir);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        // Generate a unique image name
        String imageName = "job_" + System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
        String filePath = uploadDir + imageName;
        
        // Save the uploaded file
        imagePart.write(filePath);

        // Store the relative path in the database
        String imagePath = "assets/" + imageName;

        // Convert dates
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date postDate = new Date();
        Date dueDate;
        try {
            dueDate = sdf.parse(request.getParameter("dueDate"));
        } catch (ParseException e) {
            throw new ServletException("Invalid Date Format");
        }

        // Insert job into database
        String sql = "INSERT INTO jobs (employer_email, job_title, company, location, salary, job_type, description, image, post_date, due_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, employerEmail);
            stmt.setString(2, jobTitle);
            stmt.setString(3, company);
            stmt.setString(4, location);
            stmt.setString(5, salary);
            stmt.setString(6, jobType);
            stmt.setString(7, description);
            stmt.setString(8, imagePath); // Store the correct relative path
            stmt.setDate(9, new java.sql.Date(postDate.getTime()));
            stmt.setDate(10, new java.sql.Date(dueDate.getTime()));

            stmt.executeUpdate();
            response.sendRedirect("EmployerDashboard.jsp");

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}
