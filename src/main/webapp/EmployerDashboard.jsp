<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <%-- Header Section --%>
    <jsp:include page="Header.jsp" />

    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <%-- Sidebar --%>
        <jsp:include page="Sidebar.jsp" />
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <h2 class="text-2xl font-bold text-gray-800">Manage Job Applications</h2>
            
            <%-- Static Applications --%>
            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Candidate:</strong> John Doe</p>
                <p class="text-gray-700"><strong>Resume:</strong> john_doe_resume.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-blue-600">Pending</span></p>
                <div class="flex space-x-4 mt-4">
                    <button onclick="updateStatus(101, 'Selected')" class="bg-green-500 text-white px-4 py-2 rounded-md">Select</button>
                    <button onclick="updateStatus(101, 'Pending')" class="bg-yellow-500 text-white px-4 py-2 rounded-md">Pending</button>
                    <button onclick="updateStatus(101, 'Rejected')" class="bg-red-500 text-white px-4 py-2 rounded-md">Reject</button>
                    <a href="resumes/john_doe_resume.pdf" download="john_doe_resume.pdf" class="bg-blue-500 text-white px-4 py-2 rounded-md">Download Resume</a>
                </div>
            </div>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Candidate:</strong> Jane Smith</p>
                <p class="text-gray-700"><strong>Resume:</strong> jane_smith_resume.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-green-600">Selected</span></p>
                <div class="flex space-x-4 mt-4">
                    <button onclick="updateStatus(102, 'Selected')" class="bg-green-500 text-white px-4 py-2 rounded-md">Select</button>
                    <button onclick="updateStatus(102, 'Pending')" class="bg-yellow-500 text-white px-4 py-2 rounded-md">Pending</button>
                    <button onclick="updateStatus(102, 'Rejected')" class="bg-red-500 text-white px-4 py-2 rounded-md">Reject</button>
                    <a href="resumes/jane_smith_resume.pdf" download="jane_smith_resume.pdf" class="bg-blue-500 text-white px-4 py-2 rounded-md">Download Resume</a>
                </div>
            </div>

            <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                <p class="text-gray-700"><strong>Candidate:</strong> Mark Wilson</p>
                <p class="text-gray-700"><strong>Resume:</strong> mark_wilson_resume.pdf</p>
                <p class="text-gray-700"><strong>Status:</strong> <span class="text-red-600">Rejected</span></p>
                <div class="flex space-x-4 mt-4">
                    <button onclick="updateStatus(103, 'Selected')" class="bg-green-500 text-white px-4 py-2 rounded-md">Select</button>
                    <button onclick="updateStatus(103, 'Pending')" class="bg-yellow-500 text-white px-4 py-2 rounded-md">Pending</button>
                    <button onclick="updateStatus(103, 'Rejected')" class="bg-red-500 text-white px-4 py-2 rounded-md">Reject</button>
                    <a href="resumes/mark_wilson_resume.pdf" download="mark_wilson_resume.pdf" class="bg-blue-500 text-white px-4 py-2 rounded-md">Download Resume</a>
                </div>
            </div>

        </div>
    </div>

    <%-- JavaScript function for status update (for demonstration) --%>
    <script>
        function updateStatus(appId, newStatus) {
            console.log(`Updating status of application ${appId} to ${newStatus}`);
        }
    </script>

</body>
</html>
