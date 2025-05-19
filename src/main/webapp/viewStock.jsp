<%@ page import="java.util.Stack" %>
<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockItem" %>
<%@ page import="lk.sliit.stockmanagement.stockmanagement1.StockStack" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    Stack<StockItem> stack = StockStack.stockItems;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Stock</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f1f1;
            padding: 30px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #1976d2;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        a.button {
            text-decoration: none;
            color: white;
            background: #1976d2;
            padding: 6px 12px;
            border-radius: 4px;
        }
        a.button:hover {
            background: #004ba0;
        }
        .action-buttons a {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<h2>All Stock Items</h2>
<table>
    <tr>
        <th>Name</th>
        <th>Quantity</th>
        <th>Expiry Date</th>
        <th>Actions</th>
    </tr>
    <%
        for (int i = stack.size() - 1; i >= 0; i--) {
            StockItem item = stack.get(i);
    %>
    <tr>
        <td><%= item.getName() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getExpiryDate().format(formatter) %></td>
        <td class="action-buttons">
            <a class="button" href="updateStock.jsp?index=<%= i %>">Edit</a>
            <a class="button" href="delete.jsp?index=<%= i %>">Delete</a>
        </td>
    </tr>
    <%
        }
    %>
</table>
<br>
<a class="button" href="index.jsp"> Back to Home</a>
</body>
</html>
