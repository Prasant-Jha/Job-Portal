<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobby - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="overflow-hidden">

    <!-- Header -->
    <div class="w-full h-[60px] flex items-center bg-gradient-to-r from-blue-500 to-indigo-600">
        <p class="text-white text-[30px] font-bold ml-[15vh]">Jobby</p>
    </div>

    <!-- Main Content -->
    <div class="flex flex-wrap items-center justify-evenly min-h-[92vh] bg-gradient-to-r from-blue-500 to-indigo-600">
        <div class="flex flex-col justify-center space-y-6 text-white max-w-[50%]">
            <h4 class="text-[36px] font-semibold sm:w-3/4 lg:w-2/3 xl:w-3/4">
                Explore our site for a better experience with job searching
            </h4>
            <p class="text-lg sm:w-3/4 md:w-1/2 lg:w-1/3 xl:w-2/3">
                You will surely find your ideal job choice with ease.
            </p>
            <a href="Login.jsp">
                <button class="h-[45px] w-[180px] sm:w-[220px] bg-blue-600 border-2 text-white text-lg font-semibold rounded-md hover:bg-blue-700 transition duration-300">
                    Get Started
                </button>
            </a>
        </div>
        
        <!-- Job Image -->
        <div class="hidden md:block lg:w-1/2 xl:w-1/3 max-w-[40%]">
            <img 
                src="assets/job-image.png" 
                alt="Job search" 
                class="w-[80%] h-auto object-cover rounded-lg shadow-lg transform transition-transform duration-300 hover:scale-105"
            />
        </div>
    </div>

</body>
</html>
