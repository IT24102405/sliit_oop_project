<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding = "UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Product Form</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px;
                margin: 50px auto;
                background: white;
                padding: 30px 40px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            label {
                display: block;
                margin: 15px 0 5px;
                font-weight: 600;
                color: #555;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
            }

            input[type="submit"] {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 12px 20px;
                font-size: 16px;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 20px;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .error {
                color: #cc0000;
                font-size: 14px;
            }

            .success {
                color: green;
                font-size: 14px;
            }
        </style>

        <script>
            function validateForm() {
                let requiredFields = document.querySelectorAll("input[required], textarea[required], select[required]");
                let valid = true;

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.style.borderColor = "red";
                        valid = false;
                    } else {
                        field.style.borderColor = "#ccc";
                    }
                });

                return valid;
            }
        </script>
    </head>
    <body>
        <div class="container">
        <div class = "row">
            <div class = "col-md-8 offset-md-2">
                <div class = "card">
                    <div class = "card-header">
                        <h4><i class = "fas fa-${empty product ? 'plus' : 'edit'}"></i>
                            ${empty product ? 'Add New Product' : 'Edit Product'}
                        </h4>
                    </div>
                    <div class = "card-body">
                        <form action = "${pageContext.request.contextPath}/products" method = "POST"
                              enctype = "multipart/form-data" onsubmit = "return validateForm()">

                            <input type = "hidden" name = "action" value = "${empty product ? 'create' : 'update'}">
                            <c:if test = "${not empty product}">
                                <input type = "hidden" name = "id" value = "${product.id}">
                            </c:if>

                            <div class = "mb-3">
                                <label for = "name" class = "form-label">Product Name *</label>
                                <input type = "text" class = "form-control" id = "name" name = "name"
                                       value = "${product.name}" required>
                            </div>

                            <div class = "mb-3">
                                <label for = "description" class = "form-label">Description</label>
                                <textarea class = "form-control" id = "description" name = "description"
                                          rows = "3">${product.description}</textarea>
                            </div>

                            <div class = "mb-3">
                                <label for = "category" class = "form-label">Category *</label>
                                <select class = "form-select" id = "category" name = "category" required>
                                    <option value = "">Select Category</option>
                                    <option value = "Electronics" ${product.category == 'Electronics' ? 'selected' : ''}>
                                        Electronics
                                    </option>
                                    <option value = "Clothing" ${product.category == 'Clothing' ? 'selected' : ''}>
                                        Clothing
                                    </option>
                                    <option value = "Books" ${product.category == 'Books' ? 'selected' : ''}>Books
                                    </option>
                                    <option value = "Food" ${product.category == 'Food' ? 'selected' : ''}>Food</option>
                                </select>
                            </div>

                            <div class = "row">
                                <div class = "col-md-6">
                                    <div class = "mb-3">
                                        <label for = "price" class = "form-label">Price *</label>
                                        <div class = "input-group">
                                            <span class = "input-group-text">$</span>
                                            <input type = "number" step = "0.01" class = "form-control" id = "price"
                                                   name = "price" value = "${product.price}" required>
                                        </div>
                                    </div>
                                </div>
                                <div class = "col-md-6">
                                    <div class = "mb-3">
                                        <label for = "quantity" class = "form-label">Quantity *</label>
                                        <input type = "number" class = "form-control" id = "quantity"
                                               name = "quantity" value = "${product.quantity}" required>
                                    </div>
                                </div>
                            </div>

                            <div class = "mb-3">
                                <label for = "image" class = "form-label">Product Image</label>
                                <input type = "file" class = "form-control" id = "image" name = "image"
                                       accept = "image/*">
                                <c:if test = "${not empty product.imageUrl}">
                                    <div class = "mt-2">
                                        <small class = "text-muted">Current image:</small><br>
                                        <img src = "${pageContext.request.contextPath}${product.imageUrl}"
                                             class = "product-image mt-1" alt = "${product.name}">
                                    </div>
                                </c:if>
                            </div>

                            <div class = "text-end">
                                <a href = "${pageContext.request.contextPath}/products" class = "btn btn-secondary">
                                    <i class = "fas fa-times"></i> Cancel
                                </a>
                                <button type = "submit" class = "btn btn-primary">
                                    <i class = "fas fa-save"></i> ${empty product ? 'Create Product' : 'Update Product'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function validateForm() {
                const price = parseFloat(document.getElementById('price').value);
                const quantity = parseInt(document.getElementById('quantity').value);

                if (price <= 0) {
                    alert('Price must be greater than zero');
                    return false;
                }

                if (quantity < 0) {
                    alert('Quantity cannot be negative');
                    return false;
                }

                const fileInput = document.getElementById('image');
                if (fileInput.files.length > 0) {
                    const file = fileInput.files[0];
                    const fileSize = file.size / 1024 / 1024; // Convert to MB
                    if (fileSize > 10) {
                        alert('Image size must be less than 10MB');
                        return false;
                    }

                    const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
                    if (!validTypes.includes(file.type)) {
                        alert('Please upload a valid image file (JPEG, PNG, or GIF)');
                        return false;
                    }
                }

                return true;
            }
        </script>
        </div>
    </body>
</html>