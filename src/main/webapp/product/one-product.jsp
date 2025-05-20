<%@ page import = "com.inventory.product.Product" %>
<%@ page contentType = "text/html;charset=UTF-8" language = "java" %>
<!doctype html>
<html lang = "en">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content = "width=device-width, initial-scale=1">
        <title>Products</title>
        <link href = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel = "stylesheet"
              integrity = "sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
              crossorigin = "anonymous">
    </head>
    <body>
        <%
            Product product = (Product) request.getAttribute("product");
        %>
        <br><br><br>
        <div class = "container text-center">
            <h1>Inventory Management System</h1>
            <h3>Product Management</h3>
            <br><br>
            <div class = "row">
                <div class = "card">
                    <div class = "card-body">
                        <h5 class = "card-title"><%= product.getName() %>
                        </h5>
                        <h6 class = "card-subtitle mb-2 text-body-secondary"><b>#<%= product.getId() %>
                        </b>
                        </h6>
                        <p class = "card-text"><b>Price:</b> $<%=product.getPrice()%>
                        </p>
                        <p class = "card-text"><b>Vendor:</b> <%=product.getVendor()%>
                        </p>
                        <p class = "card-text"><b>Description:</b> <%=product.getDescription()%>
                        </p>
                        <a href = "${pageContext.request.contextPath}/product?action=update&id=<%=product.getId()%>"
                           class = "btn btn-primary">Update Product</a>
                        <a href = "${pageContext.request.contextPath}/product?action=delete&id=<%=product.getId()%>"
                           class = "btn btn-danger">Delete Product</a>
                    </div>
                </div>
            </div>
        </div>

        <script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity = "sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin = "anonymous"></script>
    </body>
</html>
