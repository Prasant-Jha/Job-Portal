<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="styles.css"> <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function resetPassword(event) {
            event.preventDefault();
            
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var messageElement = document.getElementById("message");

            if (password !== confirmPassword) {
                messageElement.innerText = "❌ Passwords do not match!";
                messageElement.classList.add("text-red-600");
                return;
            }

            console.log("Resetting password...");
            messageElement.innerText = "✅ Password reset successful!";
            messageElement.classList.remove("text-red-600");
            messageElement.classList.add("text-green-600");

            // Redirect to login page after a short delay
            setTimeout(() => {
                window.location.href = "login.jsp";
            }, 2000);
        }
    </script>
</head>
<body class="flex flex-col items-center min-h-screen bg-gray-100">

    <!-- Header Section -->
    <div class="w-full h-20 flex items-center justify-between bg-white shadow-md px-20">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
    </div>

    <!-- Reset Password Card -->
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mt-[18vh]">
        <h2 class="text-2xl font-bold text-gray-800 text-center">Reset Password</h2>
        <p class="text-gray-600 text-center mt-2">
            Enter a new password for <strong class="text-blue-600">
                <%= request.getParameter("email") != null ? request.getParameter("email") : "your email" %>
            </strong>
        </p>

        <form action="Login.jsp" class="mt-6 space-y-4">
            <!-- New Password Input -->
            <div class="relative">
                <span class="absolute left-4 top-3 text-gray-500 text-lg">&#128274;</span>
                <input
                    type="password"
                    id="password"
                    placeholder="New Password"
                    required
                    class="w-full p-3 pl-12 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                />
            </div>

            <!-- Confirm Password Input -->
            <div class="relative">
                <span class="absolute left-4 top-3 text-gray-500 text-lg">&#128274;</span>
                <input
                    type="password"
                    id="confirmPassword"
                    placeholder="Confirm Password"
                    required
                    class="w-full p-3 pl-12 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                />
            </div>

            <!-- Reset Password Button -->
            <button
                type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700 transition">
                Reset Password
            </button>
        </form>

        <!-- Message Display -->
        <p id="message" class="mt-4 text-center font-medium"></p>
    </div>

</body>
</html>
