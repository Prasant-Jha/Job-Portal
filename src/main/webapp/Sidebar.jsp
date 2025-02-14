<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
    String currentPath = request.getRequestURI();
    String currentPage = currentPath.substring(currentPath.lastIndexOf("/") + 1);
    if (currentPage.contains("?")) {
        currentPage = currentPage.substring(0, currentPage.indexOf("?"));
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
                    <span id="admin-arrow" class="text-gray-400 text-lg transition-transform">▶</span>
                </div>
                <ul id="admin-menu" class="pl-8 mt-2 space-y-2 hidden">
                    <li><a href="AdminDashboard.jsp" class="block p-2 rounded-md <%= currentPage.equals("AdminDashboard.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Admin Dashboard</a></li>
                    <li><a href="UsersPage.jsp" class="block p-2 rounded-md <%= currentPage.equals("UsersPage.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Users Page</a></li>
                    <li><a href="JobPostsPage.jsp" class="block p-2 rounded-md <%= currentPage.equals("JobPostsPage.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Job Posts Page</a></li>
                </ul>
            </li>

            <!-- Employer Section -->
            <li>
                <div class="flex items-center justify-between p-4 rounded-lg shadow-md cursor-pointer hover:bg-gray-100"
                     onclick="toggleSection('employer')">
                    <div class="flex items-center space-x-3">
                        💼 <span>Employer</span>
                    </div>
                    <span id="employer-arrow" class="text-gray-400 text-lg transition-transform">▶</span>
                </div>
                <ul id="employer-menu" class="pl-8 mt-2 space-y-2 hidden">
                    <li><a href="EmployerDashboard.jsp" class="block p-2 rounded-md <%= currentPage.equals("EmployerDashboard.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Employer Dashboard</a></li>
                    <li><a href="PostJob.jsp" class="block p-2 rounded-md <%= currentPage.equals("PostJob.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Post a Job</a></li>
                </ul>
            </li>

            <!-- Other Sections -->
            <li>
                <a href="Job.jsp" class="flex items-center p-4 rounded-lg shadow-md <%= currentPage.equals("Job.jsp") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    💼 <span class="ml-3">Jobs</span>
                </a>
            </li>

            <li>
                <a href="Profile.jsp" class="flex items-center p-4 rounded-lg shadow-md <%= currentPage.equals("Profile.jsp") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    👤 <span class="ml-3">Profile</span>
                </a>
            </li>

            <li>
                <a href="EmployeeDashboard.jsp" class="flex items-center p-4 rounded-lg shadow-md <%= currentPage.equals("EmployeeDashboard.jsp") ? "bg-blue-500 text-white font-bold" : "text-gray-700 hover:text-blue-600" %>">
                    📄 <span class="ml-3">Applications</span>
                </a>
            </li>

            <li>
                <form action="Logout.jsp" method="post">
                    <button type="submit" class="flex items-center p-4 rounded-lg shadow-md text-red-600">
                        🚪 Logout
                    </button>
                </form>
            </li>
        </ul>
    </div>

    <script>
    function toggleSection(section) {
        const sections = ["admin", "employer"];
        let isAnyOpen = false;

        sections.forEach(sec => {
            const menu = document.getElementById(sec + "-menu");
            const arrow = document.getElementById(sec + "-arrow");

            if (sec === section) {
                if (menu.classList.contains("hidden")) {
                    menu.classList.remove("hidden");
                    arrow.classList.add("rotate-90");
                    localStorage.setItem(sec, "open");
                    isAnyOpen = true;
                } else {
                    menu.classList.add("hidden");
                    arrow.classList.remove("rotate-90");
                    localStorage.removeItem(sec);
                }
            } else {
                menu.classList.add("hidden");
                arrow.classList.remove("rotate-90");
                localStorage.removeItem(sec);
            }
        });

        // Check if a submenu item is selected
        const selectedMenuItem = document.querySelector(".bg-blue-500");
        if (!selectedMenuItem) {
            sections.forEach(sec => {
                document.getElementById(sec + "-menu").classList.add("hidden");
                document.getElementById(sec + "-arrow").classList.remove("rotate-90");
                localStorage.removeItem(sec);
            });
        }
    }

    // Restore open sections on page load based on selected menu item
    document.addEventListener("DOMContentLoaded", function () {
        const sections = ["admin", "employer"];
        const selectedMenuItem = document.querySelector(".bg-blue-500");
        let isAnyOpen = false;

        sections.forEach(section => {
            if (localStorage.getItem(section) === "open" && selectedMenuItem) {
                document.getElementById(section + "-menu").classList.remove("hidden");
                document.getElementById(section + "-arrow").classList.add("rotate-90");
                isAnyOpen = true;
            }
        });

        // If no menu item is selected, ensure all menus are closed
        if (!isAnyOpen) {
            sections.forEach(section => {
                localStorage.removeItem(section);
                document.getElementById(section + "-menu").classList.add("hidden");
                document.getElementById(section + "-arrow").classList.remove("rotate-90");
            });
        }
    });

    </script>

</body>
</html>
