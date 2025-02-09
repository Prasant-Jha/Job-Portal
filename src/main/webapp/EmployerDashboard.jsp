<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            
            <%-- Check if there are any applications --%>
            <c:if test="${empty applications}">
                <p class="text-gray-600">No applications yet.</p>
            </c:if>
            
            <%-- Loop through applications if available --%>
            <c:forEach var="app" items="${applications}">
                <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                    <p class="text-gray-700"><strong>Candidate:</strong> ${app.userId}</p>
                    <p class="text-gray-700"><strong>Resume:</strong> ${app.resumeName}</p>
                    <p class="text-gray-700"><strong>Status:</strong> <span class="text-blue-600">${app.status}</span></p>
                    <div class="flex space-x-4 mt-4">
                        <%-- Select Button --%>
                        <button 
                            onclick="updateStatus('${app.id}', 'Selected')" 
                            class="bg-green-500 text-white px-4 py-2 rounded-md">
                            Select
                        </button>
                        
                        <%-- Pending Button --%>
                        <button 
                            onclick="updateStatus('${app.id}', 'Pending')" 
                            class="bg-yellow-500 text-white px-4 py-2 rounded-md">
                            Pending
                        </button>
                        
                        <%-- Reject Button --%>
                        <button 
                            onclick="updateStatus('${app.id}', 'Rejected')" 
                            class="bg-red-500 text-white px-4 py-2 rounded-md">
                            Reject
                        </button>
                        
                        <%-- Download Resume Button --%>
                        <a 
                            href="${app.resumeUrl}" 
                            download="${app.resumeName}" 
                            class="bg-blue-500 text-white px-4 py-2 rounded-md flex items-center space-x-2">
                            <i class="text-white fas fa-download"></i>
                            <span>Download Resume</span>
                        </a>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>

    <%-- JavaScript function for status update (example, you can implement the logic on the backend) --%>
    <script>
        function updateStatus(appId, newStatus) {
            // Make an API call to update the status (this needs to be implemented on the server-side)
            console.log(`Updating status of application ${appId} to ${newStatus}`);
        }
    </script>

</body>
</html>
