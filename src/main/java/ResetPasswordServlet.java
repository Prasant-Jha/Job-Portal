import java.io.IOException;
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String newPassword = request.getParameter("password");

        if (email == null || newPassword == null) {
            response.sendRedirect("ResetPassword.jsp?error=Invalid request");
            return;
        }

        // Hash the password using SHA-256 with hexadecimal encoding
        String hashedPassword = hashPassword(newPassword);

        try {
            // PostgreSQL Connection
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Job", "postgres", "prashant");

            String sql = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);

            int updated = stmt.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("Login.jsp?success=Password changed successfully");
            } else {
                response.sendRedirect("ResetPassword.jsp?error=Failed to reset password");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ResetPassword.jsp?error=Something went wrong");
        }
    }

    // Method to hash password using SHA-256 and convert to hexadecimal
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Convert byte array to hexadecimal string with "\x" prefix
            StringBuilder hexString = new StringBuilder("\\x");
            for (byte b : hashedBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

}
