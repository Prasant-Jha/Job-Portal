<%@ page import="java.io.*" %>

<%
    String filePath = request.getParameter("file");
    if (filePath == null || filePath.isEmpty()) {
        out.println("Invalid file path.");
        return;
    }

    File file = new File(filePath);
    if (!file.exists()) {
        out.println("File not found.");
        return;
    }

    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

    FileInputStream fileInputStream = new FileInputStream(file);
    OutputStream outputStream = response.getOutputStream();
    
    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = fileInputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, bytesRead);
    }
    
    fileInputStream.close();
    outputStream.close();
%>
