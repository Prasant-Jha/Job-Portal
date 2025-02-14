<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                        <% 
                        class User {
                            int id;
                            String profilePic, name, email, contact, role;
                            User(int id, String profilePic, String name, String email, String contact, String role) {
                                this.id = id;
                                this.profilePic = profilePic;
                                this.name = name;
                                this.email = email;
                                this.contact = contact;
                                this.role = role;
                            }
                        }

                        List<User> users = new ArrayList<>();
                        users.add(new User(1, "https://via.placeholder.com/40", "John Doe", "johndoe@example.com", "+1234567890", "Admin"));
                        users.add(new User(2, "https://via.placeholder.com/40", "Jane Smith", "janesmith@example.com", "+0987654321", "User"));
                        users.add(new User(3, "https://via.placeholder.com/40", "Sam Wilson", "samwilson@example.com", "+1122334455", "User"));
                        users.add(new User(4, "https://via.placeholder.com/40", "Mike Johnson", "mikejohnson@example.com", "+6677889900", "Admin"));
                        users.add(new User(1, "https://via.placeholder.com/40", "John Doe", "johndoe@example.com", "+1234567890", "Admin"));
                        users.add(new User(2, "https://via.placeholder.com/40", "Jane Smith", "janesmith@example.com", "+0987654321", "User"));
                        users.add(new User(3, "https://via.placeholder.com/40", "Sam Wilson", "samwilson@example.com", "+1122334455", "User"));
                        users.add(new User(4, "https://via.placeholder.com/40", "Mike Johnson", "mikejohnson@example.com", "+6677889900", "Admin"));
                        users.add(new User(1, "https://via.placeholder.com/40", "John Doe", "johndoe@example.com", "+1234567890", "Admin"));
                        users.add(new User(2, "https://via.placeholder.com/40", "Jane Smith", "janesmith@example.com", "+0987654321", "User"));
                        users.add(new User(3, "https://via.placeholder.com/40", "Sam Wilson", "samwilson@example.com", "+1122334455", "User"));
                        users.add(new User(4, "https://via.placeholder.com/40", "Mike Johnson", "mikejohnson@example.com", "+6677889900", "Admin"));


                        if (users.isEmpty()) { %>
                            <tr>
                                <td colspan="6" class="text-center p-4 text-gray-600">No users found.</td>
                            </tr>
                        <% } else { 
                            for (User user : users) { %>
                            <tr class="border-b">
                                <td class="p-3">
                                    <img src="<%= user.profilePic %>" alt="Profile" class="w-10 h-10 rounded-full" />
                                </td>
                                <td class="p-3"><%= user.name %></td>
                                <td class="p-3"><%= user.email %></td>
                                <td class="p-3"><%= user.contact %></td>
                                <td class="p-3"><%= user.role %></td>
                                <td class="p-3 text-center">
                                    <form action="deleteUser.jsp" method="POST">
                                        <input type="hidden" name="userId" value="<%= user.id %>" />
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
