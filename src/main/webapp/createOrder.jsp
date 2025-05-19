<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Create Sales Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        form {
            display: inline-block;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        input[type="text"],
        input[type="date"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h2>Create New Sales Order</h2>
<form action="create-order" method="post">
    <input type="text" name="orderId" placeholder="Order ID" required /><br/>
    <input type="text" name="customerName" placeholder="Customer Name" required /><br/>
    <input type="date" name="date" required /><br/>
    <input type="text" name="item" placeholder="Item" required /><br/>
    <input type="number" name="quantity" placeholder="Quantity" required /><br/>
    <input type="submit" value="Create Order" />
</form>
<br/>
<a href="index.jsp">⬅ Back to Home</a>
</body>
</html>
