package com.inventory.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public final class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws IOException, ServletException {
        if (request.getParameter("action") == null) {
            response.sendError(400); // bad request
            return;
        }

        if (request.getParameter("action").equals("list")) {
            request.setAttribute("products", ProductService.getProducts());
            request.getRequestDispatcher("product/all-product.jsp").forward(request, response);
            return;
        }

        if (request.getParameter("action").equals("view")) {
            Product product = ProductService.getProduct(Long.parseLong(request.getParameter("id")));
            request.setAttribute("product", product);
            request.getRequestDispatcher("product/one-product.jsp").forward(request, response);
            return;
        }

        if (request.getParameter("action").equals("update")) {
            if (request.getParameter("id") == null) {
                request.getRequestDispatcher("product/edit-product.jsp").forward(request, response);
                return;
            }

            Product product = ProductService.getProduct(Long.parseLong(request.getParameter("id")));
            request.setAttribute("product", product);
            request.getRequestDispatcher("product/edit-product.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws IOException {
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setVendor(request.getParameter("vendor"));
        product.setDescription(request.getParameter("description"));

        if (request.getParameter("id") == null) {
            ProductService.addProduct(product);
            response.sendRedirect(request.getContextPath() + "/product?action=list");
            return;
        }

        product.setId(Long.parseLong(request.getParameter("id")));
        ProductService.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/product?action=list");
    }
}
