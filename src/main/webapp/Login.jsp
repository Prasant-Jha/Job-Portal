<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Jobby</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
     <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col items-center min-h-screen">
    
    <header class="w-full flex items-center justify-between px-10 py-4 shadow-md bg-white">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
        <div class="space-x-4">
            <a href="Login.jsp" class="px-6 py-2 border border-blue-600 text-blue-600 rounded-full hover:bg-gray-100">Login</a>
            <a href="Register.jsp" class="px-6 py-2 bg-red-500 text-white rounded-full hover:bg-green-500">Register</a>
        </div>
    </header>
    
    <div class="flex justify-center items-center mt-10 w-3/4">
        <div class="bg-white shadow-lg rounded-lg p-8 w-1/2">
            <h2 class="text-2xl font-semibold mb-6">New to Job-Portal</h2>
            <ul class="space-y-4 text-gray-700">
                <li class="flex items-center"><span class="text-green-500 text-xl mr-2">&#10003;</span> One click apply using Naukri profile.</li>
                <li class="flex items-center"><span class="text-green-500 text-xl mr-2">&#10003;</span> Get relevant job recommendations.</li>
                <li class="flex items-center"><span class="text-green-500 text-xl mr-2">&#10003;</span> Showcase profile to top companies.</li>
                <li class="flex items-center"><span class="text-green-500 text-xl mr-2">&#10003;</span> Know application status on applied jobs.</li>
            </ul>
            <a href="Register.jsp" class="mt-6 inline-block px-6 py-2 border border-blue-600 text-blue-600 rounded-lg hover:bg-gray-100">Register for Free</a>
            <img src="assets/login-img.png" alt="Login" class="w-40 mt-6 mx-auto"/>
        </div>
        
        <div class="bg-white shadow-lg rounded-lg p-8 w-1/3">
            <h2 class="text-2xl font-semibold mb-6 text-center">Login</h2>
            <form action="LoginServlet" method="POST">
                <label class="block text-gray-700 font-semibold">Email ID / Username</label>
                <input type="text" name="email" placeholder="Enter Email ID / Username" class="w-full p-2 mt-2 border rounded-md" required>
                
                <label class="block text-gray-700 font-semibold mt-4">Password</label>
                <input type="password" name="password" placeholder="Enter Password" class="w-full p-2 mt-2 border rounded-md" required>
                
                <a href="ForgotPassword.jsp" class="block text-right text-blue-600 text-sm mt-2">Forgot Password?</a>
                <button type="submit" class="w-full mt-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">Login</button>
            </form>
            
            <div class="flex items-center my-4">
                <div class="flex-grow border-t border-gray-300"></div>
                <span class="px-2 text-gray-500">Or</span>
                <div class="flex-grow border-t border-gray-300"></div>
            </div>
            
            <a href="GoogleLoginServlet" class="w-full flex items-center justify-center py-2 border rounded-md hover:border-black">
                <img src="assets/google.png" alt="Google" class="w-6 mr-2"/> Sign in with Google
            </a>
        </div>
    </div>
</body>
</html>
