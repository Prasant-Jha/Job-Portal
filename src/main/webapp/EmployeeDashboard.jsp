<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="w-full min-h-screen bg-gray-100">
    
    <%-- Header Section --%>
    <jsp:include page="Header.jsp" />

    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <%-- Sidebar --%>
        <jsp:include page="Sidebar.jsp" />
        
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
            
            <h2 class="text-2xl font-bold text-gray-800">Your Applications</h2>
            
            <%-- Check if user has any applications --%>
            <c:if test="${empty userApplications}">
                <p class="text-gray-600">You haven't applied for any jobs yet.</p>
            </c:if>
            
            <%-- Loop through user applications if any exist --%>
            <c:forEach var="app" items="${userApplications}">
                <div class="bg-white w-11/12 p-6 border border-gray-300 rounded-lg shadow-md">
                    <p class="text-gray-700"><strong>Job ID:</strong> ${app.jobId}</p>
                    <p class="text-gray-700"><strong>Resume:</strong> ${app.resumeName}</p>
                    <p class="text-gray-700"><strong>Status:</strong> <span class="text-blue-600">${app.status}</span></p>
                </div>
            </c:forEach>
            
        </div>
    </div>

</body>
</html>
