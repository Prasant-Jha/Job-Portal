<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Details</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">

    <!-- Header Section -->
    <%@ include file="Header.jsp" %>

    <!-- Main Content -->
    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <!-- Sidebar -->
        <%@ include file="Sidebar.jsp" %>

        <!-- Job Details Section -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <div class="bg-white w-11/12 p-8 border border-gray-300 rounded-lg shadow-lg">
                
                <!-- Job Header -->
                <div class="flex justify-between items-center mb-6">
                    <div class="flex items-center space-x-4">
                        <img src="assets/amazon.png" alt="Company Logo" class="w-20 h-20 object-cover rounded-full border border-gray-300">
                        <div>
                            <h2 class="text-2xl font-bold text-gray-800">Frontend Developer</h2>
                            <p class="text-gray-500">Google - California, USA</p>
                        </div>
                    </div>
                </div>

                <!-- Job Description -->
                <h3 class="text-xl font-semibold text-gray-700 mb-3">Job Description</h3>
                <p class="text-gray-600 leading-relaxed">
                    We are looking for a talented Frontend Developer to join our team. You will be responsible for implementing visual elements that users see and interact with in a web application.
                </p>

                <!-- Requirements -->
                <h3 class="text-xl font-semibold text-gray-700 mt-6 mb-3">Requirements</h3>
                <ul class="list-disc ml-6 text-gray-600 space-y-2">
                    <li>Experience with HTML, CSS, JavaScript</li>
                    <li>Familiarity with React or Angular</li>
                    <li>Good understanding of UI/UX principles</li>
                    <li>Ability to work in a team environment</li>
                </ul>

                <!-- Apply Button -->
                <div class="mt-8 flex justify-center">
                    <a href="ApplyJob.jsp" class="bg-blue-600 text-white px-6 py-3 rounded-lg text-lg font-medium shadow-md hover:bg-blue-700 transition">
                        Apply Now
                    </a>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
