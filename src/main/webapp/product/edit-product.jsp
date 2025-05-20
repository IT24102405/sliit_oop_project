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
            Product product = request.getAttribute("product") == null ? null : (Product) request.getAttribute("product");
        %>
        <br><br><br>
        <div class = "container text-center">
            <h1>Inventory Management System</h1>
            <h3>Product Management</h3>
            <br><br>
            <div class = "row">
                <form action = "${pageContext.request.contextPath}/product" method = "POST">
                    <%
                        if (product != null) {
                            out.println("<input type=\"hidden\" name=\"id\" value=\"" + product.getId() + "\">");
                        }
                    %>
                    <div class = "mb-3">
                        <label for = "name" class = "form-label">Product Name:</label>
                        <input type = "text" class = "form-control" id = "name" name = "name"
                               value = "<%= product == null ? "" : product.getName()%>">
                    </div>
                    <div class = "mb-3">
                        <label for = "price" class = "form-label">Product Price:</label>
                        <input type = "number" class = "form-control" id = "price" name = "price"
                               value = "<%= product == null ? "" : product.getPrice()%>">
                    </div>
                    <div class = "mb-3">
                        <label for = "vendor" class = "form-label">Product Vendor:</label>
                        <input type = "text" class = "form-control" id = "vendor" name = "vendor"
                               value = "<%= product == null ? "" : product.getVendor()%>">
                    </div>
                    <div class = "mb-3">
                        <label for = "description" class = "form-label">Product Description:</label>
                        <textarea class = "form-control" id = "description" name = "description"
                                  rows = "3"><%= product == null ? "" : product.getDescription()%></textarea>
                    </div>
                    <button type = "submit" class = "btn btn-primary">Submit</button>
                </form>
            </div>
        </div>

        <script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity = "sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin = "anonymous"></script>
    </body>
</html>
