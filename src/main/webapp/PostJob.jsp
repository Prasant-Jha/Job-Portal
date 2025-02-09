<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {},
            },
        };
    </script>
</head>
<body class="bg-gray-100">
    
    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-[calc(100vh-80px)]">
        <%@ include file="Sidebar.jsp" %>
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <div class="w-full bg-white p-8 border border-gray-300 rounded-lg shadow-lg">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Post a Job</h2>
                
                <form id="jobForm" action="postJobServlet" method="POST" enctype="multipart/form-data">
                    
                    <label for="jobTitle" class="block font-semibold text-gray-700">Job Title*</label>
                    <input type="text" id="jobTitle" name="jobTitle" placeholder="Enter job title" required
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>

                    <label for="company" class="block font-semibold text-gray-700">Company Name*</label>
                    <input type="text" id="company" name="company" placeholder="Enter company name" required
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>

                    <label for="location" class="block font-semibold text-gray-700">Location*</label>
                    <input type="text" id="location" name="location" placeholder="Enter job location" required
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>

                    <label for="salary" class="block font-semibold text-gray-700">Salary</label>
                    <input type="text" id="salary" name="salary" placeholder="Enter salary (optional)"
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>

                    <label for="jobType" class="block font-semibold text-gray-700">Job Type</label>
                    <select id="jobType" name="jobType"
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4">
                        <option value="Full-time">Full-time</option>
                        <option value="Part-time">Part-time</option>
                        <option value="Contract">Contract</option>
                        <option value="Internship">Internship</option>
                    </select>

                    <label for="description" class="block font-semibold text-gray-700">Job Description*</label>
                    <textarea id="description" name="description" placeholder="Enter job description" required
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"></textarea>

                    <label for="image" class="block font-semibold text-gray-700">Image*</label>
                    <input type="file" id="image" name="image" required
                        class="w-full p-3 border border-gray-300 rounded-lg mb-4"/>

                    <button type="submit"
                        class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700 transition">
                        Post Job
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
