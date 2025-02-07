<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add your CSS file -->
</head>
<body class="w-full min-h-screen bg-gray-100">

    <!-- Header Section -->
    <%@ include file="header.jsp" %>

    <!-- Hero Section -->
    <div class="flex w-full h-[calc(100vh-80px)]">
        
        <!-- Sidebar -->
        <%@ include file="sidebar.jsp" %>

        <!-- Job Posts Section -->
        <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-5 space-y-6">
            
            <!-- Define Job Listings in Java -->
            <%
                java.util.List<String> jobs = new java.util.ArrayList<>();
                jobs.add("Frontend Developer - Google - California, USA");
                jobs.add("Backend Developer - Microsoft - Redmond, USA");
                jobs.add("UI/UX Designer - Apple - Cupertino, USA");
                jobs.add("Frontend Developer - Google - California, USA");
                jobs.add("Backend Developer - Microsoft - Redmond, USA");
                jobs.add("UI/UX Designer - Apple - Cupertino, USA");
                request.setAttribute("jobs", jobs); // Set as request attribute
            %>

            <!-- Loop Through Job Listings -->
            <c:forEach var="job" items="${jobs}">
                <!-- Use fn:split directly in output -->
                <c:set var="jobDetails" value="${fn:split(job, ' - ')}" />

                <div class="bg-white w-11/12 p-5 border border-black rounded-md shadow-md transition-all hover:shadow-lg">
                    <div class="text-lg font-semibold">${jobDetails[0]}</div>
                    <div class="text-gray-600 text-sm">${jobDetails[1]}</div>
                    <div class="text-gray-500 text-sm mb-3">${jobDetails[2]}</div>
                    <a href="job-details.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-md inline-block hover:bg-blue-800">View details</a>
                </div>
            </c:forEach>

        </div>
    </div>

</body>
</html>
