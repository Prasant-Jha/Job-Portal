import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.WebServlet;


@WebServlet("/UpdateProfileServlet")
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/Job";
    private static final String JDBC_USER = "postgres";
    private static final String JDBC_PASSWORD = "prashant"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve form data
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");

        // Profile picture upload handling
        Part filePart = request.getPart("profilePicture");
        String profilePicPath = (String) session.getAttribute("profilePic"); // Keep old profile pic if new is not uploaded

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = "profile_" + session.getId() + ".jpg";
            String uploadPath = getServletContext().getRealPath("/") + "assets/" + fileName;
            filePart.write(uploadPath);
            profilePicPath = "assets/" + fileName;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load PostgreSQL driver
            Class.forName("org.postgresql.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Update user data in the database
            String sql = "UPDATE users SET full_name = ?, bio = ?, mobile = ?, profilePic = ? WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, bio);
            pstmt.setString(3, contact);
            pstmt.setString(4, profilePicPath);
            pstmt.setString(5, email);

            int updated = pstmt.executeUpdate();

            if (updated > 0) {
                // Update session attributes
                session.setAttribute("full_name", name);
                session.setAttribute("bio", bio);
                session.setAttribute("mobile", contact);
                session.setAttribute("profilePic", profilePicPath);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        // Redirect back to profile page
        response.sendRedirect("Profile.jsp");
    }
}
