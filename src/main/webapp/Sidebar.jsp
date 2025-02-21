<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
    String currentPath = request.getRequestURI();
    String currentPage = currentPath.substring(currentPath.lastIndexOf("/") + 1);
    if (currentPage.contains("?")) {
        currentPage = currentPage.substring(0, currentPage.indexOf("?"));
    }

    // Get user role and email from session
   String userRole = (String) session.getAttribute("role");
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

            <%-- Show Admin tab only if the email is "pjha693@rku.ac.in" --%>
            <% if ("admin".equals(userRole)) { %>
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
            <% } %>

            <%-- Show Employer tab only if the user role is "employer" --%>
            <% if ("Employer".equals(userRole)) { %>
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
                    <li><a href="Applicants.jsp" class="block p-2 rounded-md <%= currentPage.equals("Applicants.jsp") ? "bg-blue-500 text-white" : "hover:text-blue-600" %>">Applicants</a></li>
                </ul>
            </li>
            <% } %>

            <!-- Common Sections for All Users -->
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
    			<form action="LogoutServlet" method="get">
        			<button type="submit" class="flex items-center p-4 rounded-lg shadow-md w-full text-gray-700 hover:text-blue-600 hover:bg-gray-100">
            			🚪<span class="ml-3">Logout</span>
        			</button>
    			</form>
			</li>

        </ul>
    </div>

    <script>
    function toggleSection(section) {
        const menu = document.getElementById(section + "-menu");
        const arrow = document.getElementById(section + "-arrow");

        if (!menu || !arrow) return; // Prevent errors if elements are missing

        // Toggle visibility
        const isHidden = menu.classList.contains("hidden");
        document.querySelectorAll(".submenu").forEach(el => el.classList.add("hidden"));
        document.querySelectorAll(".arrow-icon").forEach(el => el.classList.remove("rotate-90"));

        if (isHidden) {
            menu.classList.remove("hidden");
            arrow.classList.add("rotate-90");
            localStorage.setItem(section, "open");
        } else {
            menu.classList.add("hidden");
            arrow.classList.remove("rotate-90");
            localStorage.removeItem(section);
        }
    }

    // Restore open sections on page load
    document.addEventListener("DOMContentLoaded", function () {
        const sections = ["admin", "employer"];
        sections.forEach(section => {
            const menu = document.getElementById(section + "-menu");
            const arrow = document.getElementById(section + "-arrow");

            if (!menu || !arrow) return;

            if (localStorage.getItem(section) === "open") {
                menu.classList.remove("hidden");
                arrow.classList.add("rotate-90");
            }
        });
    });
    </script>

</body>
</html>
