<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding = "UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Product List</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1000px;
                margin: 50px auto;
                background-color: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 16px;
            }

            th, td {
                text-align: left;
                padding: 12px 15px;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #007BFF;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .btn {
                background-color: #007BFF;
                color: white;
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                text-decoration: none;
                margin-right: 5px;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .btn-danger {
                background-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #a71d2a;
            }
        </style>

        <script>
            function highlightRow(row) {
                row.style.backgroundColor = '#e0f3ff';
            }

            function unhighlightRow(row) {
                row.style.backgroundColor = '';
            }
        </script>
    </head>
    <body>
        <div class = "container">
            <div class = "row">
                <div class = "col-md-12">
                    <div class = "card">
                        <div class = "card-header d-flex justify-content-between align-items-center">
                            <h4 class = "mb-0">
                                <i class = "fas fa-boxes"></i> Products
                            </h4>
                            <a href = "${pageContext.request.contextPath}/products/new" class = "btn btn-primary">
                                <i class = "fas fa-plus"></i> Add New Product
                            </a>
                        </div>
                        <div class = "card-body">
                            <!-- Low Stock Alerts -->
                            <c:if test = "${not empty lowStock}">
                                <div class = "alert alert-warning">
                                    <h5><i class = "fas fa-exclamation-triangle"></i> Low Stock Alert</h5>
                                    <ul class = "mb-0">
                                        <c:forEach items = "${lowStock}" var = "product">
                                            <li>
                                                    ${product.name} - Only ${product.quantity} units remaining
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>

                            <!-- Category Filter -->
                            <div class = "row mb-3">
                                <div class = "col-md-6">
                                    <select class = "form-select" id = "categoryFilter"
                                            onchange = "filterByCategory(this.value)">
                                        <option value = "">All Categories</option>
                                        <option value = "Electronics" ${param.category == 'Electronics' ? 'selected' : ''}>
                                            Electronics
                                        </option>
                                        <option value = "Clothing" ${param.category == 'Clothing' ? 'selected' : ''}>
                                            Clothing
                                        </option>
                                        <option value = "Books" ${param.category == 'Books' ? 'selected' : ''}>Books
                                        </option>
                                        <option value = "Food" ${param.category == 'Food' ? 'selected' : ''}>Food
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <!-- Products Table -->
                            <div class = "table-responsive">
                                <table class = "table table-striped table-hover">
                                    <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items = "${products}" var = "product">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test = "${not empty product.imageUrl}">
                                                        <img src = "${pageContext.request.contextPath}${product.imageUrl}"
                                                             class = "product-image" alt = "${product.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src = "${pageContext.request.contextPath}/resources/images/no-image.png"
                                                             class = "product-image" alt = "No Image">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <strong>${product.name}</strong>
                                                <br>
                                                <small class = "text-muted">${product.description}</small>
                                            </td>
                                            <td>${product.category}</td>
                                            <td>$<fmt:formatNumber value = "${product.price}"
                                                                   pattern = "#,##0.00"/></td>
                                            <td class = "${product.quantity <= 10 ? 'low-stock' : ''}">
                                                    ${product.quantity}
                                            </td>
                                            <td class = "action-buttons">
                                                <a href = "${pageContext.request.contextPath}/products/edit/${product.id}"
                                                   class = "btn btn-sm btn-primary" data-bs-toggle = "tooltip"
                                                   title = "Edit">
                                                    <i class = "fas fa-edit"></i>
                                                </a>
                                                <button onclick = "deleteProduct(${product.id}, '${product.name}')"
                                                        class = "btn btn-sm btn-danger" data-bs-toggle = "tooltip"
                                                        title = "Delete">
                                                    <i class = "fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function filterByCategory(category) {
                    window.location.href = '${pageContext.request.contextPath}/products' +
                        (category ? '?category=' + encodeURIComponent(category) : '');
                }

                function deleteProduct(id, name) {
                    if (confirm('Are you sure you want to delete "' + name + '"?')) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/products';

                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'delete';

                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'id';
                        idInput.value = id;

                        form.appendChild(actionInput);
                        form.appendChild(idInput);
                        document.body.appendChild(form);
                        form.submit();
                    }
                }
            </script>
        </div>
    </body>
</html>