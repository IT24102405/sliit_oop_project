<%@ page import="lk.sliit.salesandodermanagement.demo2.OrderService" %>
<%@ page import="lk.sliit.salesandodermanagement.demo2.SalesOrder" %>
<%@ page import="jakarta.servlet.ServletContext" %>
<%@ page import="java.io.IOException" %>

<%
    String action = request.getParameter("action");
    String message = "";
    SalesOrder order = null;

    if ("fetch".equals(action)) {
        String orderId = request.getParameter("orderId");
        try {
            ServletContext context = application;
            OrderService orderService = new OrderService(context);
            order = orderService.getOrderById(orderId);
            if (order == null) {
                message = "Order not found with ID: " + orderId;
            }
        } catch (IOException e) {
            message = "Error fetching order: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Order</title>
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
            margin-bottom: 20px;
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

        .message {
            color: red;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<h2>Update Sales Order</h2>

<form method="get">
    <input type="hidden" name="action" value="fetch" />
    <input type="text" name="orderId" placeholder="Enter Order ID to Update" required />
    <input type="submit" value="Fetch Order" />
</form>

<%
    if (order != null) {
%>
<form action="update-order" method="post">
    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>" />
    <input type="text" name="customerName" value="<%= order.getCustomerName() %>" placeholder="Customer Name" required />
    <input type="date" name="date" value="<%= order.getDate() %>" required />
    <input type="text" name="item" value="<%= order.getItem() %>" placeholder="Item" required />
    <input type="number" name="quantity" value="<%= order.getQuantity() %>" placeholder="Quantity" required />
    <input type="submit" value="Update Order" />
</form>
<%
    }
%>

<p class="message"><%= message %></p>

<a href="index.jsp"> Back to Home</a>

</body>
</html>
