<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Job Posts</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="w-full min-h-screen">
        <%-- Header Section --%>
        <jsp:include page="Header.jsp" />
        
        <div class="flex w-full h-[calc(100vh-80px)]">
            <%-- Sidebar --%>
            <jsp:include page="Sidebar.jsp" />
            
            <%-- Job Posts Table Section --%>
            <div class="w-3/4 h-full flex flex-col items-center overflow-y-auto py-10 space-y-6 px-8">
                <h2 class="text-3xl font-bold text-gray-800">Manage Job Posts</h2>
                <div class="w-full bg-white p-6 rounded-xl shadow-lg">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="p-3 text-left">Image</th>
                                <th class="p-3 text-left">Job Title</th>
                                <th class="p-3 text-left">Company</th>
                                <th class="p-3 text-left">Location</th>
                                <th class="p-3 text-left">Salary</th>
                                <th class="p-3 text-left">Job Type</th>
                                <th class="p-3 text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                class JobPost {
                                    int id;
                                    String image, title, company, location, salary, jobType;
                                    JobPost(int id, String image, String title, String company, String location, String salary, String jobType) {
                                        this.id = id;
                                        this.image = image;
                                        this.title = title;
                                        this.company = company;
                                        this.location = location;
                                        this.salary = salary;
                                        this.jobType = jobType;
                                    }
                                }

                                List<JobPost> jobPosts = new ArrayList<>();
                                jobPosts.add(new JobPost(1, "https://via.placeholder.com/40", "Software Engineer", "TechCorp", "New York, USA", "$80,000", "Full-Time"));
                                jobPosts.add(new JobPost(2, "https://via.placeholder.com/40", "Product Manager", "Innovate Ltd", "San Francisco, USA", "$100,000", "Part-Time"));
                                jobPosts.add(new JobPost(1, "https://via.placeholder.com/40", "Software Engineer", "TechCorp", "New York, USA", "$80,000", "Full-Time"));
                                jobPosts.add(new JobPost(2, "https://via.placeholder.com/40", "Product Manager", "Innovate Ltd", "San Francisco, USA", "$100,000", "Part-Time"));
                                jobPosts.add(new JobPost(1, "https://via.placeholder.com/40", "Software Engineer", "TechCorp", "New York, USA", "$80,000", "Full-Time"));
                                jobPosts.add(new JobPost(2, "https://via.placeholder.com/40", "Product Manager", "Innovate Ltd", "San Francisco, USA", "$100,000", "Part-Time"));
                                jobPosts.add(new JobPost(1, "https://via.placeholder.com/40", "Software Engineer", "TechCorp", "New York, USA", "$80,000", "Full-Time"));
                                jobPosts.add(new JobPost(2, "https://via.placeholder.com/40", "Product Manager", "Innovate Ltd", "San Francisco, USA", "$100,000", "Part-Time"));
                                jobPosts.add(new JobPost(1, "https://via.placeholder.com/40", "Software Engineer", "TechCorp", "New York, USA", "$80,000", "Full-Time"));
                                jobPosts.add(new JobPost(2, "https://via.placeholder.com/40", "Product Manager", "Innovate Ltd", "San Francisco, USA", "$100,000", "Part-Time"));

                                if (jobPosts.isEmpty()) {
                            %>
                            <tr>
                                <td colspan="7" class="text-center p-4 text-gray-600">No job posts found.</td>
                            </tr>
                            <%
                                } else {
                                    for (JobPost job : jobPosts) {
                            %>
                            <tr class="border-b">
                                <td class="p-3"><img src="<%= job.image %>" alt="Job" class="w-10 h-10 rounded-full" /></td>
                                <td class="p-3"><%= job.title %></td>
                                <td class="p-3"><%= job.company %></td>
                                <td class="p-3"><%= job.location %></td>
                                <td class="p-3"><%= job.salary %></td>
                                <td class="p-3"><%= job.jobType %></td>
                                <td class="p-3 text-center">
                                    <form action="deleteJob.jsp" method="POST">
                                        <input type="hidden" name="jobId" value="<%= job.id %>" />
                                        <button type="submit" class="text-red-600 hover:text-red-800">
                                            &#128465; <!-- Trash icon -->
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
