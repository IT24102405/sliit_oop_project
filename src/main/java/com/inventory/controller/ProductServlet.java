package com.inventory.controller;

import com.inventory.model.Product;
import com.inventory.service.ProductService;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.UUID;

@WebServlet("/products/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println(pathInfo);
        
        if (pathInfo == null || pathInfo.equals("/")) {
            String category = request.getParameter("category");
            String search = request.getParameter("search");
            
            if (category != null && !category.isEmpty()) {
                request.setAttribute("products", productService.getProductsByCategory(category));
            } else if (search != null && !search.isEmpty()) {
                request.setAttribute("products", productService.searchProducts(search));
            } else {
                request.setAttribute("products", productService.getAllProducts());
            }
            
            request.setAttribute("lowStock", productService.getLowStockProducts());
            request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
        } else if (pathInfo.equals("/new")) {
            request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            Long id = Long.parseLong(pathInfo.substring(6));
            Product product = productService.getProduct(id);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action) || "update".equals(action)) {
            Product product = new Product();
            if ("update".equals(action)) {
                product.setId(Long.parseLong(request.getParameter("id")));
            }
            
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setCategory(request.getParameter("category"));
            product.setPrice(new BigDecimal(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));

            // Handle image upload
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + getSubmittedFileName(filePart);
                String uploadDir = getServletContext().getRealPath("/uploads");
                String filePath = uploadDir + "/" + fileName;
                filePart.write(filePath);
                product.setImageUrl("/uploads/" + fileName);
            }

            if ("create".equals(action)) {
                productService.createProduct(product);
            } else {
                productService.updateProduct(product);
            }
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            productService.deleteProduct(id);
        }

        response.sendRedirect(request.getContextPath() + "/products");
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
