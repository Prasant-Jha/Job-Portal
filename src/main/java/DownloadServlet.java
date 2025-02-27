import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/DownloadServlet")

public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = request.getParameter("file");

        if (filePath == null || filePath.trim().isEmpty()) {
            response.getWriter().write("Invalid file request");
            return;
        }

        File file = new File(filePath);

        if (file.exists() && file.isFile()) {
        	String mimeType = Files.probeContentType(file.toPath());
            if (mimeType == null) {
                mimeType = "application/octet-stream"; // Default binary type
            }

            response.setContentType(mimeType);
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\""); 
            response.setContentLengthLong(file.length());

            try (FileInputStream inStream = new FileInputStream(file);
                 OutputStream outStream = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
            }
        } else {
            response.getWriter().write("File not found");
        }
    }
}
