<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">

    <!-- Include the header and sidebar from separate files -->
    <jsp:include page="header.jsp" />
    <jsp:include page="sidebar.jsp" />

    <!-- Profile Page Content -->
    <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
        <div class="bg-white w-11/12 p-8 border border-gray-300 rounded-lg shadow-lg">
            <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Profile</h2>

            <form action="saveProfile" method="POST" enctype="multipart/form-data">

                <!-- Profile Image Section -->
                <div class="flex items-center justify-center">
                    <c:if test="${not empty profileData.profilePicture}">
                        <img src="${profileData.profilePicture}" alt="Profile" class="w-32 h-32 rounded-full mb-4" />
                    </c:if>
                    <c:if test="${empty profileData.profilePicture}">
                        <img src="<%= request.getContextPath() %>/assets/profile.png" alt="Default Profile" class="w-32 h-32 rounded-full mb-4" />
                    </c:if>
                    <input type="file" name="profilePicture" accept="image/*" class="mb-6 border-1 h-[20vh] w-[20vh] rounded-[10vh]">
                </div>

                <!-- Profile Fields Section -->
                <div class="space-y-4">
                    <div>
                        <label for="name" class="block">Name: </label>
                        <input type="text" name="name" value="${profileData.name}" class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                    </div>

                    <div>
                        <label for="bio" class="block">Bio: </label>
                        <textarea name="bio" rows="4" cols="50" class="w-full p-3 border border-gray-300 rounded-lg mb-4">${profileData.bio}</textarea>
                    </div>

                    <div>
                        <label for="email" class="block">Email: </label>
                        <input type="email" name="email" value="${profileData.email}" class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                    </div>

                    <div>
                        <label for="contact" class="block">Contact: </label>
                        <input type="text" name="contact" value="${profileData.contact}" class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                    </div>

                    <div>
                        <label for="role" class="block">Role: </label>
                        <input type="text" name="role" value="${profileData.role}" class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                    </div>
                </div>

                <!-- Save Button -->
                <div class="mt-6">
                    <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700">
                        Save Changes
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>

</html>
