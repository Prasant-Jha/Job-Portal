<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String currentPath = request.getRequestURI();
    String openSection = null;

    // Define the section mappings
    Map<String, List<String>> sectionMapping = new HashMap<>();
    sectionMapping.put("admin", Arrays.asList("/admin-dashboard", "/users", "/job-posts"));
    sectionMapping.put("employer", Arrays.asList("/employer-dashboard", "/post-job"));

    // Check if the current path belongs to a section
    for (Map.Entry<String, List<String>> entry : sectionMapping.entrySet()) {
        if (entry.getValue().contains(currentPath)) {
            openSection = entry.getKey();
            break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

    <div class="w-1/4 h-full p-5 border-r border-gray-300">
        <!-- Search Bar -->
        <div class="flex items-center bg-white border border-gray-400 px-4 py-2 w-full mb-6">
            <span class="text-gray-500 text-lg">🔍</span>
            <input
                type="text"
                placeholder="Search..."
                class="ml-3 w-full outline-none text-lg bg-transparent"
            />
        </div>

        <!-- Sidebar Items -->
        <ul class="space-y-4 text-lg font-medium">

            <!-- Admin Section -->
            <li>
                <div class="flex items-center justify-between p-4 rounded-lg shadow-md cursor-pointer hover:bg-gray-100"
                     onclick="toggleSection('admin')">
                    <div class="flex items-center space-x-3">
                        📊 <span>Admin</span>
                    </div>
                    <span class="text-gray-400 text-lg transform <%= "admin".equals(openSection) ? "rotate-90" : "" %>">▶</span>
                </div>
                <% if ("admin".equals(openSection)) { %>
                    <ul class="pl-8 mt-2 space-y-2">
                        <li><a href="/admin-dashboard" class="block p-2 rounded-md <%= currentPath.equals("/admin-dashboard") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Admin Dashboard</a></li>
                        <li><a href="/users" class="block p-2 rounded-md <%= currentPath.equals("/users") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Users Page</a></li>
                        <li><a href="/job-posts" class="block p-2 rounded-md <%= currentPath.equals("/job-posts") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Job Posts Page</a></li>
                    </ul>
                <% } %>
            </li>

            <!-- Employer Section -->
            <li>
                <div class="flex items-center justify-between p-4 rounded-lg shadow-md cursor-pointer hover:bg-gray-100"
                     onclick="toggleSection('employer')">
                    <div class="flex items-center space-x-3">
                        💼 <span>Employer</span>
                    </div>
                    <span class="text-gray-400 text-lg transform <%= "employer".equals(openSection) ? "rotate-90" : "" %>">▶</span>
                </div>
                <% if ("employer".equals(openSection)) { %>
                    <ul class="pl-8 mt-2 space-y-2">
                        <li><a href="/employer-dashboard" class="block p-2 rounded-md <%= currentPath.equals("/employer-dashboard") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Employer Dashboard</a></li>
                        <li><a href="/post-job" class="block p-2 rounded-md <%= currentPath.equals("/post-job") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Post a Job</a></li>
                    </ul>
                <% } %>
            </li>

            <!-- Other Sections -->
            <li>
                <a href="/jobs" class="flex items-center p-4 rounded-lg shadow-md <%= currentPath.equals("/jobs") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    💼 <span class="ml-3">Jobs</span>
                </a>
            </li>

            <li>
                <a href="/profile" class="flex items-center p-4 rounded-lg shadow-md <%= currentPath.equals("/profile") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    👤 <span class="ml-3">Profile</span>
                </a>
            </li>

            <li>
                <a href="/employee-dashboard" class="flex items-center p-4 rounded-lg shadow-md <%= currentPath.equals("/employee-dashboard") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    📄 <span class="ml-3">Applications</span>
                </a>
            </li>

            <li>
                <a href="/logout" class="flex items-center p-4 rounded-lg shadow-md text-red-600">
                    🚪 Logout
                </a>
            </li>
        </ul>
    </div>

    <script>
        function toggleSection(section) {
            const openSection = localStorage.getItem("openSection");
            localStorage.setItem("openSection", openSection === section ? "" : section);
            location.reload();
        }
    </script>

</body>
</html>
