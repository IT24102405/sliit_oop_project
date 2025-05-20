package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to handle deleting a supplier.
 */
@WebServlet("/deleteSupplier")
public class DeleteSupplierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests to confirm supplier deletion.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/suppliers");
            return;
        }

        request.setAttribute("supplierId", id);
        request.getRequestDispatcher("/suppliers.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to process supplier deletion.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/suppliers");
            return;
        }

        boolean success = FileHandler.deleteSupplier(getServletContext(), id);

        if (success) {
            request.setAttribute("success", "Supplier deleted successfully");
        } else {
            request.setAttribute("error", "Failed to delete supplier");
        }

        response.sendRedirect(request.getContextPath() + "/suppliers");
    }
}