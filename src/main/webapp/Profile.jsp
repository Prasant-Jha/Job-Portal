<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {},
            },
        };

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
                        <img src="assets/profile.png" alt="Profile Image"
                            class="w-32 h-32 rounded-full mb-4 border border-gray-300 shadow">
                    </div>

                    <div class="space-y-4">
                        <p><strong>Name:</strong> John Doe</p>
                        <p><strong>Bio:</strong> Web Developer & Designer</p>
                        <p><strong>Email:</strong> johndoe@example.com</p>
                        <p><strong>Contact:</strong> +1234567890</p>
                        <p><strong>Role:</strong> Admin</p>
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
                    <form action="saveProfile" method="POST" enctype="multipart/form-data">

                        <!-- Profile Image Section -->
                        <div class="flex flex-col items-center mb-6">
                            <img src="<%= request.getContextPath() %>/assets/profile.png" alt="Profile Image"
                                class="w-32 h-32 rounded-full mb-4 border border-gray-300 shadow">
                            <input type="file" name="profilePicture" accept="image/*"
                                class="border border-gray-300 rounded-lg p-2 w-full">
                        </div>

                        <!-- Profile Fields Section -->
                        <div class="space-y-4">
                            <label for="name" class="block font-semibold text-gray-700">Name:</label>
                            <input type="text" id="name" name="name"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="John Doe">

                            <label for="bio" class="block font-semibold text-gray-700">Bio:</label>
                            <textarea id="bio" name="bio" rows="4"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4">Web Developer & Designer</textarea>

                            <label for="email" class="block font-semibold text-gray-700">Email:</label>
                            <input type="email" id="email" name="email"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="johndoe@example.com">

                            <label for="contact" class="block font-semibold text-gray-700">Contact:</label>
                            <input type="text" id="contact" name="contact"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="+1234567890">

                            <label for="role" class="block font-semibold text-gray-700">Role:</label>
                            <input type="text" id="role" name="role"
                                class="w-full p-3 border border-gray-300 rounded-lg mb-4" value="Admin">
                        </div><br>

                        <!-- Save Changes Button -->
                        <button type="button" onclick="toggleEditMode()"
                            class="w-full bg-green-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-green-700 transition">
                            Save Changes
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>

</body>

</html>
