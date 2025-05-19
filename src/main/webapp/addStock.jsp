<!DOCTYPE html>
<html>
<head>
    <title>Add Stock</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
            padding: 30px;
        }
        h2 {
            color: #333;
        }
        form {
            background: white;
            padding: 20px;
            border-radius: 6px;
            width: 300px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background: #388e3c;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #2e7d32;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #1976d2;
        }
    </style>
</head>
<body>
<h2>Add New Stock</h2>
<form action="addStock" method="post">
    Name: <input type="text" name="name" required><br>
    Quantity: <input type="number" name="quantity" required><br>
    Expiry Date: <input type="date" name="expiry" required><br>
    <input type="submit" value="Add Stock">
</form>
<a href="index.jsp"> Back to Home</a>
</body>
</html>
