package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.Supplier;
import com.inventory_and_stock_management.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

/**
 * Servlet to handle adding a new supplier.
 */
@WebServlet("/addSupplier")
public class AddSupplierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests to display the add supplier form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/addSupplier.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to process the add supplier form.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String name = request.getParameter("name");
        String company = request.getParameter("company");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
                company == null || company.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Name, company, and phone are required fields");
            request.getRequestDispatcher("/addSupplier.jsp").forward(request, response);
            return;
        }

        // Create a new supplier
        Supplier supplier = new Supplier();
        supplier.setId(UUID.randomUUID().toString().substring(0, 8)); // Generate a unique ID
        supplier.setName(name);
        supplier.setCompany(company);
        supplier.setPhone(phone);
        supplier.setEmail(email != null ? email : "");
        supplier.setAddress(address != null ? address : "");

        // Save the supplier
        boolean success = FileHandler.addSupplier(getServletContext(), supplier);

        if (success) {
            request.setAttribute("success", "Supplier added successfully");
            response.sendRedirect(request.getContextPath() + "/suppliers");
        } else {
            request.setAttribute("error", "Failed to add supplier");
            request.getRequestDispatcher("/addSupplier.jsp").forward(request, response);
        }
    }
}