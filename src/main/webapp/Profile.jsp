<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>

<%
    // Ensure user is logged in
    String userName = (String) session.getAttribute("full_name");
    String userEmail = (String) session.getAttribute("email");
    String userBio = (String) session.getAttribute("bio");
    String userContact = (String) session.getAttribute("mobile");
    String profilePic = (String) session.getAttribute("profilePic"); // Store profile image path in session

    // Redirect to login page if not logged in
    if (userEmail == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Default values if fields are empty
    if (userBio == null) userBio = "No bio available";
    if (userContact == null) userContact = "No contact available";
    if (profilePic == null) profilePic = "assets/profile.png"; // Default profile image
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function toggleEditMode() {
            document.getElementById("profileView").classList.toggle("hidden");
            document.getElementById("profileForm").classList.toggle("hidden");
        }
    </script>
</head>

<body class="bg-gray-100 h-screen">

    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-[calc(100vh-80px)]">
        <%@ include file="Sidebar.jsp" %>

        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <div class="w-full bg-white p-8 border border-gray-300 rounded-lg shadow-lg">

                <!-- Static Profile View -->
                <div id="profileView">
                    <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Profile</h2>
                    <div class="flex flex-col items-center mb-6">
                        <img src="<%= profilePic %>" alt="Profile Image"
                            class="w-32 h-32 rounded-full mb-4 border border-gray-300 shadow">
                    </div>

                    <div class="space-y-4">
                        <p><strong>Name:</strong> <%= userName %></p>
                        <p><strong>Bio:</strong> <%= userBio %></p>
                        <p><strong>Email:</strong> <%= userEmail %></p>
                        <p><strong>Contact:</strong> <%= userContact %></p>
                        <p><strong>Role:</strong> <%= userRole %></p>
                    </div><br>

                    <!-- Edit Profile Button -->
                    <button onclick="toggleEditMode()"
                        class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700 transition">
                        Edit Profile
                    </button>
                </div>

                <!-- Editable Profile Form (Initially Hidden) -->
                <div id="profileForm" class="hidden">
                    <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Edit Profile</h2>
                    <form action="UpdateProfileServlet" method="POST" enctype="multipart/form-data">

                        <!-- Profile Image Section -->
                        <div class="flex flex-col items-center mb-6">
                            <img src="<%= profilePic %>" alt="Profile Image"
                                class="w-32 h-32 rounded-full mb-4 border border-gray-300 shadow">
                            <input type="file" name="profilePicture" accept="image/*"
                                class="border border-gray-300 rounded-lg p-2 w-full">
                        </div>

                        <!-- Profile Fields Section -->
                        <div class="space-y-4">
                            <label for="name" class="block font-semibold text-gray-700">Name:</label>
                            <input type="text" id="name" name="name"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="<%= userName %>">

                            <label for="bio" class="block font-semibold text-gray-700">Bio:</label>
                            <textarea id="bio" name="bio" rows="4"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4"><%= userBio %></textarea>

                            <label for="email" class="block font-semibold text-gray-700">Email:</label>
                            <input type="email" id="email" name="email"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="<%= userEmail %>">

                            <label for="contact" class="block font-semibold text-gray-700">Contact:</label>
                            <input type="text" id="contact" name="contact"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="<%= userContact %>">

                            <label for="role" class="block font-semibold text-gray-700">Role:</label>
                            <input type="text" id="role" name="role"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="<%= userRole %>" readonly>
                        </div><br>

                        <!-- Save Changes Button -->
                        <button type="submit"
                            class="w-full bg-green-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-green-700 transition">
                            Save Changes
                        </button>
                    </form>

                    <!-- Cancel Edit Button -->
                    <button onclick="toggleEditMode()"
                        class="w-full bg-gray-400 text-white py-3 rounded-lg font-medium shadow-md mt-3 hover:bg-gray-500 transition">
                        Cancel
                    </button>
                </div>

            </div>
        </div>
    </div>

</body>

</html>
