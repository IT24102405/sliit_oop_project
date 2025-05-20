<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory_and_stock_management.models.Supplier" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Supplier Management</title>
    <link rel="stylesheet" href="css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="container">
        <header>
            <h1>Supplier Management</h1>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="suppliers" class="active">Suppliers</a></li>
                    <!-- Add other navigation links as needed -->
                </ul>
            </nav>
        </header>

        <main>
            <%-- Display success or error messages if any --%>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <section class="supplier-actions">
                <a href="addSupplier" class="btn add-btn">Add New Supplier</a>

                <form action="suppliers" method="get" class="search-form">
                    <input type="text" name="search" placeholder="Search suppliers..."
                           value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>">
                    <button type="submit" class="btn search-btn">Search</button>
                </form>
            </section>

            <%-- Confirmation modal for delete --%>
            <% if (request.getAttribute("supplierId") != null) { %>
                <div id="deleteModal" class="modal">
                    <div class="modal-content">
                        <h3>Confirm Deletion</h3>
                        <p>Are you sure you want to delete this supplier?</p>
                        <div class="modal-actions">
                            <form action="deleteSupplier" method="post">
                                <input type="hidden" name="id" value="<%= request.getAttribute("supplierId") %>">
                                <button type="submit" class="btn delete-btn">Delete</button>
                            </form>
                            <a href="suppliers" class="btn cancel-btn">Cancel</a>
                        </div>
                    </div>
                </div>
            <% } %>

            <section class="supplier-list">
                <h2>Suppliers List</h2>

                <%
                List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                if (suppliers != null && !suppliers.isEmpty()) {
                %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Company</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Supplier supplier : suppliers) { %>
                                <tr>
                                    <td><%= supplier.getId() %></td>
                                    <td><%= supplier.getName() %></td>
                                    <td><%= supplier.getCompany() %></td>
                                    <td><%= supplier.getPhone() %></td>
                                    <td><%= supplier.getEmail() %></td>
                                    <td><%= supplier.getAddress() %></td>
                                    <td class="actions">
                                        <a href="updateSupplier?id=<%= supplier.getId() %>" class="btn edit-btn">Edit</a>
                                        <a href="deleteSupplier?id=<%= supplier.getId() %>" class="btn delete-btn">Delete</a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p class="no-data">No suppliers found. Please add a new supplier.</p>
                <% } %>
            </section>
        </main>

        <footer>
            <p>&copy; <%= java.time.Year.now().getValue() %> Inventory and Stock Management System</p>
        </footer>
    </div>

    <script src="js/supplierManagement.js"></script>
</body>
</html>