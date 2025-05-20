<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Supplier</title>
    <link rel="stylesheet" href="css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div class="container">
        <header>
            <h1>Add New Supplier</h1>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="suppliers">Suppliers</a></li>
                    <li><a href="addSupplier" class="active">Add Supplier</a></li>
                    <!-- Add other navigation links as needed -->
                </ul>
            </nav>
        </header>

        <main>
            <%-- Display error messages if any --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <section class="form-container">
                <h2>Supplier Information</h2>

                <form action="addSupplier" method="post" id="supplierForm">
                    <div class="form-group">
                        <label for="name">Name*:</label>
                        <input type="text" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="company">Company*:</label>
                        <input type="text" id="company" name="company" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone*:</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email">
                    </div>

                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="3"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn save-btn">Add Supplier</button>
                        <a href="suppliers" class="btn cancel-btn">Cancel</a>
                    </div>
                </form>
                <p class="required-note">* Required fields</p>
            </section>
        </main>

        <footer>
            <p>&copy; <%= java.time.Year.now().getValue() %> Inventory and Stock Management System</p>
        </footer>
    </div>

    <script src="js/supplierManagement.js"></script>
</body>
</html>