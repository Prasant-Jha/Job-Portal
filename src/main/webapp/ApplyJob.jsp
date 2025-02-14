<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Job</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    
    <%@ include file="Header.jsp" %>

    <div class="flex w-full h-screen">
        <%@ include file="Sidebar.jsp" %>

        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            <div class="bg-white w-11/12 p-8 border border-gray-300 rounded-lg shadow-lg">
                <h2 class="text-2xl font-bold text-gray-800 mb-4">Apply for Job</h2>
                <p class="text-lg text-gray-800 mb-4">Upload your resume</p>
                
                <form action="EmployeeDashboard.jsp" method="POST" enctype="multipart/form-data" class="space-y-4">
                    <input 
                        type="file" 
                        name="resume" 
                        required 
                        class="w-full p-2 border border-gray-300 rounded-lg cursor-pointer"
                    />
                    
                    <button 
                        type="submit" 
                        class="bg-blue-600 text-white px-6 py-3 rounded-lg text-lg font-medium shadow-md hover:bg-blue-700 transition w-full"
                        onclick="window.location.href='EmployeeDashboard.jsp'">
                        Submit Application
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
