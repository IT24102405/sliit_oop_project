<%@ page import = "java.util.List" %>
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
            List<Product> products = (List<Product>) request.getAttribute("products");
        %>
        <br><br><br>
        <div class = "container text-center">
            <h1>Inventory Management System</h1>
            <h3>Product Management</h3>
            <br><br>
            <div class = "row">
                <table class = "table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                    <%
                        for (Product product : products) {
                            out.println("<tr>");
                            out.println("<td>" + product.getId() + "</td>");
                            out.println("<td>" + product.getName() + "</td>");
                            out.println("<td>" + product.getPrice() + "</td>");
                            out.println("<td>" +
                                    "<a class=\"btn btn-primary btn-sm\" href=\"" + request.getContextPath() +
                                    "/product?action=view&id=" + product.getId() + "\">View</a></td>");
                            out.println("</tr>");
                        }
                    %>
                </table>
                <br><br>
                <a href = "${pageContext.request.contextPath}/product?action=update">
                    <button type = "button" class = "btn btn-primary btn-sm">Add New Product</button>
                </a>
            </div>
        </div>

        <script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity = "sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin = "anonymous"></script>
    </body>
</html>
