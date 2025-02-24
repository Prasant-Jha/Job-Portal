<%@ page import="java.sql.*" %>

<%
    String appIdStr = request.getParameter("appId");
    String newStatus = request.getParameter("newStatus");

    if (appIdStr == null || appIdStr.trim().isEmpty() || newStatus == null || newStatus.trim().isEmpty()) {
        out.println("Invalid data provided.");
        return;
    }

    int appId = -1;
    try {
        appId = Integer.parseInt(appIdStr.trim());
    } catch (NumberFormatException e) {
        out.println("Invalid application ID format.");
        return;
    }

    String url = "jdbc:postgresql://localhost:5432/Job";
    String user = "postgres";
    String password = "prashant";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String query = "UPDATE application SET status = ? WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, newStatus);
        stmt.setInt(2, appId);

        int updatedRows = stmt.executeUpdate();
        if (updatedRows > 0) {
            out.println("Status updated successfully.");
        } else {
            out.println("Failed to update status.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
