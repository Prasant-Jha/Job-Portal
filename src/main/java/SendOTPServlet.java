import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        if (email == null || email.isEmpty()) {
            response.sendRedirect("ForgotPassword.jsp?error=Invalid Email");
            return;
        }

        int otp = new Random().nextInt(900000) + 100000; // Generate 6-digit OTP
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        boolean sent = sendEmail(email, otp);

        if (sent) {
            response.sendRedirect("VerifyOTP.jsp");
        } else {
            response.sendRedirect("ForgotPassword.jsp?error=Failed to send OTP");
        }
    }

    private boolean sendEmail(String email, int otp) {
        final String from = "pjha693@rku.ac.in";
        final String password = "wypj ryos htku ymrh";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
