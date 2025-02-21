import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // PostgreSQL Database Configuration
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/Job";
    private static final String JDBC_USER = "postgres";
    private static final String JDBC_PASSWORD = "prashant";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String role = request.getParameter("role");

        // Basic Validation
        if (fullName == null || email == null || password == null || mobile == null || role == null ||
            fullName.isEmpty() || email.isEmpty() || password.isEmpty() || mobile.isEmpty() || role.isEmpty()) {
            out.println("<h3 style='color:red;'>All fields are required!</h3>");
            return;
        }

        // Hash the password before storing it (convert to Hexadecimal)
        String hashedPassword = hashPasswordToHex(password);

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");

            // Establish Database Connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // SQL Query to Insert User Data
            String sql = "INSERT INTO users (full_name, email, password, mobile, role) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            // Set Parameters
            pstmt.setString(1, fullName);
            pstmt.setString(2, email);
            pstmt.setString(3, "\\x" + hashedPassword); // Store password in Hex format with \x prefix
            pstmt.setString(4, mobile);
            pstmt.setString(5, role);

            // Execute the Insert Query
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("Login.jsp"); // Redirect to login page after success
            } else {
                out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // Method to hash the password using SHA-256 and convert it to Hexadecimal
    private String hashPasswordToHex(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Convert byte array to hex string
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
