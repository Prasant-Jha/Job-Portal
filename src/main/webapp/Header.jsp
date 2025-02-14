<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

    <div class="w-full h-20 flex items-center justify-between bg-white shadow-md px-20">
        <div class="text-2xl font-bold text-blue-600 cursor-pointer">Jobby</div>
        <p>You are logged in as <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>!</p>
    </div>

</body>
</html>
