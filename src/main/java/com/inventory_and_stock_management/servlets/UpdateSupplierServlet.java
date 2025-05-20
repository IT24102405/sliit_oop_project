package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.Supplier;
import com.inventory_and_stock_management.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to handle updating an existing supplier.
 */
@WebServlet("/updateSupplier")
public class UpdateSupplierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests to display the update supplier form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/suppliers");
            return;
        }

        Supplier supplier = FileHandler.findSupplierById(getServletContext(), id);

        if (supplier == null) {
            response.sendRedirect(request.getContextPath() + "/suppliers");
            return;
        }

        request.setAttribute("supplier", supplier);
        request.getRequestDispatcher("/updateSupplier.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to process the update supplier form.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String company = request.getParameter("company");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Validate required fields
        if (id == null || id.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                company == null || company.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty()) {

            request.setAttribute("error", "ID, name, company, and phone are required fields");

            // Recreate the supplier object for the form
            Supplier supplier = new Supplier(id, name, company, phone, email, address);
            request.setAttribute("supplier", supplier);

            request.getRequestDispatcher("/updateSupplier.jsp").forward(request, response);
            return;
        }

        // Create a supplier object with the updated information
        Supplier supplier = new Supplier();
        supplier.setId(id);
        supplier.setName(name);
        supplier.setCompany(company);
        supplier.setPhone(phone);
        supplier.setEmail(email != null ? email : "");
        supplier.setAddress(address != null ? address : "");

        // Update the supplier
        boolean success = FileHandler.updateSupplier(getServletContext(), supplier);

        if (success) {
            request.setAttribute("success", "Supplier updated successfully");
            response.sendRedirect(request.getContextPath() + "/suppliers");
        } else {
            request.setAttribute("error", "Failed to update supplier");
            request.setAttribute("supplier", supplier);
            request.getRequestDispatcher("/updateSupplier.jsp").forward(request, response);
        }
    }
}