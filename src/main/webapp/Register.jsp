<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <!-- Header Section -->
    <div class="w-full h-20 flex items-center justify-between bg-white shadow-md px-16">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
        <p class="text-lg">
            Already Registered? 
            <a href="Login.jsp" class="font-bold text-blue-600 border-b-2 border-transparent hover:border-green-500">Login</a> here
        </p>
    </div>

    <!-- Main Container -->
    <div class="flex justify-evenly min-h-screen p-10">
        <!-- Benefits Card -->
        <div class="flex flex-col items-center justify-evenly h-[50vh] w-[40vh] bg-white rounded-lg shadow-md p-5">
            <img src="assets/micky.png" alt="Micky" class="h-24 w-20">
            <h3 class="text-lg font-semibold">On registering, you can</h3>
            <ul class="list-none space-y-3">
                <li class="flex items-start"><span class="text-green-600 mr-2 mt-1">✔</span> Build your profile and let recruiters find you</li>
                <li class="flex items-start"><span class="text-green-600 mr-2 mt-1">✔</span> Get job postings delivered to your email</li>
                <li class="flex items-start"><span class="text-green-600 mr-2 mt-1">✔</span> Find a job and grow your career</li>
            </ul>
        </div>

        <!-- Registration Form -->
        <div class="bg-white rounded-lg max-w-2xl w-full p-8 shadow-md">
            <h1 class="text-2xl font-bold mb-2">Create your profile</h1>
            <p class="text-gray-600 text-sm mb-4">Search & apply to jobs from India's No.1 Job Site</p>
            <form action="RegisterServlet" method="POST" class="space-y-4">
                <div>
                    <label class="font-semibold">Full name*</label>
                    <input type="text" name="fullName" placeholder="What is your name?" class="w-full p-2 border rounded mt-1">
                </div>

                <div>
                    <label class="font-semibold">Email ID*</label>
                    <input type="email" name="email" placeholder="Tell us your Email ID" class="w-full p-2 border rounded mt-1">
                    <small class="text-gray-500">We'll send relevant jobs and updates to this email</small>
                </div>

                <div>
                    <label class="font-semibold">Password*</label>
                    <input type="password" name="password" placeholder="(Minimum 6 characters)" class="w-full p-2 border rounded mt-1">
                </div>

                <div>
                    <label class="font-semibold">Mobile number*</label>
                    <div class="flex items-center border rounded overflow-hidden">
                        <span class="bg-gray-200 px-4 py-2">+91</span>
                        <input type="text" name="mobile" placeholder="Enter your mobile number" class="w-full p-2 border-l">
                    </div>
                </div>

                <div>
                    <label class="font-semibold">Role</label>
                    <select name="role" class="w-full p-2 border rounded mt-1">
                        <option value="Job Seeker">Job Seeker</option>
                        <option value="Employer">Employer</option>
                    </select>
                </div>

                <div class="flex items-center">
                    <input type="checkbox" name="updates" id="updates" class="mr-2">
                    <label for="updates" class="text-sm">Send me important updates & promotions via email.</label>
                </div>

                <div class="text-center">
                    <p class="text-sm text-gray-500">By clicking Register, you agree to the <a href="#" class="text-blue-600">Terms and Conditions</a> & <a href="#" class="text-blue-600">Privacy Policy</a></p>
                    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-3">Register now</button>
                </div>
            </form>

            <!-- Google Login -->
            <div class="text-center mt-6 flex justify-center">
                <div>
                    <span class="block text-gray-500 mb-2">Or</span>
                    <button class="flex items-center justify-center gap-2 border px-4 py-2 rounded hover:border-black">
                        <img src="assets/google.png" alt="Google" class="w-6">
                        Continue with Google
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
