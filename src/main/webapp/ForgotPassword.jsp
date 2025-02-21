<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to Tailwind CSS -->
     <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function sendOTP(event) {
            event.preventDefault();
            var email = document.getElementById("email").value;
            
            if (email.trim() === "") {
                document.getElementById("message").innerText = "Please enter your email.";
                return;
            }

            console.log("Sending OTP to:", email);
            document.getElementById("message").innerText = "OTP has been sent to your email.";

            // Redirect to OTP verification page
            setTimeout(() => {
                window.location.href = "verify-otp.jsp";
            }, 2000);
        }
    </script>
</head>
<body class="flex flex-col items-center min-h-screen bg-gray-100">

    <!-- Upper Section -->
    <div class="w-full h-20 flex items-center justify-between bg-white shadow-md px-20">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
    </div>

    <!-- Forgot Password Container -->
    <div class="w-full max-w-md bg-white shadow-lg rounded-lg p-8 mt-[20vh] border border-gray-200">
        <h2 class="text-2xl font-semibold text-gray-800 text-center">Forgot Password?</h2>
        <p class="text-gray-600 text-center mt-2">Enter your email to receive an OTP.</p>

        <form  action="SendOTPServlet" method="POST" class="mt-6">
            <div class="relative">
                <span class="absolute left-3 top-3 text-gray-400">&#9993;</span>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required
                    class="w-full p-3 pl-10 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
                />
            </div>
            <button
                type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-md mt-4 font-medium shadow-md hover:bg-blue-700 transition">
                Send OTP
            </button>
        </form>

        <p id="message" class="mt-4 text-center text-gray-700"></p>
    </div>

</body>
</html>
