import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String enteredOTP = request.getParameter("otp");
        int sessionOTP = (int) session.getAttribute("otp");

        if (enteredOTP.equals(String.valueOf(sessionOTP))) {
            response.sendRedirect("ResetPassword.jsp");
        } else {
            response.sendRedirect("VerifyOTP.jsp?error=Invalid OTP");
        }
    }
}
