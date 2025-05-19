<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Sales Order Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        a {
            display: inline-block;
            margin: 10px 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h2>Sales and Order Management System</h2>
<a href="createOrder.jsp">Create New Order</a>
<a href="view-orders">View All Orders</a>
</body>
</html>
