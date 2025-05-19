<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockItem" %>
<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockStack" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    int index = Integer.parseInt(request.getParameter("index"));
    StockItem item = StockStack.stockItems.get(index);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Stock</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            padding: 30px;
        }
        h2 {
            color: #333;
        }
        form {
            background: white;
            padding: 25px;
            border-radius: 8px;
            width: 350px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        input[type="text"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background: #f57c00;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #ef6c00;
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
<h2>Update Stock Item</h2>
<form action="updateStock" method="post">
    <input type="hidden" name="index" value="<%= index %>">
    Name: <input type="text" name="name" value="<%= item.getName() %>" required><br>
    Quantity: <input type="number" name="quantity" value="<%= item.getQuantity() %>" required><br>
    Expiry Date: <input type="date" name="expiry" value="<%= item.getExpiryDate().format(formatter) %>" required><br>
    <input type="submit" value="Update Stock">
</form>
<a href="viewStock"> Back to View</a>
</body>
</html>
