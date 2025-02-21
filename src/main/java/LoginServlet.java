import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/Job";
    private static final String JDBC_USER = "postgres";
    private static final String JDBC_PASSWORD = "prashant";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHexPassword = rs.getString("password").substring(2); // Remove \x prefix
                String hashedInputPassword = hashPasswordToHex(password); // Convert input password to hex

                if (storedHexPassword.equalsIgnoreCase(hashedInputPassword)) {
                    // Create session if password matches
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("full_name", rs.getString("full_name"));
                    session.setAttribute("role", rs.getString("role"));
                    session.setAttribute("mobile", rs.getString("mobile"));
                    session.setAttribute("bio", rs.getString("bio"));
                    session.setAttribute("profilePic", rs.getString("profilePic"));
                    session.setMaxInactiveInterval(30 * 60); // Session expires after 30 minutes
                    
                    response.sendRedirect("Job.jsp"); // Redirect to dashboard
                } else {
                    response.sendRedirect("Login.jsp?error=Invalid email or password");
                }
            } else {
                response.sendRedirect("Login.jsp?error=Invalid email or password");
            }

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Method to hash password to Hexadecimal (instead of Base64)
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
