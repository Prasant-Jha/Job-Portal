<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <link rel="stylesheet" href="styles.css"> <!-- Tailwind CSS Link -->
     <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function verifyOTP(event) {
            event.preventDefault();
            var otp = document.getElementById("otp").value;
            
            if (otp.trim().length !== 6) {
                document.getElementById("message").innerText = "❌ Invalid OTP. Try again.";
                document.getElementById("message").classList.add("text-red-600");
                return;
            }

            console.log("Verifying OTP:", otp);
            document.getElementById("message").innerText = "✅ OTP verified successfully!";
            document.getElementById("message").classList.remove("text-red-600");
            document.getElementById("message").classList.add("text-green-600");

            // Redirect to reset password page
            setTimeout(() => {
                window.location.href = "reset-password.jsp";
            }, 2000);
        }
    </script>
</head>
<body class="flex flex-col items-center min-h-screen bg-gray-100">

    <!-- Header Section -->
    <div class="w-full h-20 flex items-center justify-between bg-white shadow-md px-20">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
    </div>

    <!-- OTP Verification Card -->
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md mt-[20vh]">
        <h2 class="text-2xl font-bold text-gray-800 text-center">Verify OTP</h2>
        <p class="text-gray-600 text-center mt-2">
            Enter the OTP sent to <strong class="text-blue-600">
                <%= request.getParameter("email") != null ? request.getParameter("email") : "your email" %>
            </strong>
        </p>

        <form action="ResetPassword.jsp" class="mt-6 space-y-4">
            <div class="relative">
                <span class="absolute left-4 top-3 text-gray-500 text-lg">&#128274;</span>
                <input 
                    type="text"
                    id="otp"
                    placeholder="Enter OTP"
                    required
                    maxlength="6"
                    class="w-full p-3 pl-12 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
                />
            </div>

            <button 
                type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium shadow-md hover:bg-blue-700 transition">
                Verify OTP
            </button>
        </form>

        <p id="message" class="mt-4 text-center font-medium"></p>
    </div>

</body>
</html>
