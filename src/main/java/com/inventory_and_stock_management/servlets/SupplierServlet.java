package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.Supplier;
import com.inventory_and_stock_management.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle supplier listing and search functionality.
 */
@WebServlet("/suppliers")
public class SupplierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests to display the list of suppliers.
     * Can also filter suppliers based on search terms.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("search");
        List<Supplier> suppliers = FileHandler.readAllSuppliers(getServletContext());

        // Filter suppliers if search term is provided
        if (searchTerm != null && !searchTerm.isEmpty()) {
            String lowerSearchTerm = searchTerm.toLowerCase();
            suppliers.removeIf(supplier ->
                    !supplier.getName().toLowerCase().contains(lowerSearchTerm) &&
                            !supplier.getCompany().toLowerCase().contains(lowerSearchTerm) &&
                            !supplier.getEmail().toLowerCase().contains(lowerSearchTerm) &&
                            !supplier.getPhone().toLowerCase().contains(lowerSearchTerm)
            );
            request.setAttribute("searchTerm", searchTerm);
        }

        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("/suppliers.jsp").forward(request, response);
    }

    /**
     * Handles POST requests, redirecting to GET by default.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Just redirect to the GET method
        doGet(request, response);
    }
}