<%@ page import="java.util.*, lk.sliit.salesandodermanagement.demo2.SalesOrder" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>View Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
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

        input[type="submit"] {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<h2>All Sales Orders</h2>
<table>
    <tr>
        <th>Order ID</th>
        <th>Customer</th>
        <th>Date</th>
        <th>Item</th>
        <th>Quantity</th>
        <th>Delete</th>
        <th>Update</th>
    </tr>
    <%
        List<SalesOrder> orders = (List<SalesOrder>) request.getAttribute("orders");
        if (orders != null) {
            for (SalesOrder o : orders) {
    %>
    <tr>
        <td><%= o.getOrderId() %></td>
        <td><%= o.getCustomerName() %></td>
        <td><%= o.getDate() %></td>
        <td><%= o.getItem() %></td>
        <td><%= o.getQuantity() %></td>
        <td>
            <form action="delete-order" method="post" style="margin: 0;">
                <input type="hidden" name="orderId" value="<%= o.getOrderId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
        <td>
            <form action="updateOrder.jsp" method="get" style="margin: 0;">
                <input type="hidden" name="action" value="fetch" />
                <input type="hidden" name="orderId" value="<%= o.getOrderId() %>" />
                <input type="submit" value="Update" style="background-color: #28a745;" />
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>
<br/>
<a href="index.jsp">⬅ Back to Home</a>
</body>
</html>
