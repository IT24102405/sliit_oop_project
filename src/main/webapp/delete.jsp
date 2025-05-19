<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockItem" %>
<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockStack" %>

<%
    int index = Integer.parseInt(request.getParameter("index"));
    StockItem item = StockStack.stockItems.get(index);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Confirm Delete</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fff8f7;
            padding: 40px;
        }
        .card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            width: 400px;
            margin: auto;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card h2 {
            color: #d32f2f;
        }
        .card ul {
            list-style: none;
            padding: 0;
        }
        .card li {
            margin: 10px 0;
        }
        .button-danger {
            background: #d32f2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .button-cancel {
            margin-left: 10px;
            background: #9e9e9e;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Confirm Delete</h2>
    <p>Are you sure you want to delete this item?</p>
    <ul>
        <li><strong>Name:</strong> <%= item.getName() %></li>
        <li><strong>Quantity:</strong> <%= item.getQuantity() %></li>
        <li><strong>Expiry:</strong> <%= item.getExpiryDate() %></li>
    </ul>
    <form action="deleteStock" method="get">
        <input type="hidden" name="index" value="<%= index %>">
        <input class="button-danger" type="submit" value="Yes, Delete">
        <a class="button-danger button-cancel" href="viewStock">Cancel</a>
    </form>
</div>
</body>
</html>
