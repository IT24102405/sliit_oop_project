<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="error-container">
        <h2>Error</h2>
        <p class="error-message">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred." %>
        </p>
        <a href="index.jsp">⬅ Back to Home</a>
    </div>

    <style>
        .error-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .error-message {
            color: #f44336;
            margin: 20px 0;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 3px;
        }
    </style>
</body>
</html> 