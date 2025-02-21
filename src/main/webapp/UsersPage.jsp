<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Check if the session attribute "email" exists
    String userEmail = (String) session.getAttribute("email");

    // If the user is not logged in, redirect to the login page
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Database connection details
    String JDBC_URL = "jdbc:postgresql://localhost:5432/Job";
    String JDBC_USER = "postgres";
    String JDBC_PASSWORD = "prashant";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> users = new ArrayList<>();

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

        // Fetch users from database
        String sql = "SELECT id, profilePic, full_name, email, mobile, role FROM users";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> user = new HashMap<>();
            user.put("id", rs.getString("id"));
            user.put("profilePic", rs.getString("profilePic") != null ? rs.getString("profilePic") : "https://via.placeholder.com/40");
            user.put("name", rs.getString("full_name"));
            user.put("email", rs.getString("email"));
            user.put("contact", rs.getString("mobile"));
            user.put("role", rs.getString("role"));
            users.add(user);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">
    
    <%@ include file="Header.jsp" %>
    
    <div class="flex w-full h-[calc(100vh-80px)]">
        <%@ include file="Sidebar.jsp" %>
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <h2 class="text-3xl font-bold text-gray-800">Manage Users</h2>
            
            <div class="w-full bg-white p-6 rounded-xl shadow-lg">
                <table class="w-full border-collapse">
                    <thead>
                        <tr class="bg-gray-200">
                            <th class="p-3 text-left">Profile</th>
                            <th class="p-3 text-left">Name</th>
                            <th class="p-3 text-left">Email</th>
                            <th class="p-3 text-left">Contact</th>
                            <th class="p-3 text-left">Role</th>
                            <th class="p-3 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users.isEmpty()) { %>
                            <tr>
                                <td colspan="6" class="text-center p-4 text-gray-600">No users found.</td>
                            </tr>
                        <% } else {
                            for (Map<String, String> user : users) { %>
                            <tr class="border-b">
                                <td class="p-3">
                                    <img src="<%= user.get("profilePic") %>" alt="Profile" class="w-10 h-10 rounded-full" />
                                </td>
                                <td class="p-3"><%= user.get("name") %></td>
                                <td class="p-3"><%= user.get("email") %></td>
                                <td class="p-3"><%= user.get("contact") %></td>
                                <td class="p-3"><%= user.get("role") %></td>
                                <td class="p-3 text-center">
                                    <form action="DeleteUserServlet" method="POST">
                                        <input type="hidden" name="userId" value="<%= user.get("id") %>" />
                                        <button type="submit" class="text-red-600 hover:text-red-800">
                                            &#128465; <!-- Trash icon -->
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } 
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
